//
//  ViewControllerFirst.m
//  JPTagViewDemo
//
//  Created by peng on 2019/3/21.
//  Copyright © 2019 peng. All rights reserved.
//

#import "ViewControllerFirst.h"
#import "JPTagView.h"

@interface ViewControllerFirst ()<JPTagViewDelegate>

@end

@implementation ViewControllerFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *models = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 50; i++) {
        
        JPTagModel *model = [[JPTagModel alloc] init];
        model.tagNormalName = [NSString stringWithFormat:@"代号%@_%zd",i%2 ? @"":@"偶数",i];
        model.isSelected = !i;
        [models addObject:model];
    }
    
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
    
    tagView.isCanSelectedMoreTag = NO;
    
    tagView.isShowSelectedState = NO;
    
    tagView.delegate = self;
    
    [tagView setTagViewDataWith:models];
    
    [self.view addSubview:tagView];
}

- (void)tagView:(JPTagView *)tagView didSelectedItem:(NSIndexPath *)indexpath {
    
    NSLog(@"selected :%zd-%zd",indexpath.section,indexpath.item);
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
