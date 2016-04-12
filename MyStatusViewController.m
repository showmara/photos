//
//  MyStatusViewController.m
//  photos
//
//  Created by s on 16/3/13.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import "MyStatusViewController.h"
#import "loginViewController.h"
#import "TGLGuillotineMenu.h";
@interface MyStatusViewController ()

@end

@implementation MyStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    }

-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    BOOL b =[userDefaultes boolForKey:@"needlogin"];
    if (![userDefaultes boolForKey:@"noNeedlogin"]) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        loginViewController *vc   = (loginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"loginStoryboard"];
        NSArray *viewControllers = self.navigationController.viewControllers;
        TGLGuillotineMenu *rootViewController = (TGLGuillotineMenu *)[viewControllers objectAtIndex:0];
        rootViewController.navigationItem.title = @"登录";
        [rootViewController presentController:vc];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
