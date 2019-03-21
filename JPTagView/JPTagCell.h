//
//  JPTagCell.h
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JPTagModel,JPTagCell;
@protocol JPTagCellDelegate <NSObject>

- (void)tagCellDidSelectedDeleteButton:(JPTagCell *)tagCell tagModel:(JPTagModel *)tagModel;

@end

@interface JPTagCell : UICollectionViewCell

/** tagModel */
@property(nonatomic,strong) JPTagModel *tagModel;

@property(nonatomic,weak)id<JPTagCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
