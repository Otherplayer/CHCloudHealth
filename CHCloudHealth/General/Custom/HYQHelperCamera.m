//
//  HYQHelperCamera.m
//  HYQuan
//
//  Created by fqah on 12/9/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import "HYQHelperCamera.h"
//#import "DNImagePickerController.h"
#import "AppDelegate.h"
#import <objc/runtime.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>
//#import "DNAsset.h"
//#import <Photos/Photos.h>

//#import "AVViewController.h"
#import "UIImage+Orientation.h"


static const char HYQCameraDidFinishPickerImage;
static const char HYQCameraDidFinishPickerVideo;
static const char HYQCustomCameraDidFinishPickerResult;

typedef NS_ENUM(NSUInteger, SelectResultType) {
    SelectResultType_Image,
    SelectResultType_AssertUrl,
    SelectResultType_AssertUrlArr,
    SelectResultType_filePath,
    SelectResultType_Other,
};
typedef NS_ENUM(NSUInteger, HYQCameraType) {
    HYQCameraTypeSingleSelectPhoto,
    HYQCameraTypeMutilSelectPhotos,
    HYQCameraTypeSingleSelectVideo,
    HYQCameraTypeOther,
};

typedef NS_ENUM(NSUInteger, CustomCameraPickerType) {
    CustomCameraPickerType_Single,// 拍照、从相册选择（单选）
    CustomCameraPickerType_Mutil, // 拍照、从相册选择（多选）
    CustomCameraPickerType_Video, // 视频、拍照、从相册选择（多选）
};


@interface HYQHelperCamera ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) BOOL isMutableSelected;     //进入相册是否多选
@property (nonatomic, assign) NSInteger maxSelectedNumber;//照片最大选择数量
@property (assign,nonatomic) HYQCameraType cameraType;//是否录制视频，如果为1表示录制视频，0代表拍照
@property (assign,nonatomic) SelectResultType selectResultType;
@property (assign,nonatomic) CustomCameraPickerType customCameraPickerType;
@end

#define kFromPhotoLibrary  @"从相册选择"
#define kCamera            @"相机"
#define kVideoRecord       @"视频录制"

@implementation HYQHelperCamera

+ (instancetype)sharedInstance{
    static HYQHelperCamera *camera = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        camera = [[HYQHelperCamera alloc] init];
        camera.maxSelectedNumber = 9;
        camera.items = [[NSMutableArray alloc] init];
    });
    return camera;
}


#pragma mark - Public


- (void)showCustomCameraPickerWithResultBlock:(void (^)(UIImage *image))resultBlock{
    [self setCustomCameraPickerType:CustomCameraPickerType_Single];
    [self.items removeAllObjects];
    
    BOOL isCameraAvailable = [self isCameraAvailable];
    BOOL isPhotoLibraryAvailable = [self isPhotoLibraryAvailable];
    
    if (isCameraAvailable) {
        [self.items addObject:kCamera];
    }
    if (isPhotoLibraryAvailable) {
        [self.items addObject:kFromPhotoLibrary];
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSString *itemTitle in self.items) {
        [actionSheet addButtonWithTitle:itemTitle];
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [actionSheet setDelegate:self];
    [actionSheet showInView:window];
    
    objc_setAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult, resultBlock, OBJC_ASSOCIATION_COPY);
}

- (void)showCustomMutilCameraPickerWithMaxSelectNumber:(NSInteger)maxNumber resultBlock:(void (^)(NSArray *imageAssetUrls))resultBlock{
    [self setMaxSelectedNumber:maxNumber];
    [self setCustomCameraPickerType:CustomCameraPickerType_Mutil];
    [self.items removeAllObjects];
    
    BOOL isCameraAvailable = [self isCameraAvailable];
    BOOL isPhotoLibraryAvailable = [self isPhotoLibraryAvailable];
    
    if (isCameraAvailable) {
        [self.items addObject:kCamera];
    }
    if (isPhotoLibraryAvailable) {
        [self.items addObject:kFromPhotoLibrary];
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSString *itemTitle in self.items) {
        [actionSheet addButtonWithTitle:itemTitle];
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [actionSheet setDelegate:self];
    [actionSheet showInView:window];
    
    objc_setAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult, resultBlock, OBJC_ASSOCIATION_COPY);

}

- (void)showCustomVideoCameraPickerWithMaxSelectNumber:(NSInteger)maxNumber resultBlock:(void (^)(NSArray *infoArr))resultBlock{
    [self setMaxSelectedNumber:maxNumber];
    [self setCustomCameraPickerType:CustomCameraPickerType_Video];
    [self.items removeAllObjects];
    
    BOOL isCameraAvailable = [self isCameraAvailable];
    BOOL isPhotoLibraryAvailable = [self isPhotoLibraryAvailable];
    
    [self.items addObject:kVideoRecord];
    if (isCameraAvailable) {
        [self.items addObject:kCamera];
    }
    if (isPhotoLibraryAvailable) {
        [self.items addObject:kFromPhotoLibrary];
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSString *itemTitle in self.items) {
        [actionSheet addButtonWithTitle:itemTitle];
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [actionSheet setDelegate:self];
    [actionSheet showInView:window];
    
    objc_setAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult, resultBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark - Function

- (void)showCameraResultWithImage:(void (^)(UIImage *image))resultBlock{
    [self setSelectResultType:SelectResultType_Image];
    [self showCameraWithSourceType:UIImagePickerControllerSourceTypeCamera type:HYQCameraTypeSingleSelectPhoto];
    objc_setAssociatedObject(self, &HYQCameraDidFinishPickerImage, resultBlock, OBJC_ASSOCIATION_COPY);
}
- (void)showCameraResultWithAssetUrl:(void (^)(NSURL *imageAssetUrl))resultBlock{
    [self setSelectResultType:SelectResultType_AssertUrl];
    [self showCameraWithSourceType:UIImagePickerControllerSourceTypeCamera type:HYQCameraTypeSingleSelectPhoto];
    objc_setAssociatedObject(self, &HYQCameraDidFinishPickerImage, resultBlock, OBJC_ASSOCIATION_COPY);
}
- (void)showPhotoSingleSelectResultWithImage:(void (^)(UIImage *image))resultBlock{
    [self setSelectResultType:SelectResultType_Image];
    [self showCameraWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary type:HYQCameraTypeSingleSelectPhoto];
    objc_setAssociatedObject(self, &HYQCameraDidFinishPickerImage, resultBlock, OBJC_ASSOCIATION_COPY);
}
- (void)showPhotoSingleSelectResultWithAssetUrl:(void (^)(NSURL *imageAssetUrl))resultBlock{
    [self setSelectResultType:SelectResultType_AssertUrl];
    [self showCameraWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary type:HYQCameraTypeSingleSelectPhoto];
    objc_setAssociatedObject(self, &HYQCameraDidFinishPickerImage, resultBlock, OBJC_ASSOCIATION_COPY);
}
- (void)showPhotoMutilSelectResultWithAssetUrls:(void (^)(NSArray *imageAssetUrls))resultBlock{
    [self setSelectResultType:SelectResultType_AssertUrlArr];
    [self showCameraWithSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum type:HYQCameraTypeMutilSelectPhotos];
    objc_setAssociatedObject(self, &HYQCameraDidFinishPickerImage, resultBlock, OBJC_ASSOCIATION_COPY);
}
- (void)showPhotoMutilSelectMaxNumber:(NSInteger)maxNumber resultWithAssetUrls:(void (^)(NSArray *imageAssetUrls))resultBlock{
    [self setMaxSelectedNumber:maxNumber];
    [self setSelectResultType:SelectResultType_AssertUrlArr];
    [self showCameraWithSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum type:HYQCameraTypeMutilSelectPhotos];
    objc_setAssociatedObject(self, &HYQCameraDidFinishPickerImage, resultBlock, OBJC_ASSOCIATION_COPY);
}
- (void)showVideoRecordResultWithFilePath:(void (^)(NSString *filePath))resultBlock{
    [self setSelectResultType:SelectResultType_filePath];
    [self showCameraWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary type:HYQCameraTypeOther];
    objc_setAssociatedObject(self, &HYQCameraDidFinishPickerVideo, resultBlock, OBJC_ASSOCIATION_COPY);
}
- (void)showVideoPickerResultWithFilePath:(void (^)(NSString *filePath))resultBlock{
    [self setSelectResultType:SelectResultType_filePath];
    [self showCameraWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary type:HYQCameraTypeSingleSelectVideo];
    objc_setAssociatedObject(self, &HYQCameraDidFinishPickerVideo, resultBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (0 == buttonIndex) {}else{
        NSString *itemTitle = [self.items objectAtIndex:(buttonIndex-1)];
        if (self.customCameraPickerType == CustomCameraPickerType_Single) {
            if ([itemTitle isEqualToString:kCamera]) {
                [self showCameraResultWithImage:^(UIImage *image) {
                    void (^block)(UIImage *img) = objc_getAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult);
                    if (block) block(image);
                }];
            }else if ([itemTitle isEqualToString:kFromPhotoLibrary]){
                [self showPhotoSingleSelectResultWithImage:^(UIImage *image) {
                    void (^block)(UIImage *img) = objc_getAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult);
                    if (block) block(image);
                }];
            }
        }else if (self.customCameraPickerType == CustomCameraPickerType_Mutil){
            if ([itemTitle isEqualToString:kCamera]) {
                [self showCameraResultWithAssetUrl:^(NSURL *imageAssetUrl) {
                    NSLog(@"%@",imageAssetUrl);
                    if (imageAssetUrl) {
                        NSArray *imageAssetUrls = [[NSArray alloc] initWithObjects:imageAssetUrl, nil];
                        void (^block)(NSArray *arr) = objc_getAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult);
                        if (block) block(imageAssetUrls);
                    }
                }];
            }else if ([itemTitle isEqualToString:kFromPhotoLibrary]){
                [self showPhotoMutilSelectResultWithAssetUrls:^(NSArray *imageAssetUrls) {
                    void (^block)(NSArray *arr) = objc_getAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult);
                    if (block) block(imageAssetUrls);
                }];
            }
        }else if (self.customCameraPickerType == CustomCameraPickerType_Video){
            if ([itemTitle isEqualToString:kCamera]) {
                [self showCameraResultWithAssetUrl:^(NSURL *imageAssetUrl) {
                    NSArray *imageAssetUrls = [[NSArray alloc] initWithObjects:imageAssetUrl, nil];
                    void (^block)(NSArray *arr) = objc_getAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult);
                    if (block) block(imageAssetUrls);
                }];
            }else if ([itemTitle isEqualToString:kFromPhotoLibrary]){
                [self showPhotoMutilSelectResultWithAssetUrls:^(NSArray *imageAssetUrls) {
                    void (^block)(NSArray *arr) = objc_getAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult);
                    if (block) block(imageAssetUrls);
                }];
            }else if ([itemTitle isEqualToString:kVideoRecord]){
                [self showVideoRecordResultWithFilePath:^(NSString *filePath) {
                    NSArray *imageAssetUrls = [[NSArray alloc] initWithObjects:filePath, nil];
                    void (^block)(NSArray *arr) = objc_getAssociatedObject(self, &HYQCustomCameraDidFinishPickerResult);
                    if (block) block(imageAssetUrls);
                }];
            }
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [picker dismissViewControllerAnimated:YES completion:^{
            self.controller = nil;
        }];
 
    });
    if (self.cameraType != HYQCameraTypeSingleSelectVideo) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 转过来
        image = [UIImage fixOrientation:image];
        double delayInSeconds = 0.10;
        dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
        dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
            
            if (self.selectResultType == SelectResultType_AssertUrl) {
                NSURL *assertUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
                if (!assertUrl) {//拍照时需要保存到相册再获取assetUrl
                    [self saveImageToLibrary:image assetUrl:^(NSString *assetUrlStr) {
                        NSURL *url = [NSURL URLWithString:assetUrlStr];
                        void (^block)(NSURL *assertUrl) = objc_getAssociatedObject(self, &HYQCameraDidFinishPickerImage);
                        if (block) block(url);
                    }];
                }else{
                    void (^block)(NSURL *assertUrl) = objc_getAssociatedObject(self, &HYQCameraDidFinishPickerImage);
                    if (block) block(assertUrl);
                }
            }else if (self.selectResultType == SelectResultType_Image){
                void (^block)(UIImage *img) = objc_getAssociatedObject(self, &HYQCameraDidFinishPickerImage);
                if (block) block(image);
            }
            
            
        });
    }else{
        NSLog(@"video...");
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *urlStr=[url path];
        NSInteger length = [self getFileSize:urlStr];
        NSLog(@"\n\n视频大小：%zd kb \n视频路径：%@\n",length,urlStr);
        void (^block)(NSString *urlStr) = objc_getAssociatedObject(self, &HYQCameraDidFinishPickerVideo);
        if (block) block(urlStr);
        
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
//            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
//            [self saveVideoToAlbum:urlStr];
//        }
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - DNImagePickerControllerDelegate

//- (void)dnImagePickerController:(DNImagePickerController *)imagePickerController sendImages:(NSArray *)imageAssets isFullImage:(BOOL)fullImage{
//    
//    NSMutableArray *imageUrls = [[NSMutableArray alloc] init];
//    for (int i = 0; i < imageAssets.count; i++) {
//        
//        DNAsset *dnasset = imageAssets[i];
//        NSURL *assetUrl = dnasset.url;
//        [imageUrls addObject:assetUrl];
//    }
//    
//    void (^block)(NSArray *imgs) = objc_getAssociatedObject(self, &HYQCameraDidFinishPickerImage);
//    if (block) block(imageUrls);
//}
//
//- (void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker{
//    [imagePicker dismissViewControllerAnimated:YES completion:^{
//        self.controller = nil;
//    }];
//}

#pragma mark - AVViewControllerDelegate

- (void)didGetVideoUrlPath:(NSString *)urlPath{
    void (^block)(NSString *filePath) = objc_getAssociatedObject(self, &HYQCameraDidFinishPickerVideo);
    if (block) block(urlPath);
}

#pragma mark - Private

- (void)showCameraWithSourceType:(NSUInteger)sourceType type:(HYQCameraType)type{
    self.cameraType = type;
    
    
//    if (IS_IOS7) {
//        AppDelegate *delete = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [delete.tabBarController.tabBar setHidden:YES];
//    }
    
    UIViewController *igCtrl = nil;
    if (type == HYQCameraTypeMutilSelectPhotos) {
        //图片多选
//        DNImagePickerController *imagePicker = [[DNImagePickerController alloc] init];
//        imagePicker.imagePickerDelegate = self;
//        imagePicker.maxSeletedNumber = (self.maxSelectedNumber >= 0 ? self.maxSelectedNumber : 9);
////        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////        UIViewController *rootViewController = [[appdelegate window] rootViewController];
////        [rootViewController presentViewController:imagePicker animated:YES completion:nil];
//        igCtrl = imagePicker;
    }else if (type == HYQCameraTypeOther){
//        AVViewController *avController = [[AVViewController alloc] init];
//        //    [controller setHidesBottomBarWhenPushed:YES];
//        avController.shouldAutoDismiss = YES;
//        [avController setDelegate:self];
//        
////        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////        UIViewController *rootViewController = [[appdelegate window] rootViewController];
////        [rootViewController presentViewController:avController animated:YES completion:nil];
//        igCtrl = avController;
    }else{
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = sourceType;
        
        if (type == HYQCameraTypeSingleSelectVideo){
            imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
            imagePickerController.videoMaximumDuration = 60; //设置录制的最大时长
            imagePickerController.allowsEditing = YES;
            if (sourceType != UIImagePickerControllerSourceTypePhotoLibrary) {
                imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
                imagePickerController.showsCameraControls = YES;
            }
        }
        igCtrl = imagePickerController;
        
    }
    if (self.controller) {
        [self.controller presentViewController:igCtrl animated:YES completion:nil];
    }else{
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UIViewController *rootViewController = [[appdelegate window] rootViewController];
        [rootViewController presentViewController:igCtrl animated:YES completion:nil];
    }
}

//从assetUrl里面获取图片
- (void)imageWithAssetUrl:(NSURL *)assetUrl highDefinition:(BOOL)highDefinition resultBlock:(void (^)(UIImage *image))resultBlock{
    __block UIImage *image = nil;
    ALAssetsLibrary *lib = [ALAssetsLibrary new];
    __weak typeof(self) weakSelf = self;
    
    [lib assetForURL:assetUrl resultBlock:^(ALAsset *asset){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (asset) {
            image = [strongSelf imageFromAsset:asset highDefinition:highDefinition];
            if (resultBlock) {resultBlock(image);}
        } else {
            
//            PHAsset *phAsset = [PHAsset fetchAssetsWithLocalIdentifiers:@[] options:nil]
            
            // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
            [lib enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                               usingBlock:^(ALAssetsGroup *group, BOOL *stop){
                                   [group enumerateAssetsWithOptions:NSEnumerationReverse
                                                          usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                                              if([[result valueForProperty:ALAssetPropertyAssetURL] isEqual:assetUrl]){
                                                                  image = [strongSelf imageFromAsset:result highDefinition:highDefinition];
                                                                  if (resultBlock) {resultBlock(image);}
                                                                  
                                                                  
                                                                  
                                                                  ///////////////////////////////////////////////////////
                                                                  // SUCCESS POINT #2 - result is what we are looking for
                                                                  ///////////////////////////////////////////////////////
                                                                  
                                                                  *stop = YES;
                                                              }
                                                          }];}failureBlock:^(NSError *error){
                                                              if (resultBlock) {resultBlock(nil);}
                                                          }];
        }
        
    } failureBlock:^(NSError *error){
        if (resultBlock) {resultBlock(nil);}
    }];
    
}
- (UIImage *)imageFromAsset:(ALAsset *)asset highDefinition:(BOOL)highDefinition{
    UIImage *image = nil;
    NSString *string;
    if (highDefinition) {
        image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        string = [NSString stringWithFormat:@"fileSize:%lld k\nwidth:%.0f\nheiht:%.0f",asset.defaultRepresentation.size/1000,image.size.width,image.size.height];
    }else{
        NSNumber *orientationValue = [asset valueForProperty:ALAssetPropertyOrientation];
        UIImageOrientation orientation = UIImageOrientationUp;
        if (orientationValue != nil) {
            orientation = [orientationValue intValue];
        }
        
        image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
        //        image = [UIImage imageWithCGImage:asset.thumbnail scale:0.1 orientation:orientation];
        
        string = [NSString stringWithFormat:@"fileSize:%lld k\nwidth:%.0f\nheiht:%.0f",asset.defaultRepresentation.size/1000,[[asset defaultRepresentation] dimensions].width, [[asset defaultRepresentation] dimensions].height];
    }
    NSLog(@"%@%@",string,image);
    return image;
}


//保存图片到沙盒
- (void)saveImageToSandbox:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImagePNGRepresentation(currentImage);
    NSString *fullPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:YES];
}
//保存图片到相册
- (void)saveImageToAlbum:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    [self showAlertMessage:@"保存图片失败"];
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *message = @"保存失败";
    if (!error) { message = @"保存图片成功";
    }else{
        message = [error description];
        [self showAlertMessage:message];
    }
}
//保存图片到相册并获取assetUrlStr
- (void)saveImageToLibrary:(UIImage *)image assetUrl:(void (^)(NSString *assetUrlStr))resultBlock{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    // Request to save the image to camera roll
    [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            [self showAlertMessage:[NSString stringWithFormat:@"获取图片失败%@",error]];
        }else{
            NSString *assertURLStr = [NSString stringWithFormat:@"%@",assetURL];
            if (resultBlock) {resultBlock(assertURLStr);}
        }
    }];
}

//保存视频到相册
- (void)saveVideoToAlbum:(NSString *)urlPath{
    UISaveVideoAtPathToSavedPhotosAlbum(urlPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
}
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [self showAlertMessage:[NSString stringWithFormat:@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription]];
    }else{
        NSLog(@"视频保存成功.%@",videoPath);
    }
}

//视频转码
- (void)encodeVideo:(NSString *)urlPath{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:urlPath] options:nil];
    //NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset
                                                                           presetName:AVAssetExportPresetMediumQuality];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *_mp4Path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
    
    exportSession.outputURL = [NSURL fileURLWithPath: _mp4Path];
    exportSession.shouldOptimizeForNetworkUse = YES;//是否针对网络使用进行优化
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([exportSession status]) {
            case AVAssetExportSessionStatusFailed:{
                NSLog(@"Error : %@",[[exportSession error] localizedDescription]);
                break;
            }
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"Export canceled");
                break;
            case AVAssetExportSessionStatusCompleted:
                NSLog(@"Successful!");
                [self performSelectorOnMainThread:@selector(convertFinish) withObject:nil waitUntilDone:NO];
                break;
            default:
                break;
        }
    }];
}
- (void)convertFinish{
    NSLog(@"转码完成");
}

- (NSInteger)getFileSize:(NSString*)path{
    NSFileManager * filemanager = [[NSFileManager alloc] init];
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
            return  [theFileSize intValue]/1024;
        else
            return -1;
    }else{
        return -1;
    }
}

- (CGFloat)getVideoDuration:(NSURL*)URL{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}

//警告
- (void)showAlertMessage:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"" otherButtonTitles:@"确定", nil];
    [alertView show];
}

//生成一个图片名字
- (NSString *)makeImageName{
    NSDate *date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHMMSS"];
    NSString* imageName = [formatter stringFromDate:date];
    return imageName;
}

#pragma mark 摄像头和相册相关的公共类

// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
- (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}


// 判断是否支持某种多媒体类型：拍照，视频
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes =[UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL*stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
        
    }];
    return result;
}

- (BOOL)isVideoRecordAvailable{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        //无权限
        return NO;
    }
    return YES;
}

- (BOOL)isAudioRecordAvailable{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        //无权限
        return NO;
    }
    return YES;
}

//// 检查摄像头是否支持录像
//- (BOOL) doesCameraSupportShootingVideos{
//    return [self cameraSupportsMedia:(NSString *)kUTTypeMoviesourceType:UIImagePickerControllerSourceTypeCamera];
//}
//
//// 检查摄像头是否支持拍照
//- (BOOL) doesCameraSupportTakingPhotos{
//    return [self cameraSupportsMedia:(NSString *)kUTTypeImagesourceType:UIImagePickerControllerSourceTypeCamera];
//}

// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] || [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}


// 是否可以在相册中选择视频
//- (BOOL) canUserPickVideosFromPhotoLibrary{
//    return [self cameraSupportsMedia:(NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//}

// 是否可以在相册中选择视频
//- (BOOL) canUserPickPhotosFromPhotoLibrary{
//    return [self cameraSupportsMedia:kCIAttributeTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//
//    return [self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//}

#pragma mark - 通过本地url 获取视频缩略图
+(UIImage *)getThumbnailImage:(NSString *)videoURL {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}


@end
