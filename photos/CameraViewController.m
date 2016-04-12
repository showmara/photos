//
//  HomeViewController.m
//  LLSimpleCameraExample
//
//  Created by Ömer Faruk Gül on 29/10/14.
//  Copyright (c) 2014 Ömer Faruk Gül. All rights reserved.
//

#import "CameraViewController.h"
#import "ViewUtils.h"
#import "RTImagePickerNavigationController.h"
@interface CameraViewController ()
{
    float _width;
    float _height;
}
@property (strong, nonatomic) LLSimpleCamera *camera;
@property (strong, nonatomic) UILabel *errorLabel;
@property (strong, nonatomic) UIButton *snapButton;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UIButton *flashButton;
@property (strong, nonatomic) UIButton *pickImage;

@property (strong, nonatomic) UIButton *backButton;
@end

@implementation CameraViewController
-(instancetype)initWithScale:(float)width height:(float)height
{
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        _width = width;
        _height = height;
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // ----- initialize camera -------- //
    
    // create camera vc
    self.camera = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPresetHigh
                                                 position:LLCameraPositionRear
                                             videoEnabled:YES];
    
    // attach to a view controller
    [self.camera attachToViewController:self withFrame:CGRectMake(0, 64, screenRect.size.width, screenRect.size.width*_height/_width)];
    
    // read: http://stackoverflow.com/questions/5427656/ios-uiimagepickercontroller-result-image-orientation-after-upload
    // you probably will want to set this to YES, if you are going view the image outside iOS.
    self.camera.fixOrientationAfterCapture = NO;
    
    // take the required actions on a device change
    __weak typeof(self) weakSelf = self;
    [self.camera setOnDeviceChange:^(LLSimpleCamera *camera, AVCaptureDevice * device) {
        
        NSLog(@"Device changed.");
        
        // device changed, check if flash is available
        if([camera isFlashAvailable]) {
            weakSelf.flashButton.hidden = NO;
            
            if(camera.flash == LLCameraFlashOff) {
                weakSelf.flashButton.selected = NO;
            }
            else {
                weakSelf.flashButton.selected = YES;
            }
        }
        else {
            weakSelf.flashButton.hidden = YES;
        }
    }];
    
    [self.camera setOnError:^(LLSimpleCamera *camera, NSError *error) {
        NSLog(@"Camera error: %@", error);
        
        if([error.domain isEqualToString:LLSimpleCameraErrorDomain]) {
            if(error.code == LLSimpleCameraErrorCodeCameraPermission ||
               error.code == LLSimpleCameraErrorCodeMicrophonePermission) {
                
                if(weakSelf.errorLabel) {
                    [weakSelf.errorLabel removeFromSuperview];
                }
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.text = @"We need permission for the camera.\nPlease go to your settings.";
                label.numberOfLines = 2;
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:13.0f];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = NSTextAlignmentCenter;
                [label sizeToFit];
                label.center = CGPointMake(screenRect.size.width / 2.0f, screenRect.size.height / 2.0f);
                weakSelf.errorLabel = label;
                [weakSelf.view addSubview:weakSelf.errorLabel];
            }
        }
    }];
    //------ 蒙版-------//
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screenRect.size.width, screenRect.size.width*_height/_width)];
    UIImage* image = [UIImage imageNamed:@"camera.png"];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    
    
    // ----- camera buttons -------- //
    
    // snap button to capture image
    self.snapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    float f =screenRect.size.height-(screenRect.size.width*7/5+64);
    self.snapButton.frame = CGRectMake(0, 0,60,60);//screenRect.size.height-((screenRect.size.width*7/5)+64+4), screenRect.size.height-((screenRect.size.width*7/5)+64+4));
    self.snapButton.clipsToBounds = YES;
    self.snapButton.layer.cornerRadius = self.snapButton.width / 2.0f;
    self.snapButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.snapButton.layer.borderWidth = 2.0f;
    self.snapButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.snapButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.snapButton.layer.shouldRasterize = YES;
    [self.snapButton addTarget:self action:@selector(snapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.snapButton];
    
    // button to toggle flash
    self.flashButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.flashButton.frame = CGRectMake(0, 0, 16.0f + 20.0f,24.0f + 20.0f);
    self.flashButton.tintColor = [UIColor whiteColor];
    [self.flashButton setImage:[UIImage imageNamed:@"camera-flash.png"] forState:UIControlStateNormal];
    self.flashButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [self.flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.flashButton];
    
    //if([LLSimpleCamera isFrontCameraAvailable] && [LLSimpleCamera isRearCameraAvailable]) {
        // button to toggle camera positions
        self.switchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.switchButton.frame = CGRectMake(200, 200, 29.0f + 20.0f, 22.0f + 20.0f);
        self.switchButton.tintColor = [UIColor whiteColor];
        [self.switchButton setImage:[UIImage imageNamed:@"camera-switch.png"] forState:UIControlStateNormal];
        self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        [self.switchButton addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.switchButton];
    //}
    
//    self.pickImage = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.pickImage.frame = CGRectMake(0, 0, 50.f, 50.0f);
//    self.pickImage.tintColor = [UIColor whiteColor];
//    [self.pickImage setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];
//    self.pickImage.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
//    [self.pickImage addTarget:self action:@selector(imagePick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.pickImage];
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.backButton.frame = CGRectMake(0, 0, 50.f, 50.0f);
        self.backButton.tintColor = [UIColor whiteColor];
        [self.backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        self.backButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        [self.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.backButton];
    
}

- (void)back:(UIButton *)control
{
    NSLog(@"imagePiker");
    [self.camera performSelector:@selector(stop) withObject:nil afterDelay:0.2];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if([(RTImagePickerNavigationController *)self.navigationController toolBarView]) {
//        [[(RTImagePickerNavigationController *)self.navigationController toolBarView] SwitchToMode:RTImagePickerMediaTypeAny];
//    }
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    

    // start the camera
    [self.camera start];
}

/* camera button methods */

- (void)switchButtonPressed:(UIButton *)button
{
    [self.camera togglePosition];
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)flashButtonPressed:(UIButton *)button
{
    if(self.camera.flash == LLCameraFlashOff) {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOn];
        if(done) {
            self.flashButton.selected = YES;
            self.flashButton.tintColor = [UIColor yellowColor];
        }
    }
    else {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOff];
        if(done) {
            self.flashButton.selected = NO;
            self.flashButton.tintColor = [UIColor whiteColor];
        }
    }
}

- (void)snapButtonPressed:(UIButton *)button
{
    __weak typeof(self) weakSelf = self;
    
    //if(self.segmentedControl.selectedSegmentIndex == 0) {
        // capture
        [self.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
            if(!error) {
                
                // We should stop the camera, we are opening a new vc, thus we don't need it anymore.
                // This is important, otherwise you may experience memory crashes.
                // Camera is started again at viewWillAppear after the user comes back to this view.
                // I put the delay, because in iOS9 the shutter sound gets interrupted if we call it directly.
                [camera performSelector:@selector(stop) withObject:nil afterDelay:0.2];
                [self.delegate takePic:image];
                [self dismissViewControllerAnimated:YES completion:^{}];
                //ImageViewController *imageVC = [[ImageViewController alloc] initWithImage:image];
                //[weakSelf presentViewController:imageVC animated:NO completion:nil];
            }
            else {
                NSLog(@"An error has occured: %@", error);
            }
        } exactSeenImage:YES];
        
//    } else {
//        if(!self.camera.isRecording) {
//            self.segmentedControl.hidden = YES;
//            self.flashButton.hidden = YES;
//            self.switchButton.hidden = YES;
//            
//            self.snapButton.layer.borderColor = [UIColor redColor].CGColor;
//            self.snapButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
//            
//            // start recording
//            NSURL *outputURL = [[[self applicationDocumentsDirectory]
//                                 URLByAppendingPathComponent:@"test1"] URLByAppendingPathExtension:@"mov"];
//            [self.camera startRecordingWithOutputUrl:outputURL];
//            
//        } else {
//            self.segmentedControl.hidden = NO;
//            self.flashButton.hidden = NO;
//            self.switchButton.hidden = NO;
//            
//            self.snapButton.layer.borderColor = [UIColor whiteColor].CGColor;
//            self.snapButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
//            
//            [self.camera stopRecording:^(LLSimpleCamera *camera, NSURL *outputFileUrl, NSError *error) {
//                VideoViewController *vc = [[VideoViewController alloc] initWithVideoUrl:outputFileUrl];
//                [self.navigationController pushViewController:vc animated:YES];
//            }];
//       }
//    }
}

/* other lifecycle methods */

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.camera.view.frame = self.view.contentBounds;
    
    self.snapButton.center = self.view.contentCenter;
    self.snapButton.bottom = self.view.height - 15.0f;
    
    self.flashButton.center = self.view.contentCenter;
    self.flashButton.top = 0.f;
    
    self.switchButton.top = 0.f;
    self.switchButton.right = self.view.width - 5.0f;
    
//    self.pickImage.left = 12.0f;
//    self.pickImage.bottom = self.view.height - 15.0f;
    self.backButton.left=5.f;
    self.backButton.top=0.f;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
