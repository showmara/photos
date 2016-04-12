//
//  CaptureViewController.m
//  photos
//
//  Created by s on 16/3/16.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import "CaptureViewController.h"

@implementation CaptureViewController
-(instancetype)initWithImage:(UIImage *)image width:(float)width height:(float)height
{
    self = [super init];
    if (self) {
        _image = image;
        _width = width;
        _height = height;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加导航栏和完成按钮
    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 44)];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"patternNav.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:naviBar];
    UINavigationItem *naviItem = [[UINavigationItem alloc] initWithTitle:@"图片裁剪"];
    [naviBar pushNavigationItem:naviItem animated:YES];
    
    //保存按钮
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(saveButton)];
    naviItem.rightBarButtonItem = doneItem;
    
    //image为上一个界面传过来的图片资源
    editorView = [[AGSimpleImageEditorView alloc] initWithImage:_image];
    editorView.frame = CGRectMake(0, 0, self.view.frame.size.width ,  self.view.frame.size.width);
    editorView.center = self.view.center;
    
    //外边框的宽度及颜色
    editorView.borderWidth = 1.f;
    editorView.borderColor = [UIColor blackColor];
    
    //截取框的宽度及颜色
    editorView.ratioViewBorderWidth = 5.f;
    editorView.ratioViewBorderColor = [UIColor orangeColor];
    
    //截取比例，我这里按正方形1:1截取（可以写成 3./2. 16./9. 4./3.）
    editorView.ratio = _width/_height;
    
    [self.view addSubview:editorView];
}

//完成截取
-(void)saveButton
{
    //output为截取后的图片，UIImage类型
    UIImage *resultImage = editorView.output;
    
    //通过代理回传给上一个界面显示
    [self.delegate passImage:resultImage];
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
