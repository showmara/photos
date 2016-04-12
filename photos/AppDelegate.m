//
//  AppDelegate.m
//  photos
//
//  Created by s on 16/3/11.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import "AppDelegate.h"
#import "TGLGuillotineMenu.h"
#import "ViewController.h"
#import "SettingViewController.h"
#import "MyStatusViewController.h"
#import "InfoComfirmViewController.h"
@interface AppDelegate ()<TGLGuillotineMenuDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController  *vc01   = [[ViewController alloc] init];
    SettingViewController *vc02   = (SettingViewController*)[storyboard instantiateViewControllerWithIdentifier:@"SettingStoryBoard"];//[[SettingViewController alloc] init];
    //MyStatusViewController  *vc03   = [[MyStatusViewController alloc] init];
    MyStatusViewController *vc03 = (MyStatusViewController*)[storyboard instantiateViewControllerWithIdentifier:@"statusStoryboard"];
    InfoComfirmViewController* vc04 = (InfoComfirmViewController*)[storyboard instantiateViewControllerWithIdentifier:@"infoComfirm"];
//    TGLSampleViewController *vc04   = [[TGLSampleViewController alloc] init];
    
    NSArray *vcArray        = [[NSArray alloc]initWithObjects:vc01,vc02,vc03,vc04, nil];//[[NSArray alloc] initWithObjects:vc01, vc02, vc03, vc04, nil];
    NSArray *titlesArray    = [[NSArray alloc] initWithObjects:@"证件类型", /*@"FEED",*/ @"设置", @"我的信息", @"info",nil];
    NSArray *imagesArray    = [[NSArray alloc] initWithObjects:@"ic_profile", /*@"ic_feed",*/ @"ic_settings", @"ic_activity",@"ic_feed", nil];
    
    TGLGuillotineMenu *menuVC = [[TGLGuillotineMenu alloc] initWithViewControllers:vcArray MenuTitles:titlesArray andImagesTitles:imagesArray andStyle:TGLGuillotineMenuStyleCollection];
    menuVC.delegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:menuVC];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Guillotine Menu Delegate

-(void)selectedMenuItemAtIndex:(NSInteger)index{
    NSLog(@"Selected menu item at index %ld", index);
}

-(void)menuDidOpen{
    NSLog(@"Menu did Open");
}

-(void)menuDidClose{
    NSLog(@"Menu did Close");
}


@end
