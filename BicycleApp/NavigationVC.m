//
//  NavigationVC.m
//  CateTool
//
//  Created by 雨停 on 2017/1/8.
//  Copyright © 2017年 雨停. All rights reserved.
//

#import "NavigationVC.h"
 
@interface NavigationVC ()

@end

@implementation NavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupNavigationBar{
   
   // [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navi.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                                           }];
}
@end
