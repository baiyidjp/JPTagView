//
//  UIImageView+Extension.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import "UIImageView+JPCategory.h"
#import "SDWebImageDownloader.h"

@implementation UIImageView (JPCategory)

+ (void)jp_downloadImageWithURL:(NSURL *)url completed:(nonnull JPExternalCompletionBlock)completedBlock {
    
    if (!url || ![url absoluteString].length ){
        return;
    }
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
        if (finished) {
            
            if (error == nil && image) {
                if (completedBlock) {
                    completedBlock(image);
                }
            }
        }
        
    }];
}

@end
