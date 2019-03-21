//
//  ViewControllerSecond.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/21.
//  Copyright © 2019 peng. All rights reserved.
//

#import "ViewControllerSecond.h"
#import "JPTagView.h"

@interface ViewControllerSecond ()

@end

@implementation ViewControllerSecond

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *models = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        
        JPTagModel *sectionModel = [[JPTagModel alloc] init];
        sectionModel.tagNormalName = [NSString stringWithFormat:@"组头_%zd",i];
        
        NSMutableArray *sectionModels = [NSMutableArray array];
        for (NSInteger i = 0; i < 10; i++) {
            
            JPTagModel *model = [[JPTagModel alloc] init];
            model.tagNormalName = [NSString stringWithFormat:@"代号%@_%zd",i%2 ? @"":@"偶数",i];
            [sectionModels addObject:model];
        }
        
        sectionModel.subTags = [sectionModels copy];
        
        [models addObject:sectionModel];
    }
    
    CGFloat naviagtionHeight = 64;
    if (self.view.bounds.size.height >= 812 ) {
        naviagtionHeight = 88;
    }
    
    JPTagView *tagView = [[JPTagView alloc] initWithFrame:CGRectMake(0, naviagtionHeight, self.view.bounds.size.width, 0)];
    
    //一定要设置最大高度,内部会默认计算,跟最大高度比较 取较小的.
    //如不设置,当TagView超出屏幕范围时,无法滚动.
    tagView.tagViewMaxHeight = (self.view.bounds.size.height-naviagtionHeight)*0.5;
    
    //展示删除的时候需要调节一些间距 这样效果跟不展示delete是一样的UI展示,当然可以不更改
    tagView.isShowDelete = YES;
    tagView.tagBackContentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    tagView.tagColumnMargin = 2;
    tagView.tagRowMargin = 2;
    //设置不可以点击
    tagView.isCanSelectedTag = NO;
    
    tagView.dataArray = models;
    
    [self.view addSubview:tagView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
