//
//  preferentialVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "preferentialVC.h"
#import "LogoTextField.h"
@interface preferentialVC ()
@property (nonatomic,strong)LogoTextField *number;

@end

@implementation preferentialVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setSubview];
    
}
-(void)setSubview{
     [self setNaivTitle:@"我的优惠"];
     UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 138)];
    [self.view addSubview:top];
    top.backgroundColor = [UIColor whiteColor];
    [top addSubview:self.number];
    UIButton *btnPushInfo = [[UIButton alloc]initWithFrame:CGRectMake(14, self.number.bottom+14, SCREEN_WIDTH-28, 40)];
    [top addSubview:btnPushInfo];
    btnPushInfo.backgroundColor =mainColor;
    [btnPushInfo setTitle:@"立即兑换" forState:UIControlStateNormal];
    btnPushInfo.titleLabel.font =FontSize(14);
    [self showPlaceholderViewWithImage:Img(@"youhuijuan") message:@"还没有优惠卷" buttonTitle:nil centerOffsetY:-20 onSuperView:self.view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (LogoTextField *)number {
    if (!_number) {
        _number = [[LogoTextField alloc] initWithFrame:CGRectMake(14,  14, SCREEN_WIDTH-28, kRowHeight)];
        _number.tittle.text =@"优惠码";
        _number.field.placeholder=@"请输入优惠卷";
        }
    return _number;
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
