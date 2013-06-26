//
//  ViewController.m
//  VKMusic
//
//  Created by Andriy Scherba on 6/26/13.
//  Copyright (c) 2013 Andriy Scherba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<VkontakteDelegate> 
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
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)loginButtonAction:(id)sender {
    [_vkontakte authenticate];
}
- (IBAction)audioButtonAction:(id)sender {
    [_vkontakte audioWithCallback:^(NSArray *array) {
        _dataSources = array;
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

@end
