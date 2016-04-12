//
//  ViewController.m
//  photos
//
//  Created by s on 16/3/11.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import "ViewController.h"
#import "RKTabView.h"
#import "LzServiceSvc.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "observer.h"
#import "TGLGuillotineMenu.h"
#import "InfoComfirmViewController.h"
#import "CameraViewController.h"
@interface ViewController ()
{
    observer* o;;
}
@property NSMutableArray* parentInfo;
@property NSMutableArray *BranchInfo;
@property NSMutableArray* PhotoFormat;
@property NSInteger Cardindex;
@property NSInteger TabIndex;
@end

@implementation ViewController
//NSArray *parentInfo;

-(void)operation:(LzServiceHttpBindingOperation *)operation completedWithResponse:(LzServiceHttpBindingResponse *)response
{
    //NSArray *responseHeaders = response.headers;
    NSArray *responseBodyParts = response.bodyParts;
    if (responseBodyParts == nil) {
        
        [self.hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误"
                                                        message:@"请检查网络连接，稍后再试！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }
    for(id bodyPart in responseBodyParts) {
        
        if ([bodyPart isKindOfClass:[SOAPFault class]]) {
            
            [self.hud hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AlertViewTest"
                                                            message:@"message"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OtherBtn",nil];
            [alert show];
            continue;
            
        }
        
        if([bodyPart isKindOfClass:[LzServiceSvc_qryParentPTypeResponse class]]) {
            NSMutableArray* result = [NSMutableArray new];
            LzServiceSvc_qryParentPTypeResponse *body = (LzServiceSvc_qryParentPTypeResponse*)bodyPart;
            NSString *resultMsg = body.resultMsg;
            NSData *myRequestData = [resultMsg dataUsingEncoding:NSUTF8StringEncoding];
            DDXMLDocument* xmldoc = [[DDXMLDocument alloc] initWithData:myRequestData options:0 error:nil];
            NSMutableArray *PT_IDS =[[NSMutableArray alloc]initWithArray: [xmldoc nodesForXPath:@"//PT_ID" error:nil]];
            NSMutableArray *PTNAMES = [[NSMutableArray alloc]initWithArray:[xmldoc nodesForXPath:@"//PTNAME" error:nil]];
            for (NSInteger i = 0; i<[PTNAMES count]; i++) {
                NSLog(@"PTNAME:%@",[PTNAMES[i] stringValue]);
                if ([[PTNAMES[i] stringValue] isEqual:@"测试类型"]) {
                    [PT_IDS removeObjectAtIndex:i];
                    [PTNAMES removeObjectAtIndex:i];
                }
            }
//            for (DDXMLElement* _id in PT_IDS) {
//                [self qryBranchPTypeAsync:[_id stringValue]];
//            }
            [result addObject:PT_IDS];
            [result addObject:PTNAMES];
            self.parentInfo = result;
            for (DDXMLElement* PTID in self.parentInfo[0]) {
                NSArray* temp =[self qryBranchPType:PTID.stringValue];
                for (DDXMLElement* PT in temp[0]) {
                    [self.PhotoFormat addObject:[self qryPFormat:[PT stringValue]]];
                }
                [self.BranchInfo addObject:temp];
            }
            
            [self initView];
            continue;
        }else if([bodyPart isKindOfClass:[LzServiceSvc_qryBranchPTypeResponse class]])
        {
            NSMutableArray* result = [NSMutableArray new];
            LzServiceSvc_qryBranchPTypeResponse *body = (LzServiceSvc_qryBranchPTypeResponse*)bodyPart;
            NSString *resultMsg = body.resultMsg;
            NSLog(@"%@",resultMsg);
            NSData *myRequestData = [resultMsg dataUsingEncoding:NSUTF8StringEncoding];
            DDXMLDocument* xmldoc = [[DDXMLDocument alloc] initWithData:myRequestData options:0 error:nil];
            NSMutableArray *PT_IDS = [[NSMutableArray alloc]initWithArray:[xmldoc nodesForXPath:@"//PT_ID" error:nil]];
            //NSArray *icons = [xmldoc nodesForXPath:@"//PTICON" error:nil];
            NSMutableArray *PTNAMES = [[NSMutableArray alloc]initWithArray:[xmldoc nodesForXPath:@"//PTNAME" error:nil]];
            for (NSInteger i = 0; i<[PTNAMES count]; i++) {
                NSLog(@"PTNAME:%@",[PTNAMES[i] stringValue]);
                if ([[PTNAMES[i] stringValue] isEqual:@"测试子类型"]) {
                    [PT_IDS removeObjectAtIndex:i];
                    [PTNAMES removeObjectAtIndex:i];
                }
            }
            for (DDXMLElement* _id in PT_IDS) {
                [self qryPFormatAsync:[_id stringValue]];
            }
            [result addObject:PT_IDS];
            [result addObject:PTNAMES];
            [self.BranchInfo addObject:result];
            continue;
        }else if([bodyPart isKindOfClass:[LzServiceSvc_qryPFormatResponse class]]) {
            NSMutableArray* result = [NSMutableArray new];
            LzServiceSvc_qryPFormatResponse *body = (LzServiceSvc_qryPFormatResponse*)bodyPart;
            NSString *resultMsg = body.resultMsg;
            NSLog(@"%@",resultMsg);
            NSData *myRequestData = [resultMsg dataUsingEncoding:NSUTF8StringEncoding];
            //NSLog(@"%@",resultMsg);
            DDXMLDocument* xmldoc = [[DDXMLDocument alloc] initWithData:myRequestData options:0 error:nil];
            NSArray *PRINTSIZES = [xmldoc nodesForXPath:@"//PRINTSIZE" error:nil];
            //NSArray *icons = [xmldoc nodesForXPath:@"//PTICON" error:nil];
            NSArray *PIXELS = [xmldoc nodesForXPath:@"//PIXEL" error:nil];
            NSArray *FILESIZES = [xmldoc nodesForXPath:@"//FILESIZE" error:nil];
            NSArray *BGCOLORS = [xmldoc nodesForXPath:@"//BGCOLOR" error:nil];
            for (DDXMLElement *PTID in PRINTSIZES) {
                NSLog(@"PT_ID:%@",PTID);
            }
            //            for (DDXMLElement *PTNAME in PTNAMES) {
            //                NSLog(@"PTNAME:%@",PTNAME);
            //            }
            [result addObject:PRINTSIZES];
            [result addObject:PIXELS];
            [result addObject:FILESIZES];
            [result addObject:BGCOLORS];
            [self.PhotoFormat addObject:result];
            [self initView];
            //            for (DDXMLElement *icon in icons) {
            //                NSLog(@"icon:%@",icon);
            //                NSData* img = [self transStrHexToData:[icon stringValue]];
            ////                UIImage *aimage = [UIImage imageWithData: img];
            ////                self.imageview.image = aimage;
            //            }
            //mMessageTextView.text = [NSString stringWithFormat:@"%@\n%@", mMessageTextView.text, text];
            continue;
        }

//        else if([bodyPart isKindOfClass:[LzServiceSvc_qryBranchPTypeResponse class]]) {
//            NSMutableArray* result = [NSMutableArray new];
//            LzServiceSvc_qryBranchPTypeResponse *body = (LzServiceSvc_qryBranchPTypeResponse*)bodyPart;
//            NSString *resultMsg = body.resultMsg;
//            NSLog(@"%@",resultMsg);
//            NSData *myRequestData = [resultMsg dataUsingEncoding:NSUTF8StringEncoding];
//            //NSLog(@"%@",resultMsg);
//            DDXMLDocument* xmldoc = [[DDXMLDocument alloc] initWithData:myRequestData options:0 error:nil];
//            NSMutableArray *PT_IDS = [[NSMutableArray alloc]initWithArray:[xmldoc nodesForXPath:@"//PT_ID" error:nil]];
//            NSMutableArray *PTNAMES = [[NSMutableArray alloc]initWithArray:[xmldoc nodesForXPath:@"//PTNAME" error:nil]];
//            for (NSInteger i = 0; i<[PTNAMES count]; i++) {
//                NSLog(@"PTNAME:%@",[PTNAMES[i] stringValue]);
//                if ([[PTNAMES[i] stringValue] isEqual:@"测试子类型"]) {
//                    [PT_IDS removeObjectAtIndex:i];
//                    [PTNAMES removeObjectAtIndex:i];
//                }
//            }
//            [result addObject:PT_IDS];
//            [result addObject:PTNAMES];
//            [self.PhotoFormat addObject:result];
//            [self initView];
//            continue;
//        }
    }
}
- (IBAction)button:(id)sender {
    LzServiceHttpBinding* binding = [LzServiceSvc LzServiceHttpBinding];
    LzServiceSvc_qryParentPType *qryParentPType = [LzServiceSvc_qryParentPType new];
    [binding qryParentPTypeAsyncUsingParameters:qryParentPType delegate:self];
}

-(void)initView
{
    
    [self.hud hide:YES];
    
    /******************************/
    
    //tabBar
    RKTabItem *mastercardTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"security"]];
    mastercardTabItem.titleString = [self.parentInfo[1][0] stringValue];
    RKTabItem *paypalTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"driver"]];
    paypalTabItem.titleString = [self.parentInfo[1][1] stringValue];;
    RKTabItem *visaTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"shebao"]];
    visaTabItem.titleString = [self.parentInfo[1][2] stringValue];;
    
    RKTabView *tabView = [[RKTabView alloc] initWithFrame:(CGRectMake(0,[[UIScreen mainScreen] bounds].size.height-54 ,[[UIScreen mainScreen] bounds] .size.width,54))];
    tabView.backgroundColor =[UIColor colorWithRed:213.f / 255.0 green:137.f / 255.f blue:98.f / 255.f alpha:0.5f];
    
    tabView.darkensBackgroundForEnabledTabs = YES;
    tabView.horizontalInsets = HorizontalEdgeInsetsMake(25, 25);
    tabView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    tabView.tabItems = @[mastercardTabItem,paypalTabItem,visaTabItem];
    tabView.delegate =self;
    [self.view addSubview:tabView];
    
    
    
    
    /*ZLSwipeableView
     *
     *
     */
    self.Cardindex = 0;
    self.TabIndex = 0;
    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
    self.swipeableView = swipeableView;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    [bgImgView setImage:[UIImage imageNamed:@"mainBack.jpg"]];
    [self.view addSubview:bgImgView];
    [self.view sendSubviewToBack:bgImgView];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBack.jpg"]];//[UIColor colorWithRed:44.0 / 255.0 green:42.f / 255.f blue:54.f / 255.f alpha:1];
    [self.view addSubview:self.swipeableView];
    // Required Data Source
    self.swipeableView.dataSource = self;
    
    // Optional Delegate
    self.swipeableView.delegate = self;
    
    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *metrics = @{};
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-50-[swipeableView]-50-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-120-[swipeableView]-100-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
}


- (void)viewDidLoad {
    
        self.BranchInfo = [NSMutableArray new];
        self.PhotoFormat = [NSMutableArray new];
    //    [super viewDidLoad];
//    o = [observer new];
//    
/*
 初始化 证件类型
 */
    
//    LzServiceHttpBinding* binding = [LzServiceSvc LzServiceHttpBinding];
//    LzServiceSvc_qryParentPType *qryParentPType = [LzServiceSvc_qryParentPType new];
//    //[binding qryParentPTypeAsyncUsingParameters:qryParentPType delegate:self];
//    [binding qryParentPTypeUsingParameters:qryParentPType];
    
    
    
//    self.parentInfo = [self qryParentPType];
//    self.BranchInfo = [NSMutableArray new];
//    self.PhotoFormat = [NSMutableArray new];
//    for (DDXMLElement* PTID in self.parentInfo[0]) {
//        NSArray* temp =[self qryBranchPType:PTID.stringValue];
//        for (DDXMLElement* PT in temp[0]) {
//            [self.PhotoFormat addObject:[self qryPFormat:[PT stringValue]]];
//        }
//        [self.BranchInfo addObject:temp];
//    }
    [self qryParentPTypeAsync];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"加载中";
    
    /******************************/
    
    //tabBar
//    RKTabItem *mastercardTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"security"]];
//    mastercardTabItem.titleString = [self.parentInfo[1][0] stringValue];
//    RKTabItem *paypalTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"driver"]];
//    paypalTabItem.titleString = [self.parentInfo[1][1] stringValue];;
//    RKTabItem *visaTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"shebao"]];
//    visaTabItem.titleString = [self.parentInfo[1][2] stringValue];;
//    
//    RKTabView *tabView = [[RKTabView alloc] initWithFrame:(CGRectMake(0,[[UIScreen mainScreen] bounds].size.height-54 ,[[UIScreen mainScreen] bounds] .size.width,54))];
//    tabView.backgroundColor =[UIColor colorWithRed:213.f / 255.0 green:137.f / 255.f blue:98.f / 255.f alpha:0.5f];
//    
//    tabView.darkensBackgroundForEnabledTabs = YES;
//    tabView.horizontalInsets = HorizontalEdgeInsetsMake(25, 25);
//    tabView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
//    tabView.tabItems = @[mastercardTabItem,paypalTabItem,visaTabItem];
//    tabView.delegate =self;
//    [self.view addSubview:tabView];
//
//    
//    
//    
///*ZLSwipeableView
// *
// *
//*/
//    self.Cardindex = 0;
//    self.TabIndex = 0;
//    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
//    self.swipeableView = swipeableView;
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
//    [bgImgView setImage:[UIImage imageNamed:@"mainBack.jpg"]];
//    [self.view addSubview:bgImgView];
//    [self.view sendSubviewToBack:bgImgView];
//    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBack.jpg"]];//[UIColor colorWithRed:44.0 / 255.0 green:42.f / 255.f blue:54.f / 255.f alpha:1];
//    [self.view addSubview:self.swipeableView];
//    // Required Data Source
//    self.swipeableView.dataSource = self;
//    
//    // Optional Delegate
//    self.swipeableView.delegate = self;
//    
//    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSDictionary *metrics = @{};
//    
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"|-50-[swipeableView]-50-|"
//                               options:0
//                               metrics:metrics
//                               views:NSDictionaryOfVariableBindings(
//                                                                    swipeableView)]];
//    
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:|-120-[swipeableView]-100-|"
//                               options:0
//                               metrics:metrics
//                               views:NSDictionaryOfVariableBindings(
//                                                                    swipeableView)]];
}


-(void) someButtonClicked{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"您点击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 将十六进制的字符串转化为NSData
- (NSData *)transStrHexToData:(NSString *)strHex
{
    /// bytes索引
    NSUInteger j = 0;
    
    NSInteger len = strHex.length;
    
    if (len % 2 == 1) {
        /// 若不能被2整除则说明16进制的字符串不满足图片图。特此说明，假如只是单纯的把十六进制转换为NSData就把这个if干掉即可，
        return nil;
    }
    
    /// 动态分配内存
    Byte *bytes = (Byte *)malloc((len / 2 + 1) * sizeof(Byte));
    
    /// 初始化内存 其中memset的作用是在一段内存块中填充某个给定的值，它是对较大的结构体或数组进行清零操作的一种最快方法
    memset(bytes, '\0', (len / 2 + 1) * sizeof(Byte));
    
    /// for循环里面其实就是把16进制的字符串转化为字节数组的过程
    for (NSUInteger i = 0; i < strHex.length; i += 2) {
        
        /// 一字节byte是8位(比特)bit 一位就代表一个0或者1(即二进制) 每8位(bit)组成一个字节(Byte) 所以每一次取2为字符组合成一个字节 其实就是2个16进制的字符其实就是8位(bit)即一个字节byte
        NSString *str = [strHex substringWithRange:NSMakeRange(i, 2)];
        
        /// 将16进制字符串转化为十进制
        unsigned long uint_ch = strtoul([str UTF8String], 0, 16);
        
        bytes[j] = uint_ch;
        
        /// 自增
        j ++;
    }
    
    /// 将字节数组转化为NSData
    NSData *data = [[NSData alloc] initWithBytes:bytes length:len / 2];
    
    /// 释放内存
    free(bytes);
    
    return data;
}



- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}
#pragma mark - Action

- (void)handleLeft:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToLeft];
}

- (void)handleRight:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToRight];
}

- (void)handleUp:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToUp];
}

- (void)handleDown:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToDown];
}

- (void)handleReload:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet =
    [[UIActionSheet alloc] initWithTitle:@"Load Cards"
                                delegate:self
                       cancelButtonTitle:@"Cancel"
                  destructiveButtonTitle:nil
                       otherButtonTitles:@"Programmatically", @"From Xib", nil];
    [actionSheet showInView:self.view];
}


#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y,
          translation.x, translation.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    if (self.Cardindex >= [self.BranchInfo[self.TabIndex] count]) {
        self.Cardindex = 0;
    }
    NSString* type;
    NSString* PRINTSIZE;
    NSString* PIXEL;
    NSString* FILESIZE;
    NSString* BGCOLOR;
    if ([self.BranchInfo[self.TabIndex][1] count] <=0) {
        type = @"即将开放";
    }
    else
    {
        type =[self.BranchInfo[self.TabIndex][1][self.Cardindex] stringValue];
        NSInteger count=0;
        for (NSInteger i = 1; i<self.TabIndex; i++) {
            count +=[self.BranchInfo[i] count];
        }
        count+=self.Cardindex;
        PRINTSIZE = [self.PhotoFormat[count][0][0] stringValue];
        PIXEL =[self.PhotoFormat[count][1][0] stringValue];
        FILESIZE  =[self.PhotoFormat[count][2][0] stringValue];
        BGCOLOR =[self.PhotoFormat[count][3][0] stringValue];
    }
    
    
    CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
//    [view addObserver:o
//              forKeyPath:@"delegate"
//                 options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
//                 context:@"this is a context"];

    //view.label.text = @"asdas";//self.BranchInfo[self.TabIndex][self.Cardindex][0];
    view.backgroundColor = [UIColor clearColor];//[self colorForName:self.colors[self.colorIndex]];
    //self.colorIndex++;
    //if (self.loadCardFromXib) {
        UIView *contentView =
        [[NSBundle mainBundle] loadNibNamed:@"CardContentView" owner:self options:nil][0];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
    UILabel* label = [contentView viewWithTag:1];
    label.text = type;
    label = [contentView viewWithTag:100];
    label.text =[NSString stringWithFormat:@"冲印尺寸：%@", PRINTSIZE];
    label = [contentView viewWithTag:101];
    label.text =[NSString stringWithFormat:@"像素大小：%@", PIXEL];
    label = [contentView viewWithTag:102];
    label.text =[NSString stringWithFormat:@"文件大小：%@", FILESIZE];
    label = [contentView viewWithTag:103];
    label.text =[NSString stringWithFormat:@"背景色：%@", BGCOLOR];
    
    UIImageView* previewImage = [contentView viewWithTag:111];
    previewImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [previewImage addGestureRecognizer:singleTap];
    UIButton* button = [contentView viewWithTag:110];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:contentView];
        
        // This is important:
        // https://github.com/zhxnlai/ZLSwipeableView/issues/9
        NSDictionary *metrics =
        @{ @"height" : @(view.bounds.size.height),
           @"width" : @(view.bounds.size.width) };
        NSDictionary *views = NSDictionaryOfVariableBindings(contentView);
        [view addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[contentView(width)]"
                              options:0
                              metrics:metrics
                              views:views]];
        [view addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[contentView(height)]"
                              options:0
                              metrics:metrics
                              views:views]];
    //}
    self.Cardindex+=1;
    
    view.delegate = self;
    return view;
}

#pragma mark - RKTabViewDelegate

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(NSUInteger)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %tu became enabled on tab view", index);
    if (index != self.TabIndex) {
        self.TabIndex = index;
        self.Cardindex = 0;
        [self.swipeableView discardAllViews];
    }
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(NSUInteger)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %tu became disabled on tab view", index);
}



#pragma mark - webServiceMethod
//查询父类型
-(void)qryParentPTypeAsync
{
    
    LzServiceHttpBinding* binding = [LzServiceSvc LzServiceHttpBinding];
    LzServiceSvc_qryParentPType *qryParentPType = [LzServiceSvc_qryParentPType new];
    [binding qryParentPTypeAsyncUsingParameters:qryParentPType delegate:self];
}

- (NSMutableArray*)qryParentPType
{
    NSMutableArray *result = [NSMutableArray new];
    LzServiceHttpBinding* binding = [LzServiceSvc LzServiceHttpBinding];
    LzServiceSvc_qryParentPType *qryParentPType = [LzServiceSvc_qryParentPType new];
    //[binding qryParentPTypeAsyncUsingParameters:qryParentPType delegate:self];
    LzServiceHttpBindingResponse* response = [binding qryParentPTypeUsingParameters:qryParentPType];
    
    NSArray *responseBodyParts = response.bodyParts;
    
    for(id bodyPart in responseBodyParts) {
        
        if ([bodyPart isKindOfClass:[SOAPFault class]]) {
            //
            continue;
        }
        
        if([bodyPart isKindOfClass:[LzServiceSvc_qryParentPTypeResponse class]]) {
            LzServiceSvc_qryParentPTypeResponse *body = (LzServiceSvc_qryParentPTypeResponse*)bodyPart;
            NSString *resultMsg = body.resultMsg;
            NSData *myRequestData = [resultMsg dataUsingEncoding:NSUTF8StringEncoding];
            //NSLog(@"%@",resultMsg);
            DDXMLDocument* xmldoc = [[DDXMLDocument alloc] initWithData:myRequestData options:0 error:nil];
            NSMutableArray *PT_IDS =[[NSMutableArray alloc]initWithArray: [xmldoc nodesForXPath:@"//PT_ID" error:nil]];
            //NSArray *icons = [xmldoc nodesForXPath:@"//PTICON" error:nil];
            NSMutableArray *PTNAMES = [[NSMutableArray alloc]initWithArray:[xmldoc nodesForXPath:@"//PTNAME" error:nil]];
//            for (DDXMLElement *PTID in PT_IDS) {
//                NSLog(@"PT_ID:%@",PTID);
//            }
            for (NSInteger i = 0; i<[PTNAMES count]; i++) {
                NSLog(@"PTNAME:%@",[PTNAMES[i] stringValue]);
                if ([[PTNAMES[i] stringValue] isEqual:@"测试类型"]) {
                    [PT_IDS removeObjectAtIndex:i];
                    [PTNAMES removeObjectAtIndex:i];
                }
            }
            //result = @[PT_IDS,PTNAMES];
            [result addObject:PT_IDS];
            [result addObject:PTNAMES];
//            for (DDXMLElement *icon in icons) {
//                NSLog(@"icon:%@",icon);
//                NSData* img = [self transStrHexToData:[icon stringValue]];
////                UIImage *aimage = [UIImage imageWithData: img];
////                self.imageview.image = aimage;
//            }
            //mMessageTextView.text = [NSString stringWithFormat:@"%@\n%@", mMessageTextView.text, text];
            continue;
        }
    }
    return result;
}
//查询子类型
-(void)qryBranchPTypeAsync:(NSString*)ParentID
{
    LzServiceHttpBinding* binding = [LzServiceSvc LzServiceHttpBinding];
    LzServiceSvc_qryBranchPType *qry = [LzServiceSvc_qryBranchPType new];
    qry.ParentID = ParentID;
    [binding qryBranchPTypeAsyncUsingParameters:qry delegate:self];
}


- (NSMutableArray*)qryBranchPType:(NSString*)ParentID
{
    NSMutableArray *result = [NSMutableArray new];
    LzServiceHttpBinding* binding = [LzServiceSvc LzServiceHttpBinding];
    LzServiceSvc_qryBranchPType *qry = [LzServiceSvc_qryBranchPType new];
    qry.ParentID = ParentID;
    //[binding qryParentPTypeAsyncUsingParameters:qryParentPType delegate:self];
    LzServiceHttpBindingResponse* response = [binding qryBranchPTypeUsingParameters:qry];
    NSArray *responseBodyParts = response.bodyParts;
    for(id bodyPart in responseBodyParts) {
        
        if ([bodyPart isKindOfClass:[SOAPFault class]]) {
            //
            continue;
        }
        
        if([bodyPart isKindOfClass:[LzServiceSvc_qryBranchPTypeResponse class]]) {
            LzServiceSvc_qryBranchPTypeResponse *body = (LzServiceSvc_qryBranchPTypeResponse*)bodyPart;
            NSString *resultMsg = body.resultMsg;
            NSLog(@"%@",resultMsg);
            NSData *myRequestData = [resultMsg dataUsingEncoding:NSUTF8StringEncoding];
            //NSLog(@"%@",resultMsg);
            DDXMLDocument* xmldoc = [[DDXMLDocument alloc] initWithData:myRequestData options:0 error:nil];
            NSMutableArray *PT_IDS = [[NSMutableArray alloc]initWithArray:[xmldoc nodesForXPath:@"//PT_ID" error:nil]];
            //NSArray *icons = [xmldoc nodesForXPath:@"//PTICON" error:nil];
            NSMutableArray *PTNAMES = [[NSMutableArray alloc]initWithArray:[xmldoc nodesForXPath:@"//PTNAME" error:nil]];
            //            for (DDXMLElement *PTID in PT_IDS) {
            //                NSLog(@"PT_ID:%@",PTID);
            //            }
            for (NSInteger i = 0; i<[PTNAMES count]; i++) {
//                if[PTNAMES[i] stringValue] == @"测试类型"
//                {
//                    
//                }
                NSLog(@"PTNAME:%@",[PTNAMES[i] stringValue]);
                if ([[PTNAMES[i] stringValue] isEqual:@"测试子类型"]) {
                    [PT_IDS removeObjectAtIndex:i];
                    [PTNAMES removeObjectAtIndex:i];
                }
            }
            [result addObject:PT_IDS];
            [result addObject:PTNAMES];
            //            for (DDXMLElement *icon in icons) {
            //                NSLog(@"icon:%@",icon);
            //                NSData* img = [self transStrHexToData:[icon stringValue]];
            ////                UIImage *aimage = [UIImage imageWithData: img];
            ////                self.imageview.image = aimage;
            //            }
            //mMessageTextView.text = [NSString stringWithFormat:@"%@\n%@", mMessageTextView.text, text];
            continue;
        }
    }
    return result;
}
//查询子类型附加信息类型
- (void)qryBranchExtraType:(NSString*)TypeID
{
}
//查询版式要求信息
-(void)qryPFormatAsync:(NSString*)TypeID
{
    LzServiceHttpBinding* binding = [LzServiceSvc LzServiceHttpBinding];
    LzServiceSvc_qryPFormat *qry = [LzServiceSvc_qryPFormat new];
    qry.TypeID = TypeID;
    [binding qryPFormatAsyncUsingParameters:qry delegate:self];

}


- (NSMutableArray*)qryPFormat:(NSString*)TypeID
{
    NSMutableArray *result = [NSMutableArray new];
    LzServiceHttpBinding* binding = [LzServiceSvc LzServiceHttpBinding];
    LzServiceSvc_qryPFormat *qry = [LzServiceSvc_qryPFormat new];
    qry.TypeID = TypeID;
    LzServiceHttpBindingResponse* response = [binding qryPFormatUsingParameters:qry];
    NSArray *responseBodyParts = response.bodyParts;
    for(id bodyPart in responseBodyParts) {
        
        if ([bodyPart isKindOfClass:[SOAPFault class]]) {
            //
            continue;
        }
        
        if([bodyPart isKindOfClass:[LzServiceSvc_qryPFormatResponse class]]) {
            LzServiceSvc_qryPFormatResponse *body = (LzServiceSvc_qryPFormatResponse*)bodyPart;
            NSString *resultMsg = body.resultMsg;
            NSLog(@"%@",resultMsg);
            NSData *myRequestData = [resultMsg dataUsingEncoding:NSUTF8StringEncoding];
            //NSLog(@"%@",resultMsg);
            DDXMLDocument* xmldoc = [[DDXMLDocument alloc] initWithData:myRequestData options:0 error:nil];
            NSArray *PRINTSIZES = [xmldoc nodesForXPath:@"//PRINTSIZE" error:nil];
            //NSArray *icons = [xmldoc nodesForXPath:@"//PTICON" error:nil];
            NSArray *PIXELS = [xmldoc nodesForXPath:@"//PIXEL" error:nil];
            NSArray *FILESIZES = [xmldoc nodesForXPath:@"//FILESIZE" error:nil];
            NSArray *BGCOLORS = [xmldoc nodesForXPath:@"//BGCOLOR" error:nil];
                        for (DDXMLElement *PTID in PRINTSIZES) {
                            NSLog(@"PT_ID:%@",PTID);
                        }
//            for (DDXMLElement *PTNAME in PTNAMES) {
//                NSLog(@"PTNAME:%@",PTNAME);
//            }
            [result addObject:PRINTSIZES];
            [result addObject:PIXELS];
            [result addObject:FILESIZES];
            [result addObject:BGCOLORS];
            //            for (DDXMLElement *icon in icons) {
            //                NSLog(@"icon:%@",icon);
            //                NSData* img = [self transStrHexToData:[icon stringValue]];
            ////                UIImage *aimage = [UIImage imageWithData: img];
            ////                self.imageview.image = aimage;
            //            }
            //mMessageTextView.text = [NSString stringWithFormat:@"%@\n%@", mMessageTextView.text, text];
            continue;
        }
    }
    return result;

}
#pragma mark - cardclick
-(void)click:(id)sender
{
//    NSLog(@"%@",@"delegate Clicked");
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;//设置类型为相机
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
//        picker.delegate = self;//设置代理
//        picker.allowsEditing = YES;//设置照片可编辑
//        picker.sourceType = sourceType;
//        //picker.showsCameraControls = NO;//默认为YES
//        //创建叠加层
//        UIView *overLayView=[[UIView alloc]initWithFrame:CGRectMake(0, 120, 320, 254)];
//        //取景器的背景图片，该图片中间挖掉了一块变成透明，用来显示摄像头获取的图片；
//        UIImage *overLayImag=[UIImage imageNamed:@"zhaoxiangdingwei.png"];
//        UIImageView *bgImageView=[[UIImageView alloc]initWithImage:overLayImag];
//        [overLayView addSubview:bgImageView];
//        picker.cameraOverlayView=overLayView;
//        picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;//选择前置摄像头或后置摄像头
//        [self presentViewController:picker animated:YES completion:^{
//        }];
//    }
//    else {
//        NSLog(@"该设备无相机");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"该设备无相机！"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
    
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InfoComfirmViewController *vc   = (InfoComfirmViewController*)[storyboard instantiateViewControllerWithIdentifier:@"infoComfirm"];
    
//    CameraViewController* vc = [[CameraViewController alloc] initWithScale:5.0 height:7.0];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    TGLGuillotineMenu *rootViewController = (TGLGuillotineMenu *)[viewControllers objectAtIndex:0];
    rootViewController.navigationItem.title = @"制作照片";
    [rootViewController presentController:vc];
    /*UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }
    
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"该设备无相机！"
                                                        delegate:self
                                                        cancelButtonTitle:@"确定"
                                                        otherButtonTitles:nil];
        [alert show];
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];*/
}
#pragma mark - actionsheetDelegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
//    isFullScreen = NO;
//    [self.imageView setImage:savedImage];
//    
//    self.imageView.tag = 100;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

@end
