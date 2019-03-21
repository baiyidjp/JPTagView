//
//  JPTagCell.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import "JPTagCell.h"
#import "JPTagModel.h"
#import "UIView+JPCategory.h"
#import "UIImage+JPCategory.h"
#import "UIImageView+JPCategory.h"

@interface JPTagCell ()

/** backImageView */
@property(nonatomic,strong) UIButton *tagBackImageButton;
/** label */
//@property(nonatomic,strong) UILabel *tagNameLabel;
/** deleteButton */
@property(nonatomic,strong) UIButton *tagDeleteButton;

@end

@implementation JPTagCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self p_SetUI];
    }
    return self;
}

#pragma mark 设置UI视图
- (void)p_SetUI {
    
    UIButton *tagBackImageButton = [[UIButton alloc] init];
    tagBackImageButton.userInteractionEnabled = NO;
    self.tagBackImageButton = tagBackImageButton;
    
    UIButton *tagDeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    self.tagDeleteButton = tagDeleteButton;
    
}

- (void)setTagModel:(JPTagModel *)tagModel {
    
    _tagModel = tagModel;
    
    [self.contentView addSubview:self.tagBackImageButton];
    [self.contentView addSubview:self.tagDeleteButton];
    
    self.tagBackImageButton.selected = tagModel.isSelected;
    
    self.tagBackImageButton.frame = CGRectMake(tagModel.tagBackContentInset.left, tagModel.tagBackContentInset.top, self.jp_w-tagModel.tagBackContentInset.left-tagModel.tagBackContentInset.right, self.jp_h-tagModel.tagBackContentInset.top-tagModel.tagBackContentInset.bottom);
    
    [self.tagBackImageButton setTitle:tagModel.tagNormalName forState:UIControlStateNormal];
    [self.tagBackImageButton setTitle:tagModel.tagSelectedName.length ? tagModel.tagSelectedName : tagModel.tagNormalName forState:UIControlStateSelected];
    
    [self.tagBackImageButton setTitleColor:tagModel.tagNameNormalColor forState:UIControlStateNormal];
    [self.tagBackImageButton setTitleColor:tagModel.tagNameSelectedColor ? tagModel.tagNameSelectedColor : tagModel.tagNameNormalColor forState:UIControlStateSelected];
    
    if (tagModel.tagNormalAttributedName.length) {
        [self.tagBackImageButton setAttributedTitle:tagModel.tagNormalAttributedName forState:UIControlStateNormal];
    }
    
    if (tagModel.tagSelectedAttributedName.length) {
        [self.tagBackImageButton setAttributedTitle:tagModel.tagSelectedAttributedName forState:UIControlStateSelected];
    }
    
    if (tagModel.isSelected) {
        
        /** handle tagBackImage */
        
        if (tagModel.tagBackSelectedImageUrl && tagModel.tagBackSelectedImageUrl.length) {
            //下载网络图片
            [UIImageView jp_downloadImageWithURL:[NSURL URLWithString:tagModel.tagBackSelectedImageUrl] completed:^(UIImage * _Nullable image, NSURL * _Nullable imageURL) {
               
                [self p_HandleTagBackImage:image tagModel:tagModel];
            }];
            
        } else if (tagModel.tagBackSelectedImage) {
            
            [self p_HandleTagBackImage:tagModel.tagBackSelectedImage tagModel:tagModel];
            
        } else if (tagModel.tagBackSelectedColor) {
            //只有颜色
            UIImage *selectedImage = [UIImage imageWithColor:tagModel.tagBackSelectedColor];
            [self p_HandleTagBackImage:selectedImage tagModel:tagModel];
        }
        
        /** handle tagName */
        
        self.tagBackImageButton.titleLabel.font = tagModel.tagNameSelectedFont ? tagModel.tagNameSelectedFont : tagModel.tagNameNormalFont;
        
    } else {
        
        /** handle tagBackImage */
        
        if (tagModel.tagBackNormalImageUrl && tagModel.tagBackNormalImageUrl.length) {
            //下载网络图片
            [UIImageView jp_downloadImageWithURL:[NSURL URLWithString:tagModel.tagBackNormalImageUrl] completed:^(UIImage * _Nullable image, NSURL * _Nullable imageURL) {
                
                [self p_HandleTagBackImage:image tagModel:tagModel];
            }];
            
        } else if (tagModel.tagBackNormalImage) {
            
            [self p_HandleTagBackImage:tagModel.tagBackNormalImage tagModel:tagModel];
            
        } else if (tagModel.tagBackNormalColor) {
            //只有颜色
            UIImage *normalImage = [UIImage imageWithColor:tagModel.tagBackNormalColor];
            [self p_HandleTagBackImage:normalImage tagModel:tagModel];
        }
        
        /** handle tagName */
        
        self.tagBackImageButton.titleLabel.font = tagModel.tagNameNormalFont;
    }
    
    //delete
    if (tagModel.tagDeleteImage) {
        [self.tagDeleteButton setBackgroundImage:tagModel.tagDeleteImage forState:UIControlStateNormal];
    }
    self.tagDeleteButton.hidden = !tagModel.isShowDelete;
    switch (tagModel.tagDeleteCorner) {
        case TagDeleteCornerTopLeft:
            self.tagDeleteButton.center = CGPointMake(self.tagDeleteButton.jp_w*0.5, self.tagDeleteButton.jp_h*0.5);
            break;
        case TagDeleteCornerTopRight:
            self.tagDeleteButton.center = CGPointMake(self.jp_w-self.tagDeleteButton.jp_w*0.5, self.tagDeleteButton.jp_h*0.5);
            break;
        case TagDeleteCornerBottomLeft:
            self.tagDeleteButton.center = CGPointMake(self.tagDeleteButton.jp_w*0.5, self.jp_h-self.tagDeleteButton.jp_h*0.5);
            break;
        case TagDeleteCornerBottomRight:
            self.tagDeleteButton.center = CGPointMake(self.jp_w-self.tagDeleteButton.jp_w*0.5, self.jp_h-self.tagDeleteButton.jp_h*0.5);
            break;
        default:
            break;
    }
    [self.tagDeleteButton addTarget:self action:@selector(p_ClickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    
    //shake animation
    if (tagModel.isShakeWhenShowDelete) {
        
        if (tagModel.isShowShakeAnimation) {
            
            [self starShakeAnimation];
        } else {
            [self stopShakeAnimation];
        }
    }
}

- (void)starShakeAnimation {
    
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.03];
    shake.toValue = [NSNumber numberWithFloat:+0.03];
    shake.duration = 0.25;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = MAXFLOAT;
    [self.contentView.layer addAnimation:shake forKey:@"cellShake"];
}
- (void)stopShakeAnimation {
    
    [self.contentView.layer removeAnimationForKey:@"cellShake"];
}

#pragma mark - handle tagBackImage
- (void)p_HandleTagBackImage:(UIImage *)tagBackImage tagModel:(JPTagModel *)tagModel  {
    
    //存在图片 根据条件展示
    if (tagModel.isShowTagCornerRadius && tagModel.isShowTagBorder) {
        //圆角+边框
        [tagBackImage jp_asynCornerBorderImageWithSize:self.tagBackImageButton.bounds.size cornerRadius:tagModel.tagCornerRadius borderWidth:tagModel.tagBorderWidth borderColor:tagModel.tagBorderColor completion:^(UIImage * _Nonnull borderImage) {
            [self.tagBackImageButton setBackgroundImage:borderImage forState:UIControlStateNormal];
        }];
    } else if (tagModel.isShowTagCornerRadius) {
        //圆角
        [tagBackImage jp_asynCornerImageWithSize:self.tagBackImageButton.bounds.size cornerRadius:tagModel.tagCornerRadius completion:^(UIImage * _Nonnull cornerImage) {
            [self.tagBackImageButton setBackgroundImage:cornerImage forState:UIControlStateNormal];
        }];
    } else if (tagModel.isShowTagCornerRadius) {
        //边框
        [tagBackImage jp_asynCornerBorderImageWithSize:self.tagBackImageButton.bounds.size cornerRadius:0 borderWidth:tagModel.tagBorderWidth borderColor:tagModel.tagBorderColor completion:^(UIImage * _Nonnull borderImage) {
            [self.tagBackImageButton setBackgroundImage:borderImage forState:UIControlStateNormal];
        }];
    } else {
        [self.tagBackImageButton setBackgroundImage:tagBackImage forState:UIControlStateNormal];
    }
}

#pragma mark - delete
- (void)p_ClickDeleteButton {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagCellDidSelectedDeleteButton:tagModel:)]) {
        [self.delegate tagCellDidSelectedDeleteButton:self tagModel:self.tagModel];
    }
}


@end
