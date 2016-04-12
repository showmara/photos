//
//  SettingViewController.m
//  photos
//
//  Created by s on 16/3/13.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import "SettingViewController.h"
#import "TGLGuillotineMenu.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *viewControllers = self.navigationController.viewControllers;
    TGLGuillotineMenu *rootViewController = (TGLGuillotineMenu *)[viewControllers objectAtIndex:0];
    //[rootViewController removeCurrentViewController];

    // Do any additional setup after loading the view.
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
