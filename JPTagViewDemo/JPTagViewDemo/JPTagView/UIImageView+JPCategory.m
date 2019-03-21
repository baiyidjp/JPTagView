//
//  UIImageView+Extension.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import "UIImageView+JPCategory.h"

@implementation UIImageView (JPCategory)

- (void)jp_setImageWithURL:(NSURL *)url completed:(nonnull JPExternalCompletionBlock)completedBlock {
    
    if (!url){
        return;
    }
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JPDownloadImageCache"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if(!isDirExist){
        
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bCreateDir) {
            NSLog(@"创建文件出错");
            return;
        }
    }
    NSString *urlString = [url absoluteString];
    NSString *imageName = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *pathString = [[path stringByAppendingString:@"/"] stringByAppendingString:imageName];
    NSData *saveData = [NSData dataWithContentsOfFile:pathString];
    //本地缓存
    if (saveData) {
        UIImage *saveImage = [UIImage imageWithData:saveData];
        self.image = saveImage;
        if (completedBlock) {
            completedBlock(saveImage,url);
        }
        return;
    }
    //创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建会话请求
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (location && location.absoluteString.length) {
                
                [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:pathString] error:nil];
                NSData *saveData = [NSData dataWithContentsOfFile:pathString];
                if (saveData) {
                    UIImage *saveImage = [UIImage imageWithData:saveData];
                    self.image = saveImage;
                    if (completedBlock) {
                        completedBlock(saveImage,url);
                    }
                }
            }
        });
    }];
    //发送请求
    [downTask resume];
}

+ (void)jp_downloadImageWithURL:(NSURL *)url completed:(JPExternalCompletionBlock)completedBlock {
    
    if (!url){
        return;
    }
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JPDownloadImageCache"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if(!isDirExist){
        
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bCreateDir) {
            NSLog(@"创建文件出错");
            return;
        }
    }
    NSString *urlString = [url absoluteString];
    NSString *imageName = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *pathString = [[path stringByAppendingString:@"/"] stringByAppendingString:imageName];
    NSData *cacheData = [NSData dataWithContentsOfFile:pathString];
    //本地缓存
    if (cacheData) {
        UIImage *cacheImage = [UIImage imageWithData:cacheData];
        if (completedBlock) {
            completedBlock(cacheImage,url);
        }
        return;
    }
    //创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建会话请求
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (location && location.absoluteString.length) {
                
                [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:pathString] error:nil];
                NSData *saveData = [NSData dataWithContentsOfFile:pathString];
                if (saveData) {
                    UIImage *saveImage = [UIImage imageWithData:saveData];
                    if (completedBlock) {
                        completedBlock(saveImage,url);
                    }
                }
            }
        });
    }];
    //发送请求
    [downTask resume];
}

@end
