//
//  RootTabVC.m
//  CateTool
//
//  Created by 雨停 on 2017/1/8.
//  Copyright © 2017年 雨停. All rights reserved.
//

#import "RootTabVC.h"
#import "NavigationVC.h"

#import "XYBaseVC.h"



@interface RootTabVC ()

@end

@implementation RootTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarItemTheme];
    [self addNavigationVC];
    // Do any additional setup after loading the view.
}
-(void)setTabBarItemTheme{
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.tabBar setTintColor:[UIColor blueColor]];
    self.tabBar.translucent=NO;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      [UIColor blackColor],
                                                       NSForegroundColorAttributeName,
                                                      FontSize (10),
                                                       NSFontAttributeName,nil]
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor redColor],
                                                       NSForegroundColorAttributeName,
                                                      FontSize(10),
                                                       NSFontAttributeName,nil]
                                             forState:UIControlStateSelected];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH ,  1)];
    lineView.backgroundColor = [UIColor brownColor];
    [self.tabBar addSubview: lineView];
    [self.tabBar setShadowImage: Img (@"new")];
    [self.tabBar setBackgroundImage: [[UIImage alloc]init]];
}
-(void)addNavigationVC{
    NSArray *titleArr       = @[@"首页",@"分类",@"会生活",@"购物车",@"我"];
    NSArray *vcNameArr      = @[@"Home",@"Kinds",@"Life",@"Cart",@"Me"];
    NSArray *tabIconNameArr = @[@"i_home",@"i_kind",@"i_life",@"i_cart",@"i_me"];
    NSMutableArray *vcArr = [NSMutableArray array];
    for (NSInteger i = 0; i < titleArr.count ; i++) {
         NSString *vcName = [NSString stringWithFormat: @"XY%@VC",vcNameArr[i]];
            Class vcClass = NSClassFromString(vcName);
            XYBaseVC *vc  = [[vcClass alloc]init];
                 vc.title = titleArr[i];
        NavigationVC *nav = [[NavigationVC alloc]initWithRootViewController:vc];
        nav.tabBarItem.title = titleArr[i];
        nav.tabBarItem.image =Img(tabIconNameArr[i]);
        nav.tabBarItem.selectedImage =  Img(tabIconNameArr[i]);
        [vc.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
        [vcArr   addObject:nav];
        
    }
    self.viewControllers  = vcArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
