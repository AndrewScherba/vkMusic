//
//  ViewController.m
//  VKMusic
//
//  Created by Andriy Scherba on 6/26/13.
//  Copyright (c) 2013 Andriy Scherba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<VkontakteDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray* _dataSources;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _vkontakte = [Vkontakte sharedInstance];
    _vkontakte.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)loginButtonAction:(id)sender {
    [_vkontakte authenticate];
}
- (IBAction)audioButtonAction:(id)sender {
    [_vkontakte audioWithCallback:^(NSArray *array) {
        _dataSources = array;
        [_tableView reloadData];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)vkontakteDidFailedWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showVkontakteAuthController:(UIViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        controller.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkontakteAuthControllerDidCancelled
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)vkontakteDidFinishLogin:(Vkontakte *)vkontakte
{
     [self dismissViewControllerAnimated:YES completion:nil];
    _loginButton.hidden = YES;
    [[[UIAlertView alloc]initWithTitle:@"Login" message:@"Succesful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
}

- (void)vkontakteDidFinishLogOut:(Vkontakte *)vkontakte
{

}

-(void)loadSongWithDic:(NSDictionary*)dic
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dic[@"mp3url"]]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *err) {
        [self writeToFile:data withName:[NSString stringWithFormat:@"%@-%@.mp3",dic[@"artist"],dic[@"title"]]];
    }];
}
- (void)writeToFile:(NSData *)data withName:(NSString*)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = @"/var/mobile/Music";
	
    // the path to write file
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:name];
                         
    if([data writeToFile:appFile atomically:YES])
        NSLog(@"goood");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSources count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadSongWithDic:_dataSources[indexPath.row]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataSources[indexPath.row][@"title"];
    return cell;
}
@end
