//
//  InfoComfirmViewController.m
//  photos
//
//  Created by s on 16/3/14.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import "InfoComfirmViewController.h"
#import <JVFloatLabeledTextField.h>
#import "CameraViewController.h"
#import "CaptureViewController.h"
#import "RTImagePickerViewController.h"
#import "ImageClips.h"

@interface InfoComfirmViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TakePicture,PassImageDelegate,RTImagePickerViewControllerDelegate>
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *nameTextView;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) IBOutlet UIImageView *previewImageView;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *IDTextView;

@end

@implementation InfoComfirmViewController
- (IBAction)nameTextView:(id)sender {
}
- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        _image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameTextView.delegate = self;
    self.IDTextView.delegate = self;
    self.nameTextView.returnKeyType = UIReturnKeyNext;
    self.IDTextView.returnKeyType = UIReturnKeyDefault;
    [self.nameTextView addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.IDTextView addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    self.previewImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage)];
    [self.previewImageView addGestureRecognizer:singleTap];
    if (_image!=nil) {
        [self.previewImageView setImage:_image];
    }
}

- (void)addImage
{
    
    RTImagePickerViewController *imagePickerController = [RTImagePickerViewController new];
    imagePickerController.delegate = self;
    imagePickerController.mediaType = RTImagePickerMediaTypeImage;
    imagePickerController.allowsMultipleSelection = NO;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    imagePickerController.maximumNumberOfSelection = 9;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
    }];
    //UIActionSheet *sheet;
//     // 判断是否支持相机
//     if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//     
//     {
     //sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
     
//     }
//     
//     else {
//     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//     message:@"该设备无相机！"
//     delegate:self
//     cancelButtonTitle:@"确定"
//     otherButtonTitles:nil];
//     [alert show];
//     sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
//     
//     }
    
//     sheet.tag = 255;
//     
//    [sheet showInView:self.view];
}
#pragma mark - actionsheetDelegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        //if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    //sourceType = UIImagePickerControllerSourceTypeCamera;
                    {
                    CameraViewController* vc = [[CameraViewController alloc]initWithScale:5.0 height:7.0];
                        vc.delegate = self;
                    [self presentViewController:vc animated:YES completion:^{}];
                    }
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                    
                    imagePickerController.delegate = self;
                    
                    imagePickerController.allowsEditing = YES;
                    
                    imagePickerController.sourceType = sourceType;
                    
                    [self presentViewController:imagePickerController animated:YES completion:^{}];
                    break;
            }
        //}
//        else {
//            if (buttonIndex == 0) {
//                
//                return;
//            } else {
//                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//            }
//        }
        // 跳转到相机或相册页面
        
    }
}
#pragma mark - take picture delegte
-(void)takePic:(UIImage *)image
{
    [self.previewImageView setImage:image];
}
#pragma mark - pass image delegte
-(void)passImage:(UIImage *)image
{
    [self.previewImageView setImage:image];
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
    //[self saveImage:image withName:@"currentImage.png"];
    
    //NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    //UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
        //isFullScreen = NO;
    
     //   [self.previewImageView setImage:savedImage];
    
      //  self.previewImageView.tag = 100;
    CaptureViewController* vc = [[CaptureViewController alloc]initWithImage:image width:5.f height:7.f];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:^{}];
    
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //上移30个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,-100,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    return YES;
}

-(void)resumeView
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //如果当前View是父视图，则Y为20个像素高度，如果当前View为其他View的子视图，则动态调节Y的高度
    float Y = 20.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}


//隐藏键盘的方法
-(void)hidenKeyboard
{
    [self.nameTextView resignFirstResponder];
    [self.IDTextView resignFirstResponder];
    [self resumeView];
}

//点击键盘上的Return按钮响应的方法
-(IBAction)nextOnKeyboard:(UITextField *)sender
{
    if (sender == self.nameTextView) {
        [self.IDTextView becomeFirstResponder];
    }else if (sender == self.IDTextView){
        [self hidenKeyboard];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)rt_imagePickerController:(RTImagePickerViewController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    NSLog(@"%@", assets[0]);
    __block UIImage *ima;
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions* imageRequestOptions = [PHImageRequestOptions new];
    imageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    imageRequestOptions.deliveryMode =PHImageRequestOptionsDeliveryModeHighQualityFormat;
    imageRequestOptions.synchronous = true;
    [manager requestImageForAsset:assets[0]
                       targetSize:PHImageManagerMaximumSize
                      contentMode:PHImageContentModeDefault
                          options:imageRequestOptions
                    resultHandler:^void(UIImage *image, NSDictionary *info) {
                        ima = image;
                        //[self.previewImageView setImage:ima];
                        //[images addObject:ima];
                    }];
        ImageClips *img = [[ImageClips alloc] init];
    [img setReturnBlock:^(UIImage* image){
        [self.previewImageView setImage:image];
    } image:ima control:7.0f/5.f];
    
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:img animated:YES completion:nil];
    }];

}
- (void)rt_imagePickerController:(RTImagePickerViewController *)imagePickerController didFinishPickingImages:(NSArray<UIImage *> *)images
{
    ImageClips *img = [[ImageClips alloc] init];
    [img setReturnBlock:^(UIImage* image){
        [self.previewImageView setImage:image];
    } image:images[0] control:7.0f/5.f];
    
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:img animated:YES completion:nil];
    }];
    
}
- (void)rt_imagePickerController:(RTImagePickerViewController *)imagePickerController didFinishPickingVideoWithFileName:(NSString *)fileName withCaptureImage:(UIImage *)image
{
}
- (void)rt_imagePickerControllerDidCancel:(RTImagePickerViewController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:^{}];
}


@end
