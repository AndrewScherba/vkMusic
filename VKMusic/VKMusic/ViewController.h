//
//  ViewController.h
//  VKMusic
//
//  Created by Andriy Scherba on 6/26/13.
//  Copyright (c) 2013 Andriy Scherba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vkontakte.h"
@interface ViewController : UIViewController
{
    
    Vkontakte *_vkontakte;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end
