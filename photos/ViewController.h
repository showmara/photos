//
//  ViewController.h
//  photos
//
//  Created by s on 16/3/11.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LzServiceSvc.h"
#import <ZLSwipeableView.h>
#import <RKTabView.h>
#import "CardView.h"
#import <MBProgressHUD.h>
@interface ViewController : UIViewController <LzServiceHttpBindingResponseDelegate,NSXMLParserDelegate,ZLSwipeableViewDataSource, ZLSwipeableViewDelegate,RKTabViewDelegate,clickDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) ZLSwipeableView *swipeableView;
@property MBProgressHUD* hud;
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;

@end

