//
//  CaptureViewController.h
//  photos
//
//  Created by s on 16/3/16.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGSimpleImageEditorView.h"
@protocol PassImageDelegate <NSObject>

-(void)passImage:(UIImage *)image;

@end
@interface CaptureViewController : UIViewController
{
    AGSimpleImageEditorView *editorView;
    UIImage* _image;
    float _width;
    float _height;
}
@property id<PassImageDelegate> delegate;
-(instancetype)initWithImage:(UIImage*)image width:(float)width height:(float)height;
@end
