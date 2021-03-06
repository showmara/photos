//
//  HomeViewController.h
//  LLSimpleCameraExample
//
//  Created by Ömer Faruk Gül on 29/10/14.
//  Copyright (c) 2014 Ömer Faruk Gül. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSimpleCamera.h"
@protocol TakePicture <NSObject>

-(void)takePic:(UIImage *)image;

@end
@interface CameraViewController : UIViewController
@property id<TakePicture> delegate;
- (instancetype)initWithScale:(float)width height:(float)height;
@end
