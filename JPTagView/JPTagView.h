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

@interface JPTagView : UIView

/**
 获取当前tagView的实际显示高度
 
 @param dataArray dataArray description
 @return return value description
 */
- (CGFloat)getTagViewHeight:(NSArray<JPTagModel *> *)dataArray;

/** dataArray */
@property(nonatomic,strong) NSArray<JPTagModel *> *dataArray;

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
/** isCanSelectedTag default YES */
@property(nonatomic,assign) BOOL isCanSelectedTag;
/** isCanSelectedMoreTag default YES */
@property(nonatomic,assign) BOOL isCanSelectedMoreTag;
/** isShowSection 分组模式 default YES */
@property(nonatomic,assign) BOOL isShowSection;

/** tag 列间距 default 10 */
@property(nonatomic,assign) CGFloat tagColumnMargin;
/** tag 行间距 default 10 */
@property(nonatomic,assign) CGFloat tagRowMargin;
/** tag 组头和当前组第一行的 间距 default 0 */
@property(nonatomic,assign) CGFloat tagSectionMargin;

/** tag min width default 60 */
@property(nonatomic,assign) CGFloat tagMinWidth;
/** tag min height default 30 */
@property(nonatomic,assign) CGFloat tagMinHeight;
/** tag text contentinset default 6,14,6,14 */
@property(nonatomic,assign) UIEdgeInsets tagNameContentInset;

/** tagDeleteImage */
@property(nonatomic,strong) UIImage *tagDeleteImage;
/** isShowDelete default NO 展示delete 设置 tagBackContentInset 至少为 4.4.4.4 */
@property(nonatomic,assign) BOOL isShowDelete;
/** isTagCanClickWhenSelected 是否可以点击已选中的tag default YES */
@property(nonatomic,assign) BOOL isTagCanClickWhenSelected;
/** isCanLongPressShowDelete default NO 展示delete 设置 tagBackContentInset 至少为 4.4.4.4 */
@property(nonatomic,assign) BOOL isCanLongPressShowDelete;
/** isShakeWhenShowDelete default NO 长按的情况下才生效-YES */
@property(nonatomic,assign) BOOL isShakeWhenShowDelete;

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

/** tagName normal font default 14 */
@property(nonatomic,strong) UIFont *tagNameNormalFont;
/** tagName selected font default 14 */
@property(nonatomic,strong) UIFont *tagNameSelectedFont;
/** tagName normal color default black */
@property(nonatomic,strong) UIColor *tagNameNormalColor;
/** tagName selected color default white */
@property(nonatomic,strong) UIColor *tagNameSelectedColor;

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
/** tagDeleteCorner delete 位置 default topRight */
@property(nonatomic,assign) TagDeleteCorner tagDeleteCorner;

//权重: ImageUrl > Image > Color

/** tagBack normal backColor default gray */
@property(nonatomic,strong) UIColor *tagBackNormalColor;
/** tagBack selected backColor default red */
@property(nonatomic,strong) UIColor *tagBackSelectedColor;
/** tagBack normal backImage default nil */
@property(nonatomic,strong) UIImage *tagBackNormalImage;
/** tagBack selected backImage default nil */
@property(nonatomic,strong) UIImage *tagBackSelectedImage;
/** tagBack normal backImageUrl default nil */
@property(nonatomic,strong) NSString *tagBackNormalImageUrl;
/** tagBack selected backImageUrl default nil */
@property(nonatomic,strong) NSString *tagBackSelectedImageUrl;
/** tag text contentinset default (0,0,0,0) */
@property(nonatomic,assign) UIEdgeInsets tagBackContentInset;

@end

NS_ASSUME_NONNULL_END
