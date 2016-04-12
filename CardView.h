//
//  CardView.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol clickDelegate
@optional
-(void)click:(id)sender;
@end
@interface CardView : UIView
{
    id <clickDelegate> _delegate;
}
@property (strong)id<clickDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *previewImage;
@property (strong, nonatomic) IBOutlet UILabel *label;
@end
