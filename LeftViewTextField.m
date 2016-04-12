//
//  LeftViewTextField.m
//  photos
//
//  Created by s on 16/3/19.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import "LeftViewTextField.h"

@implementation LeftViewTextField
-(void)setLeftViewImage:(UIImage *)leftViewImage
{
    UIImageView* PhoneLeftView = [[UIImageView alloc]initWithImage:leftViewImage];
    self.frame = CGRectMake(0, 0, 25, 25);
    self.leftView = PhoneLeftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x +=10;
    return textRect;
}
@end
