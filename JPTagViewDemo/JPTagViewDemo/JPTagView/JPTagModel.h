//
//  JPTagModel.h
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TagSectionAlignment) {
    TagSectionAlignment_None,
    TagSectionAlignment_Left,
    TagSectionAlignment_Center,
    TagSectionAlignment_Right
};

typedef NS_OPTIONS(NSUInteger, TagDeleteCorner) {
    TagDeleteCornerTopNone,
    TagDeleteCornerTopLeft,
    TagDeleteCornerTopRight,
    TagDeleteCornerBottomLeft,
    TagDeleteCornerBottomRight
};

@interface JPTagModel : NSObject

/** tag id */
@property(nonatomic,copy) NSString *tagId;
/** tag normal name */
@property(nonatomic,copy) NSString *tagNormalName;
/** tag selected name */
@property(nonatomic,copy) NSString *tagSelectedName;
/** tag normal attributedName */
@property(nonatomic,copy) NSAttributedString *tagNormalAttributedName;
/** tag selected attributedName */
@property(nonatomic,copy) NSAttributedString *tagSelectedAttributedName;
/** sub tags */
@property(nonatomic,strong) NSArray *subTags;

/** tag size */
@property(nonatomic,assign) CGSize tagSize;
/** frame */
@property(nonatomic,assign) CGRect tagLayoutFrame;

/** tagDeleteImage */
@property(nonatomic,strong) UIImage *tagDeleteImage;
/** selected 是否被选中 default NO */
@property(nonatomic,assign) BOOL isSelected;
/** isShowDelete default NO */
@property(nonatomic,assign) BOOL isShowDelete;
/** isTagCanClick tag是否可以点击 default YES */
@property(nonatomic,assign) BOOL isTagCanClick;
/** isTagCanClickWhenSelected 是否可以点击已选中的tag default YES */
@property(nonatomic,assign) BOOL isTagCanClickWhenSelected;
/** isShakeWhenShowDelete default NO 长按的情况下才生效-YES */
@property(nonatomic,assign) BOOL isShakeWhenShowDelete;
/** isShowShakeAnimation default NO 开始动画 */
@property(nonatomic,assign) BOOL isShowShakeAnimation;


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
/** tag text contentinset default 8,8,8,8 */
@property(nonatomic,assign) UIEdgeInsets tagBackContentInset;

@end

NS_ASSUME_NONNULL_END
