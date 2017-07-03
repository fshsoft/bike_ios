//
//  ServeVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/6/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "ServeVC.h"
#import "serve.h"
@interface ServeVC ()
@property (nonatomic,strong)serve  *serveView;

@end

@implementation ServeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaivTitle:self.navTitle];
    self.serveView = [[NSBundle mainBundle]loadNibNamed:@"serve" owner:self options:nil].lastObject;
    self.serveView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64);
    [self.view addSubview:self.serveView];
    // Do any additional setup after loading the view.
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
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
