//
//  JPTagLayout.h
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JPTagModel;
@interface JPTagLayout : UICollectionViewFlowLayout

/** dataArray */
@property(nonatomic,strong) NSArray<JPTagModel *> *dataArray;

/** 每个tag列间距 */
@property(nonatomic,assign) CGFloat columnMargin;
/** 每个tag行间距 */
@property(nonatomic,assign) CGFloat rowMargin;
/** tag 组头和当前组第一行的 间距 default 0 */
@property(nonatomic,assign) CGFloat tagSectionMargin;
/** tagView 显示范围 四周间距 */
@property(nonatomic,assign) UIEdgeInsets edgeInsets;

/** sectionHeight */
@property(nonatomic,assign) CGFloat sectionHeight;

/** isShowSection 分组模式 default YES */
@property(nonatomic,assign) BOOL isShowSection;

- (CGFloat)getTagViewHeight;

@end

NS_ASSUME_NONNULL_END
