//
//  ViewControllerThird.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/21.
//  Copyright © 2019 peng. All rights reserved.
//

#import "ViewControllerThird.h"
#import "JPTagView.h"

@interface ViewControllerThird ()

@end

@implementation ViewControllerThird

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
    tagView.tagViewMaxHeight = (self.view.bounds.size.height-naviagtionHeight)*1;
    
    tagView.isShowTagBorder = YES;
    tagView.tagSelectedBorderWidth = 2;
    tagView.tagSelectedBorderColor = [UIColor blackColor];
//    tagView.tagBorderColor = [UIColor redColor];
//    tagView.tagBorderWidth = 2;
    
    [tagView setTagViewDataWith:models];
    
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
