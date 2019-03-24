//
//  JPTagView.h
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPTagModel.h"

NS_ASSUME_NONNULL_BEGIN

@class JPTagView;
@protocol JPTagViewDelegate <NSObject>

@optional

- (void)tagView:(JPTagView *)tagView didSelectedItem:(NSIndexPath *)indexpath;

- (void)tagView:(JPTagView *)tagVIew didDeleteItem:(NSIndexPath *)indexpath;

@end


@interface JPTagView : UIView

@property(nonatomic,weak)id<JPTagViewDelegate> delegate;

/**
 设置数据

 @param dataArray dataArray description
 */
- (void)setTagViewDataWith:(NSArray<JPTagModel *> *)dataArray;

/**
 获取当前tagView的实际显示高度
 
 @param dataArray dataArray description
 @return return value description
 */
- (CGFloat)getTagViewHeight:(NSArray<JPTagModel *> *)dataArray;

//tagView 属性

/** tagViewBackColor default white */
@property(nonatomic,strong) UIColor *tagViewBackColor;

/** tagViewBackImage default nil */
@property(nonatomic,strong) UIImage *tagViewBackImage;

/** tagViewBackImageUrl default nil */
@property(nonatomic,strong) NSString *tagViewBackImageUrl;

/** view contentInset 文本区域 default(0,24,0,24) */
@property(nonatomic,assign) UIEdgeInsets tagViewContentInset;

/** tagViewMaxHeight default maxfloat */
@property(nonatomic,assign) CGFloat tagViewMaxHeight;

/** tagViewMinHeight default 0 */
@property(nonatomic,assign) CGFloat tagViewMinHeight;

/** tagViewScrollEnabled default YES */
@property(nonatomic,assign) BOOL tagViewScrollEnabled;

/** isCanSelectedMoreTag default YES */
@property(nonatomic,assign) BOOL isCanSelectedMoreTag;

/** isCanSelectedMoreTagInSection default YES */
@property(nonatomic,assign) BOOL isCanSelectedMoreTagInSection;

/** isShowSection 分组模式 default YES */
@property(nonatomic,assign) BOOL isShowSection;

/** tag 列间距 default 10 */
@property(nonatomic,assign) CGFloat tagColumnMargin;

/** tag 行间距 default 10 */
@property(nonatomic,assign) CGFloat tagRowMargin;

/** tag 组头和当前组第一行的 间距 default 0 */
@property(nonatomic,assign) CGFloat tagSectionMargin;

//权重: ImageUrl > Image > Color
//单独一个tag的属性

/** tagName normal font default 14 */
@property(nonatomic,strong) UIFont *tagNameNormalFont;

/** tagName selected font default 14 */
@property(nonatomic,strong) UIFont *tagNameSelectedFont;

/** tagName normal color default black */
@property(nonatomic,strong) UIColor *tagNameNormalColor;

/** tagName selected color default white */
@property(nonatomic,strong) UIColor *tagNameSelectedColor;

/** tag Back normal backColor default gray */
@property(nonatomic,strong) UIColor *tagBackNormalColor;

/** tag Back selected backColor default red */
@property(nonatomic,strong) UIColor *tagBackSelectedColor;

/** tag Back normal backImage default nil */
@property(nonatomic,strong) UIImage *tagBackNormalImage;

/** tag Back selected backImage default nil */
@property(nonatomic,strong) UIImage *tagBackSelectedImage;

/** tag Back normal backImageUrl default nil */
@property(nonatomic,strong) NSString *tagBackNormalImageUrl;

/** tag Back selected backImageUrl default nil */
@property(nonatomic,strong) NSString *tagBackSelectedImageUrl;

/** tag back contentinset default (0,0,0,0) 为了适配显示delete  */
@property(nonatomic,assign) UIEdgeInsets tagBackContentInset;

//圆角和边框相关

/** isShowCornerRadius default YES */
@property(nonatomic,assign) BOOL isShowTagCornerRadius;

/** tagCornerRadius default h*0.5 */
@property(nonatomic,assign) CGFloat tagCornerRadius;

/** isShowTagBorder default NO */
@property(nonatomic,assign) BOOL isShowTagBorder;

/** tagBorderWidth default 0 */
@property(nonatomic,assign) CGFloat tagBorderWidth;

/** tagBorderColor default clear */
@property(nonatomic,strong) UIColor *tagBorderColor;

//删除相关

/** tagDeleteImage */
@property(nonatomic,strong) UIImage *tagDeleteImage;

/** isShowDelete default NO 展示delete 设置 tagBackContentInset 至少为 4.4.4.4 */
@property(nonatomic,assign) BOOL isShowDelete;

/** tagDeleteCorner delete 位置 default topRight */
@property(nonatomic,assign) TagDeleteCorner tagDeleteCorner;

//布局相关

/** tag min width default 60 */
@property(nonatomic,assign) CGFloat tagMinWidth;

/** tag min height default 30 */
@property(nonatomic,assign) CGFloat tagMinHeight;

/** tag text contentinset default 6,14,6,14 */
@property(nonatomic,assign) UIEdgeInsets tagNameContentInset;

//操作相关

/** isCanSelectedTag default YES */
@property(nonatomic,assign) BOOL isCanSelectedTag;

/** isTagCanClickWhenSelected 是否可以点击已选中的tag default YES */
@property(nonatomic,assign) BOOL isTagCanClickWhenSelected;

/** isCanLongPressShowDelete default NO 展示delete 设置 tagBackContentInset 至少为 4.4.4.4 */
@property(nonatomic,assign) BOOL isCanLongPressShowDelete;

/** isShakeWhenShowDelete default NO 长按的情况下才生效-YES */
@property(nonatomic,assign) BOOL isShakeWhenShowDelete;

//组头相关

/** tag section height default 50 */
@property(nonatomic,assign) CGFloat tagSectionHeight;

/** tag section backcolor default blueColor */
@property(nonatomic,strong) UIColor *tagSectionBackColor;

/** tag section color default black */
@property(nonatomic,strong) UIColor *tagSectionNameColor;

/** tag section font default bold 14 */
@property(nonatomic,strong) UIFont *tagSectionNameFont;

/** tag section contentinset default 0,24,0,24 */
@property(nonatomic,assign) UIEdgeInsets tagSectionNameInset;

/** tag section alignment default left */
@property(nonatomic,assign) TagSectionAlignment tagSectionAlignment;

@end

NS_ASSUME_NONNULL_END
