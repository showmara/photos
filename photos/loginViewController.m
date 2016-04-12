//
//  loginViewController.m
//  photos
//
//  Created by s on 16/3/16.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import "loginViewController.h"
#import "TGLGuillotineMenu.h"
#import "RegisterViewController.h"
@implementation loginViewController
- (IBAction)register:(id)sender {
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterViewController *vc   = (RegisterViewController*)[storyboard instantiateViewControllerWithIdentifier:@"registerStoryboard"];
    TGLGuillotineMenu *rootViewController = (TGLGuillotineMenu *)[viewControllers objectAtIndex:0];
    rootViewController.navigationItem.title = @"注册";
    [rootViewController presentController:vc];
}
-(void)viewDidLoad
{
//    UIImageView* imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"manIcon"]];
//    self.IDTextField.leftView = imgV;
//    self.IDTextField.leftViewMode = UITextFieldViewModeAlways;
//    imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"passwordIcon"]];
//    self.PasswdTextField.leftView = imgV;
//    self.PasswdTextField.leftViewMode = UITextFieldViewModeAlways;

}
@end
