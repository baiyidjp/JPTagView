//
//  UIImageView+Extension.h
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^JPExternalCompletionBlock)(UIImage * _Nullable image, NSURL * _Nullable imageURL);

@interface UIImageView (JPCategory)

/**
 设置图片
 
 @param url NSURL图片地址
 */
- (void)jp_setImageWithURL:(NSURL *)url completed:(JPExternalCompletionBlock)completedBlock;

/**
 下载图片
 
 @param url NSURL图片地址
 */
+ (void)jp_downloadImageWithURL:(NSURL *)url completed:(JPExternalCompletionBlock)completedBlock;

@end

NS_ASSUME_NONNULL_END
