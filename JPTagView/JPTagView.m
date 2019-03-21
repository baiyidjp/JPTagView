//
//  JPTagView.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import "JPTagView.h"
#import "UIView+JPCategory.h"
#import "UIImageView+JPCategory.h"
#import "JPTagLayout.h"
#import "JPTagCell.h"

static NSString *JPTagCellID = @"JPTagCellID";
static NSString *JPTagHeaderCellID = @"JPTagHeaderCellID";

@interface JPTagView ()<UICollectionViewDelegate,UICollectionViewDataSource,JPTagCellDelegate>

/** tagViewBackImageView */
@property(nonatomic,strong) UIImageView *tagViewBackImageView;
/** collectionView */
@property(nonatomic,strong) UICollectionView *collectionView;
/** layout */
@property(nonatomic,strong) JPTagLayout *flowLayout;
/** selectedIndexPath */
@property(nonatomic,strong) NSIndexPath *selectedIndexPath;
/** isLongPressDeleteStatus */
@property(nonatomic,assign) BOOL isLongPressDeleteStatus;

@end

@implementation JPTagView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self p_ConfigDefaultData];
        
        [self p_SetUI];
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self p_ConfigDefaultData];
        
        [self p_SetUI];
    }
    return self;
}

#pragma mark - default data
- (void)p_ConfigDefaultData {
    
    self.tagViewBackColor = [UIColor whiteColor];
    self.tagViewContentInset = UIEdgeInsetsMake(0, 24, 0, 24);
    self.tagViewMinHeight = 0;
    self.tagViewMaxHeight = MAXFLOAT;
    self.tagViewScrollEnabled = YES;
    self.isCanSelectedTag = YES;
    self.isCanSelectedMoreTag = YES;
    self.isShowSection = YES;
    
    self.tagColumnMargin = 10;
    self.tagRowMargin = 10;
    self.tagSectionMargin = 0;
    
    self.tagMinWidth = 60;
    self.tagMinHeight = 30;
    self.tagNameContentInset = UIEdgeInsetsMake(6, 14, 6, 14);
    
    NSBundle *tagViewBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"JPTagView" ofType:@"bundle"]];
    self.tagDeleteImage = [UIImage imageWithContentsOfFile:[tagViewBundle pathForResource:@"icon_delete@2x" ofType:@"png"]];
    self.isShowDelete = NO;
    self.isTagCanClickWhenSelected = YES;
    self.isCanLongPressShowDelete = NO;
    self.isShakeWhenShowDelete = NO;
    
    self.tagSectionHeight = 50;
    self.tagSectionBackColor = [UIColor whiteColor];
    self.tagSectionNameFont = [UIFont systemFontOfSize:17];
    self.tagSectionNameColor = [UIColor blackColor];
    self.tagSectionNameInset = UIEdgeInsetsMake(0, 24, 0, 24);;
    self.tagSectionAlignment = TagSectionAlignment_Left;
    
    self.tagNameNormalFont = [UIFont systemFontOfSize:14];
    self.tagNameSelectedFont = [UIFont systemFontOfSize:14];
    self.tagNameNormalColor = [UIColor blackColor];
    self.tagNameSelectedColor = [UIColor whiteColor];
    
    self.isShowTagCornerRadius = YES;
    self.isShowTagBorder = NO;
    self.tagBorderWidth = 0;
    self.tagBorderColor = [UIColor clearColor];
    self.tagDeleteCorner = TagDeleteCornerTopRight;
    
    self.tagBackNormalColor = [UIColor grayColor];
    self.tagBackSelectedColor = [UIColor redColor];
    self.tagBackContentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}

#pragma mark 设置UI视图
- (void)p_SetUI {
    
    UIImageView *tagViewBackImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    tagViewBackImageView.hidden = YES;
    [self addSubview:tagViewBackImageView];
    self.tagViewBackImageView = tagViewBackImageView;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[JPTagCell class] forCellWithReuseIdentifier:JPTagCellID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:JPTagHeaderCellID];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled = self.tagViewScrollEnabled;
    collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    JPTagModel *sectionModel = self.dataArray[section];
    
    return sectionModel.subTags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JPTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JPTagCellID forIndexPath:indexPath];

    [cell.contentView jp_removeAllSubViews];
    
    JPTagModel *sectionModel = self.dataArray[indexPath.section];
    
    JPTagModel *tagModel = sectionModel.subTags[indexPath.item];
    
    cell.tagModel = tagModel;
    
    cell.delegate = self;
    
    if (self.isCanLongPressShowDelete) {
        
        //add long press
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(p_LongPressCell:)];
        longPress.minimumPressDuration = 0.5;
        [cell addGestureRecognizer:longPress];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        JPTagModel *sectionModel = self.dataArray[indexPath.section];
        
        UICollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:JPTagHeaderCellID forIndexPath:indexPath];
        
        [sectionHeaderView jp_removeAllSubViews];
        
        UIView *backView = [[UIView alloc] initWithFrame:sectionHeaderView.bounds];
        backView.backgroundColor = sectionModel.tagSectionBackColor;
        [sectionHeaderView addSubview:backView];
        
        UILabel *sectionLabel = [[UILabel alloc] initWithFrame:sectionHeaderView.bounds];
        sectionLabel.textColor = sectionModel.tagSectionNameColor;
        sectionLabel.font = sectionModel.tagSectionNameFont;
        sectionLabel.text = sectionModel.tagNormalName;
        sectionLabel.jp_x = sectionModel.tagSectionNameInset.left;
        sectionLabel.jp_w = self.jp_w - sectionModel.tagSectionNameInset.left - sectionModel.tagSectionNameInset.right;
        [sectionHeaderView addSubview:sectionLabel];
        
        return sectionHeaderView;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.jp_w, self.tagSectionHeight);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.isCanSelectedTag) {
        return;
    }
    
    if (self.isCanSelectedMoreTag) {
        
        JPTagModel *sectionModel = self.dataArray[indexPath.section];
        
        JPTagModel *tagModel = sectionModel.subTags[indexPath.item];
        
        if (tagModel.isSelected && !tagModel.isTagCanClickWhenSelected) {
            
            return;
        }
        
        tagModel.isSelected = !tagModel.isSelected;
        
        [UIView performWithoutAnimation:^{
           
            [collectionView performBatchUpdates:^{
                
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                
            } completion:^(BOOL finished) {
                
            }];
            
        }];

    } else {
        
        JPTagModel *sectionModel = self.dataArray[indexPath.section];
        
        JPTagModel *tagModel = sectionModel.subTags[indexPath.item];
        
        tagModel.isSelected = !tagModel.isSelected;
        
        [UIView performWithoutAnimation:^{
            
            [collectionView performBatchUpdates:^{
                
                if (self.selectedIndexPath && ![self.selectedIndexPath isEqual:indexPath]) {
                    
                    JPTagModel *sectionModel = self.dataArray[self.selectedIndexPath.section];
                    
                    JPTagModel *selectedTagModel = sectionModel.subTags[self.selectedIndexPath.item];
                    
                    selectedTagModel.isSelected = NO;
                    
                    [collectionView reloadItemsAtIndexPaths:@[indexPath,self.selectedIndexPath]];
                    
                } else {
                    
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                
            } completion:^(BOOL finished) {
                
            }];
            
        }];
        
        self.selectedIndexPath = indexPath;
    }
}

#pragma mark - long press
- (void)p_LongPressCell:(UIGestureRecognizer *)longPress {
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        self.isLongPressDeleteStatus = !self.isLongPressDeleteStatus;
        
        for (JPTagModel *sectionModel in self.dataArray) {
            
            for (JPTagModel *tagModel in sectionModel.subTags) {
                
                tagModel.isShowDelete = self.isLongPressDeleteStatus;
                tagModel.isShowShakeAnimation = self.isLongPressDeleteStatus;
            }
        }
        
        [self.collectionView reloadData];
    }
}

#pragma mark - JPTagCellDelegate
- (void)tagCellDidSelectedDeleteButton:(JPTagCell *)tagCell tagModel:(JPTagModel *)tagModel {
    
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tagCell];
    
    //delete
    JPTagModel *sectionModel = self.dataArray[indexPath.section];
    
    NSMutableArray *subTags = [NSMutableArray arrayWithArray:sectionModel.subTags];
    
    [subTags removeObject:tagModel];
    
    sectionModel.subTags = [subTags copy];
    
    if (subTags.count) {
        
        [self.collectionView performBatchUpdates:^{
            
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            
        } completion:^(BOOL finished) {
        }];
        
    } else {
        
        NSMutableArray *sectionDataArray = [NSMutableArray arrayWithArray:self.dataArray];
        [sectionDataArray removeObject:sectionModel];
        self.dataArray = [sectionDataArray copy];
    }
    
}

- (void)setDataArray:(NSArray<JPTagModel *> *)dataArray {
    
    _dataArray = dataArray;
    
    for (JPTagModel *sectionModel in dataArray) {
        
        sectionModel.tagSectionHeight = sectionModel.tagSectionHeight ? sectionModel.tagSectionHeight : self.tagSectionHeight;
        sectionModel.tagSectionBackColor = sectionModel.tagSectionBackColor ? sectionModel.tagSectionBackColor : self.tagSectionBackColor;
        sectionModel.tagSectionNameFont = sectionModel.tagSectionNameFont ? sectionModel.tagSectionNameFont : self.tagSectionNameFont;
        sectionModel.tagSectionNameColor = sectionModel.tagSectionNameColor ? sectionModel.tagSectionNameColor : self.tagSectionNameColor;
        sectionModel.tagSectionNameInset = sectionModel.tagSectionNameInset.left ? sectionModel.tagSectionNameInset : self.tagSectionNameInset;
        sectionModel.tagSectionAlignment = sectionModel.tagSectionAlignment ? sectionModel.tagSectionAlignment : self.tagSectionAlignment;
        
        for (JPTagModel *tagModel in sectionModel.subTags) {
            
            tagModel.tagDeleteImage = tagModel.tagDeleteImage ? tagModel.tagDeleteImage : self.tagDeleteImage;
            tagModel.isShowDelete = tagModel.isShowDelete ? YES : self.isShowDelete;
            tagModel.isTagCanClickWhenSelected = tagModel.isTagCanClickWhenSelected ? YES : self.isTagCanClickWhenSelected;
            tagModel.isShakeWhenShowDelete = tagModel.isShakeWhenShowDelete ? YES : self.isShakeWhenShowDelete;
            
            tagModel.tagNameNormalFont = tagModel.tagNameNormalFont ? tagModel.tagNameNormalFont : self.tagNameNormalFont;
            tagModel.tagNameSelectedFont = tagModel.tagNameSelectedFont ? tagModel.tagNameSelectedFont : self.tagNameSelectedFont;
            tagModel.tagNameNormalColor = tagModel.tagNameNormalColor ? tagModel.tagNameNormalColor : self.tagNameNormalColor;
            tagModel.tagNameSelectedColor = tagModel.tagNameSelectedColor ? tagModel.tagNameSelectedColor : self.tagNameSelectedColor;
            
            tagModel.isShowTagCornerRadius = tagModel.isShowTagCornerRadius ? YES : self.isShowTagCornerRadius;
            tagModel.isShowTagBorder = tagModel.isShowTagBorder ? YES : self.isShowTagBorder;
            tagModel.tagBorderWidth = tagModel.tagBorderWidth ? tagModel.tagBorderWidth : self.tagBorderWidth;
            tagModel.tagBorderColor = tagModel.tagBorderColor ? tagModel.tagBorderColor : self.tagBorderColor;
            
            tagModel.tagDeleteCorner = tagModel.tagDeleteCorner ? tagModel.tagDeleteCorner : self.tagDeleteCorner;
            
            tagModel.tagBackNormalColor = tagModel.tagBackNormalColor ? tagModel.tagBackNormalColor : self.tagBackNormalColor;
            tagModel.tagBackSelectedColor = tagModel.tagBackSelectedColor ? tagModel.tagBackSelectedColor : self.tagBackSelectedColor;
            tagModel.tagBackNormalImage = tagModel.tagBackNormalImage ? tagModel.tagBackNormalImage : self.tagBackNormalImage;
            tagModel.tagBackSelectedImage = tagModel.tagBackSelectedImage ? tagModel.tagBackSelectedImage : self.tagBackSelectedImage;
            tagModel.tagBackNormalImageUrl = tagModel.tagBackNormalImageUrl.length ? tagModel.tagBackNormalImageUrl : self.tagBackNormalImageUrl;
            tagModel.tagBackSelectedImageUrl = tagModel.tagBackSelectedImageUrl.length ? tagModel.tagBackSelectedImageUrl : self.tagBackSelectedImageUrl;
            tagModel.tagBackContentInset = tagModel.tagBackContentInset.left ? tagModel.tagBackContentInset : self.tagBackContentInset;
            
            CGSize nameSize = [tagModel.tagNormalName sizeWithAttributes:@{NSFontAttributeName:tagModel.tagNameNormalFont}];
            CGFloat nameWidth = nameSize.width+self.tagNameContentInset.left+self.tagNameContentInset.right;
            CGFloat nameHeight = nameSize.height+self.tagNameContentInset.top+self.tagNameContentInset.bottom;
            if (nameWidth < self.tagMinWidth) {
                nameWidth = self.tagMinWidth;
            }
            if (nameHeight < self.tagMinHeight) {
                nameHeight = self.tagMinHeight;
            }
            tagModel.tagSize = CGSizeMake(nameWidth+tagModel.tagBackContentInset.left+tagModel.tagBackContentInset.right, (NSInteger)(nameHeight+tagModel.tagBackContentInset.top+tagModel.tagBackContentInset.bottom));
            
            tagModel.tagCornerRadius = ((NSInteger)nameHeight)*0.5;
        }
    }

    self.flowLayout.dataArray = dataArray;
    
    CGFloat viewHeight = [self.flowLayout getTagViewHeight];
    
    if (viewHeight < self.tagViewMinHeight) {
        
        viewHeight = self.tagViewMinHeight;
    }
    
    if (viewHeight > self.tagViewMaxHeight) {
        
        viewHeight = self.tagViewMaxHeight;
    }
    
    self.jp_h = viewHeight;
    
    self.tagViewBackImageView.jp_h = self.collectionView.jp_h = self.jp_h;
    
    [self.collectionView reloadData];
    
}

- (CGFloat)getTagViewHeight:(NSArray<JPTagModel *> *)dataArray {
    
    for (JPTagModel *sectionModel in dataArray) {
        
        for (JPTagModel *tagModel in sectionModel.subTags) {
            
            CGSize nameSize = [tagModel.tagNormalName sizeWithAttributes:@{NSFontAttributeName:self.tagNameNormalFont}];
            CGFloat nameWidth = nameSize.width+self.tagNameContentInset.left+self.tagNameContentInset.right;
            CGFloat nameHeight = nameSize.height+self.tagNameContentInset.top+self.tagNameContentInset.bottom;
            if (nameWidth < self.tagMinWidth) {
                nameWidth = self.tagMinWidth;
            }
            if (nameHeight < self.tagMinHeight) {
                nameHeight = self.tagMinHeight;
            }
            tagModel.tagSize = CGSizeMake(nameWidth, (NSInteger)nameHeight);
        }
    }
    
    self.flowLayout.dataArray = dataArray;
    
    return [self.flowLayout getTagViewHeight];
}


- (void)setTagViewScrollEnabled:(BOOL)tagViewScrollEnabled {
    
    _tagViewScrollEnabled = tagViewScrollEnabled;
    
    self.collectionView.scrollEnabled = tagViewScrollEnabled;
}

- (void)setTagColumnMargin:(CGFloat)tagColumnMargin {
    
    _tagColumnMargin = tagColumnMargin;
    
    self.flowLayout.columnMargin = tagColumnMargin;
}

- (void)setTagRowMargin:(CGFloat)tagRowMargin {
    
    _tagRowMargin = tagRowMargin;
    
    self.flowLayout.rowMargin = tagRowMargin;
}

- (void)setTagSectionMargin:(CGFloat)tagSectionMargin {
    
    _tagSectionMargin = tagSectionMargin;
    
    self.flowLayout.tagSectionMargin = tagSectionMargin;
}

- (void)setTagViewContentInset:(UIEdgeInsets)tagViewContentInset {
    
    _tagViewContentInset = tagViewContentInset;
    
    self.flowLayout.edgeInsets = tagViewContentInset;
}

- (void)setTagSectionHeight:(CGFloat)tagSectionHeight {
    
    _tagSectionHeight = tagSectionHeight;
    
    self.flowLayout.sectionHeight = tagSectionHeight;
}

- (void)setIsShowSection:(BOOL)isShowSection {
    
    _isShowSection = isShowSection;
    
    self.flowLayout.isShowSection = isShowSection;
}

- (void)setTagViewBackColor:(UIColor *)tagViewBackColor {
    
    _tagViewBackColor = tagViewBackColor;
    
    self.backgroundColor = tagViewBackColor;
    
    self.tagViewBackImageView.hidden = YES;
}

- (void)setTagViewBackImage:(UIImage *)tagViewBackImage {
    
    _tagBackNormalImage = tagViewBackImage;
    
    if (tagViewBackImage) {
        
        self.tagViewBackImageView.hidden = NO;
        
        self.tagViewBackImageView.image = tagViewBackImage;
    }
    
}

- (void)setTagViewBackImageUrl:(NSString *)tagViewBackImageUrl {
    
    _tagViewBackImageUrl = tagViewBackImageUrl;
    
    if (tagViewBackImageUrl.length) {
        
        self.tagViewBackImageView.hidden = NO;
        //下载网络图片
        [UIImageView jp_downloadImageWithURL:[NSURL URLWithString:tagViewBackImageUrl] completed:^(UIImage * _Nullable image, NSURL * _Nullable imageURL) {
            
            self.tagViewBackImageView.image = image;
        }];
    }
    
}

#pragma mark - lazy
- (JPTagLayout *)flowLayout{
    
    if (!_flowLayout) {
        
        _flowLayout = [[JPTagLayout alloc] init];
        _flowLayout.columnMargin = self.tagColumnMargin;
        _flowLayout.rowMargin = self.tagRowMargin;
        _flowLayout.edgeInsets = self.tagViewContentInset;
        _flowLayout.sectionHeight = self.tagSectionHeight;
        _flowLayout.isShowSection = self.isShowSection;
    }
    return _flowLayout;
}

@end
