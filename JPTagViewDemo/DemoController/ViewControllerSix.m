//
//  ViewControllerSix.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/23.
//  Copyright © 2019 peng. All rights reserved.
//

#import "ViewControllerSix.h"
#import "JPTagView.h"

@interface ViewControllerSix ()<JPTagViewDelegate>

/** tagView */
@property(nonatomic,strong) JPTagView *tagView;

/** models */
@property(nonatomic,strong) NSMutableArray *models;

@end

@implementation ViewControllerSix

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *models = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        
        JPTagModel *model = [[JPTagModel alloc] init];
        model.tagNormalName = [NSString stringWithFormat:@"代号%@_%zd",i%2 ? @"":@"偶数",i];
        [models addObject:model];
    }
    
    JPTagModel *addModel = [[JPTagModel alloc] init];
    
    NSMutableAttributedString *attributesString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", @"Add Tags"]];
    [attributesString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attributesString.length)];
    [attributesString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, attributesString.length)];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"icon_delete"];
    attch.bounds = CGRectMake(0, 0, 12, 12);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attributesString insertAttributedString:string atIndex:0];
    
    addModel.tagNormalAttributedName = attributesString;
    addModel.isSelected = YES;
    addModel.isCanSelectedTag = YES;
    addModel.isShowDelete = NO;
    addModel.isCustomTag = YES;
    addModel.tagBackNormalColor = [UIColor whiteColor];
    addModel.tagNameNormalColor = [UIColor colorWithRed:90/255.0 green:43/255.0 blue:129/255.0 alpha:1];
    addModel.tagBackSelectedColor = [UIColor colorWithRed:90/255.0 green:43/255.0 blue:129/255.0 alpha:1];
    addModel.tagNameNormalFont = [UIFont systemFontOfSize:14];
    
    addModel.isShowTagBorder = YES;
    addModel.tagSelectedBorderColor = [UIColor colorWithRed:90/255.0 green:43/255.0 blue:129/255.0 alpha:1];
    addModel.tagSelectedBorderWidth = 1;
    addModel.isShowTagCornerRadius = YES;
    
    addModel.isTagCanClickWhenSelected = NO;
    
    addModel.tagBackContentInset = UIEdgeInsetsMake(4, 0, 4, 0);
    
    [models addObject:addModel];
    
    CGFloat naviagtionHeight = 64;
    if (self.view.bounds.size.height >= 812 ) {
        naviagtionHeight = 88;
    }
    
    JPTagView *tagView = [[JPTagView alloc] initWithFrame:CGRectMake(0, naviagtionHeight, self.view.bounds.size.width, 0)];
    
    //一定要设置最大高度,内部会默认计算,跟最大高度比较 取较小的.
    //如不设置,当TagView超出屏幕范围时,无法滚动.
    tagView.tagViewMaxHeight = self.view.bounds.size.height-naviagtionHeight;
    
    //只展示subTags,忽略了section
    tagView.isShowSection = NO;
    
    tagView.tagBackNormalColor = [UIColor whiteColor];
    tagView.tagNameNormalColor = [UIColor colorWithRed:90/255.0 green:43/255.0 blue:129/255.0 alpha:1];
    tagView.tagBackSelectedColor = [UIColor colorWithRed:90/255.0 green:43/255.0 blue:129/255.0 alpha:1];
    
    tagView.isShowTagBorder = YES;
    tagView.tagBorderColor = [UIColor colorWithRed:90/255.0 green:43/255.0 blue:129/255.0 alpha:1];
    tagView.tagBorderWidth = 1;
    
    tagView.isShowDelete = YES;
    tagView.tagBackContentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    tagView.tagColumnMargin = 2;
    tagView.tagRowMargin = 2;
    
    tagView.isTagCanClickWhenSelected = NO;
    tagView.isCanSelectedTag = NO;
    
    tagView.tagDeleteImage = [UIImage imageNamed:@"icon_delete"];
    
    [tagView setTagViewDataWith:models];
    
    tagView.delegate = self;
    
    [self.view addSubview:tagView];
    
    self.tagView = tagView;
    [self.models addObjectsFromArray:models];
}

- (void)tagView:(JPTagView *)tagView didSelectedItem:(NSIndexPath *)indexpath {
    
    NSLog(@"%zd %zd",indexpath.section,indexpath.row);
    
    JPTagModel *newModel = [[JPTagModel alloc] init];
    
    newModel.tagNormalName = [NSString stringWithFormat:@"New_%zd",self.models.count];
    
    [self.models insertObject:newModel atIndex:0];
    
    [tagView setTagViewDataWith:self.models];
}

- (void)tagView:(JPTagView *)tagVIew didDeleteItem:(NSIndexPath *)indexpath {
    
    [self.models removeObjectAtIndex:indexpath.item];
}

- (NSMutableArray *)models{
    
    if (!_models) {
        
        _models = [NSMutableArray array];
    }
    return _models;
}


@end
