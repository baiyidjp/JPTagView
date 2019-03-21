//
//  JPTagLayout.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/14.
//  Copyright © 2019 peng. All rights reserved.
//

#import "JPTagLayout.h"
#import "JPTagModel.h"

@interface JPTagLayout ()

/** 所有item的布局属性 */
@property(nonatomic,strong) NSMutableArray *itemAttributesArray;
/** 存储一行中最后一列item最大X值 */
@property(nonatomic,assign) CGFloat itemAttributeMaxX;
/** 存储最后一行item最小Y值 */
@property(nonatomic,assign) CGFloat itemAttributeMinY;
/** 存储section的Y值 */
@property(nonatomic,assign) CGFloat sectionAttributeY;
/** contentSize */
@property(nonatomic,assign) CGSize collectionContentSize;
/** shouldanimationArr */
@property(nonatomic,strong) NSMutableArray *shouldanimationArr;

@end

@implementation JPTagLayout

/** 初始化layout  每次刷新都会重新调用 */
- (void)prepareLayout{
    
    [super prepareLayout];
    
    [self.itemAttributesArray removeAllObjects];
    
    self.sectionAttributeY = 0;
    self.itemAttributeMaxX = self.edgeInsets.left;
    self.itemAttributeMinY = self.edgeInsets.top;
    
    NSInteger sectionCount = self.dataArray.count;
    for (NSInteger i = 0; i < sectionCount; i++) {
        
        if (self.isShowSection) {
            
            NSIndexPath *sectionIndexPath = [NSIndexPath indexPathForItem:0 inSection:i];
            UICollectionViewLayoutAttributes *sectionAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:sectionIndexPath];
            [self.itemAttributesArray addObject:sectionAttribute];
        }
        
        JPTagModel *sectionModel = self.dataArray[i];
        NSInteger cellCount = sectionModel.subTags.count;
        
        for (NSInteger j = 0; j < cellCount; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.itemAttributesArray addObject:attribute];
            self.itemAttributeMaxX = CGRectGetMaxX(attribute.frame)+self.columnMargin;
        }
    }
    
    
    UICollectionViewLayoutAttributes *attribute = self.itemAttributesArray.lastObject;
    
    self.collectionContentSize = CGSizeMake(self.collectionView.frame.size.width, CGRectGetMaxY(attribute.frame));
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.itemAttributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    JPTagModel *sectionModel = [self.dataArray objectAtIndex:indexPath.section];
    JPTagModel *tagModel = [sectionModel.subTags objectAtIndex:indexPath.item];
    CGSize attributeSize = tagModel.tagSize;
    
    CGFloat attributeX = self.itemAttributeMaxX;
    CGFloat viewMaxX = self.collectionView.frame.size.width - self.edgeInsets.right;
    CGFloat attributeY = self.itemAttributeMinY;
    
    if (attributeX + attributeSize.width >viewMaxX ) {
        attributeY = self.itemAttributeMinY+attributeSize.height+self.rowMargin;
        attributeX = self.edgeInsets.left;
        self.itemAttributeMinY = attributeY;
    }
    CGRect attributeFrame = CGRectMake(attributeX, attributeY, attributeSize.width, attributeSize.height);
    attribute.frame = attributeFrame;
    self.sectionAttributeY = self.itemAttributeMinY+attributeSize.height+self.tagSectionMargin;
    return attribute;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionViewLayoutAttributes *headerAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
        
        headerAttribute.frame = CGRectMake(0, self.sectionAttributeY, CGRectGetWidth(self.collectionView.frame), self.sectionHeight);
        
        self.itemAttributeMaxX = self.edgeInsets.left;
        
        self.itemAttributeMinY = self.sectionAttributeY + self.sectionHeight + self.tagSectionMargin;
        
        return headerAttribute;
    }
    
    UICollectionViewLayoutAttributes *headerAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    
    return headerAttribute;
}

- (CGSize)collectionViewContentSize {
    
    return self.collectionContentSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
}

- (CGFloat)getTagViewHeight {
    
    [self prepareLayout];
    
    return self.collectionContentSize.height;
}

- (NSMutableArray *)itemAttributesArray{
    
    if (!_itemAttributesArray) {
        
        _itemAttributesArray = [NSMutableArray array];
    }
    return _itemAttributesArray;
}

- (NSMutableArray *)shouldanimationArr{
    
    if (!_shouldanimationArr) {
        
        _shouldanimationArr = [NSMutableArray array];
    }
    return _shouldanimationArr;
}

@end
