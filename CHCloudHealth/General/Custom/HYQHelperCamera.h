//
//  HYQHelperCamera.h
//  HYQuan
//
//  Created by fqah on 12/9/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface HYQHelperCamera : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong)UIViewController *controller;


/// 拍照、从相册选择（单选）
- (void)showCustomCameraPickerWithResultBlock:(void (^)(UIImage *image))resultBlock;
/// 拍照、从相册选择（多选）
- (void)showCustomMutilCameraPickerWithMaxSelectNumber:(NSInteger)maxNumber resultBlock:(void (^)(NSArray *imageAssetUrls))resultBlock;
/// 视频、拍照、从相册选择（多选）
- (void)showCustomVideoCameraPickerWithMaxSelectNumber:(NSInteger)maxNumber resultBlock:(void (^)(NSArray *infoArr))resultBlock;





/// 相机
/// Result : Image
- (void)showCameraResultWithImage:(void (^)(UIImage *image))resultBlock;
/// 相机
/// Result : ImageAssetUrl
- (void)showCameraResultWithAssetUrl:(void (^)(NSURL *imageAssetUrl))resultBlock;
/// 照片
/// Result : Image
- (void)showPhotoSingleSelectResultWithImage:(void (^)(UIImage *image))resultBlock;
/// 照片
/// Result : ImageAssetUrl
- (void)showPhotoSingleSelectResultWithAssetUrl:(void (^)(NSURL *imageAssetUrl))resultBlock;
/// 图片多选
/// Result : ImageAssetUrlArr
- (void)showPhotoMutilSelectResultWithAssetUrls:(void (^)(NSArray *imageAssetUrls))resultBlock;
- (void)showPhotoMutilSelectMaxNumber:(NSInteger)maxNumber resultWithAssetUrls:(void (^)(NSArray *imageAssetUrls))resultBlock;
/// 视频(拍摄、选择)
/// Result : FilePath
- (void)showVideoRecordResultWithFilePath:(void (^)(NSString *filePath))resultBlock;
- (void)showVideoPickerResultWithFilePath:(void (^)(NSString *filePath))resultBlock;

/// 从AssetUrl中取出图片
- (void)imageWithAssetUrl:(NSURL *)assetUrl highDefinition:(BOOL)highDefinition resultBlock:(void (^)(UIImage *image))resultBlock;

- (void)saveImageToAlbum:(UIImage *)image;

///获取视频截图
+ (UIImage *)getThumbnailImage:(NSString *)videoURL;
- (NSInteger)getFileSize:(NSString*)path;



- (BOOL)isVideoRecordAvailable;
- (BOOL)isAudioRecordAvailable;



////去开启
//UIApplication* application =  [UIApplication sharedApplication];
//if (IS_IOS_BIGGER_8) {
//    if (UIApplicationOpenSettingsURLString != NULL) {
//        NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        [application openURL:appSettings];
//    }
//}else{
//    if (application.enabledRemoteNotificationTypes == UIRemoteNotificationTypeNone) {
//        [application openURL:[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"]];
//    }
//}
//






@end
