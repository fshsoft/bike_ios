//
//  PullMoneyVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "PullMoneyVC.h"

@interface PullMoneyVC ()

@end

@implementation PullMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaivTitle:@"退押金"];
    [self setSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)setSubview{
    UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 60)];
    img.center=CGPointMake(SCREEN_WIDTH*0.5, 124);
    img.image =Img(@"finish");
    [self.view addSubview:img];
    UILabel * labSuccess = [[UILabel alloc]initWithFrame:CGRectMake(0, img.bottom+10, SCREEN_WIDTH, 30)];
    labSuccess.textColor =mainColor;
    labSuccess.textAlignment = NSTextAlignmentCenter;
    labSuccess.text =@"申请退款成功";
    [self.view addSubview:labSuccess];
    UILabel *money  = [[UILabel alloc]initWithFrame:CGRectMake(0, labSuccess.bottom, SCREEN_WIDTH, 30)];
    money.textAlignment = NSTextAlignmentCenter;
    money.text =@"¥ 199";
    [self.view addSubview:money];
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(0, money.bottom+10, SCREEN_WIDTH, 20)];
    detail.font = FontSize(12);
    detail.textAlignment = NSTextAlignmentCenter;
    detail.textColor =gary170;
    detail.text =@"由于银行原因可能会在0-3个工作日内到账";
    [self.view addSubview:detail];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(14, detail.bottom+10, SCREEN_WIDTH-28, 40)];
    [self.view addSubview:btn];
    [btn setTitle:@"充值" forState:UIControlStateNormal];
    btn.backgroundColor =mainColor;
    [btn addTarget:self action:@selector(pushMoney) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)pushMoney{
    
}
-(void)leftFoundation{
    [self.navigationController   popViewControllerAnimated:YES];
}
@end
