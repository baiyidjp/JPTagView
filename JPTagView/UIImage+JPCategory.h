//
//  UIImage+Extension.h
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JPCategory)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)randomColorImageWith:(CGSize)size;

/**
 圆形图片
 
 @param size size description
 @return return value description
 */
- (UIImage *)jp_cornerImageWithSize:(CGSize)size;

/**
 直接切圆角 返回图片
 
 @param size size description
 @param cornerRadius cornerRadius description
 @return return value description
 */
- (UIImage *)jp_cornerImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

/**
 异步圆形图片 适用于正方形切成圆形
 
 @param size size description
 @param completion completion description
 */
- (void)jp_asynCornerImageWithSize:(CGSize)size completion:(void (^)(UIImage *image))completion;

/**
 异步图片切圆角 适用于只切圆角
 
 @param size defalut--imageView size
 @param cornerRadius custom =0->不作处理的原图
 @param completion return--带圆角的图片
 */
- (void)jp_asynCornerImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius completion:(void (^)(UIImage *cornerImage))completion;

/**
 图片剪切为圆形 默认的边框颜色和边框宽度
 
 @param size 圆的外围
 @param cornerRadius 圆角
 @param completion 回调
 */

- (void)jp_asynCornerBorderImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius completion:(void (^)(UIImage *))completion;

/**
 图片剪切为圆形 可自定义边框颜色和宽度
 
 @param size 圆的外围
 @param cornerRadius 圆角
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param completion 回调
 */
- (void)jp_asynCornerBorderImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor completion:(void (^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
