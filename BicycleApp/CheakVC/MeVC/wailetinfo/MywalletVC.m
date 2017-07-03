//
//  MywalletVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "MywalletVC.h"
#import "depositMoneyVC.h"
#import "WalletMoneyVC.h"
#import "PullMoneyVC.h"
#import "detaileMessageVC.h"
@interface MywalletVC ()
@property (nonatomic,strong)UILabel  * money;
@property (nonatomic,strong)UIButton *pushMoney;
@property (nonatomic,strong)UIButton *depositMoney;
@property (nonatomic,strong) UIView *backgroungView;
@end

@implementation MywalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
    // Do any additional setup after loading the view.
}
-(void)setSubview{
    [self setNaivTitle:@"我的钱包"];
    [self.navi.rightBtn setTitle:@"明细" forState:UIControlStateNormal];
    self.view.backgroundColor = RGBColor(245, 245, 245);
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 110)];
    topview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topview];
    
    self.money = [[UILabel alloc]initWithFrame:CGRectMake(0,30, SCREEN_WIDTH, 40)];
    self.money.font = FontBold(30);
    self.money.textAlignment = NSTextAlignmentCenter;
    self.money.text=@"0.0";
    self.money.textColor =gary51;
    [topview  addSubview:self.money];
    UILabel *labPromit = [[UILabel alloc]initWithFrame:CGRectMake(0, self.money.bottom +10, SCREEN_WIDTH, 20)];
    labPromit.textAlignment = NSTextAlignmentCenter;
    labPromit.font =FontSize(11);
    labPromit.textColor = gary105;
    labPromit.text=@"我的余额(元)";
    [topview addSubview:labPromit];
    self.pushMoney = [[UIButton alloc]initWithFrame:CGRectMake(14, topview.bottom+20, SCREEN_WIDTH-28, 40)];
    [self.view addSubview:self.pushMoney];
    self.pushMoney.backgroundColor =mainColor;
    [self.pushMoney setTitle:@"充值" forState:UIControlStateNormal];
    [self.pushMoney addTarget:self action:@selector(pushMoneyFoundation) forControlEvents:UIControlEventTouchUpInside];
    self.pushMoney.titleLabel.font =FontSize(15);
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.pushMoney.bottom+20, SCREEN_WIDTH, 40)];
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom ];
    
    UILabel *depositLab =[[UILabel alloc]initWithFrame:CGRectMake(14, 0, 80, 40)];
    [bottom addSubview:depositLab];
    depositLab.font  =FontSize(14);
    depositLab.text =@"我的押金";
    depositLab.textColor =gary51;
    self.depositMoney = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-14-140, 0, 140, 40)];
   
    [bottom   addSubview: self.depositMoney];
    
    [self.depositMoney addTarget:self action:@selector(depositMoneyFoundation) forControlEvents:UIControlEventTouchUpInside];
    [self.depositMoney setTitle:@"199元,退押金" forState:UIControlStateNormal ];
    [self.depositMoney setTitleColor:gary170 forState:UIControlStateNormal];
    self.depositMoney.titleLabel.font =FontSize(14);
    [self.depositMoney setImage:Img(@"home_ic_enter") forState:UIControlStateNormal];
    [self.depositMoney setImageEdgeInsets:UIEdgeInsetsMake(0,  134, 0, 0)];
    }
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightFoundation{
    detaileMessageVC   *vc  = [[detaileMessageVC alloc]init];
    [self absPushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushMoneyFoundation{
    WalletMoneyVC *vc = [[WalletMoneyVC  alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)depositMoneyFoundation{
//    depositMoneyVC *vc = [[depositMoneyVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self setBackgroundView];
    
}
-(void)setBackgroundView{
    self.backgroungView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64)];
  
    [self.view addSubview:self.backgroungView];
    self.backgroungView .backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2];
    UIView * vic =[[ UIView alloc]initWithFrame:CGRectMake(64, 100, SCREEN_WIDTH-128, SCREEN_WIDTH-128+40)];
    [self.backgroungView addSubview:vic];
    
    
    UIImageView *img  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-128, (SCREEN_WIDTH-128)/2.0)];
    img.image =Img(@"pic_tui");
    vic.backgroundColor = [UIColor whiteColor];
    vic.layer.cornerRadius  = 5;
    vic.layer.masksToBounds = YES;
    [vic addSubview:img];
    UILabel *labPromort = [[UILabel alloc]initWithFrame:CGRectMake(14,((SCREEN_WIDTH-128)/2.0)+30, (SCREEN_WIDTH-128)-28,  (SCREEN_WIDTH-128)*0.5-50)];
     [vic addSubview:labPromort];
    labPromort.numberOfLines=0;
    labPromort.font = FontSize(12);
    labPromort.textColor =gary170;
    labPromort.text = @"押金会立即退回,退款后您将不能使用百宝共享单车，确认要进行此退款吗？";
    
    UIButton * btnleft = [[UIButton alloc]initWithFrame:CGRectMake(14,labPromort.bottom+10,(vic.width-34)/2.0, 30)];
    [vic addSubview:btnleft];
    btnleft.layer.cornerRadius =3;
    btnleft.titleLabel.font = FontSize(13);
    [btnleft setTitle:@"退押金" forState:UIControlStateNormal];
    [btnleft setTitleColor:gary153 forState:UIControlStateNormal];
    [btnleft addTarget:self action:@selector(moneyPull) forControlEvents:UIControlEventTouchUpInside];
    [btnleft setBackgroundColor:RGBColor(237, 237, 237)];
    UIButton * btnright = [[UIButton alloc]initWithFrame:CGRectMake((vic.width-34)/2.0+19,labPromort.bottom+10,(vic.width-34)/2.0, 30)];
    [vic addSubview:btnright];
    btnright.layer.cornerRadius =3;
    [btnright addTarget:self action:@selector(cancelPull) forControlEvents:UIControlEventTouchUpInside];
    [btnright setTitle:@"继续使用" forState:UIControlStateNormal];
    btnright.titleLabel.font = FontSize(13);
    [btnright setBackgroundColor:mainColor];
}
-(void)moneyPull{
    PullMoneyVC *pullvc = [[PullMoneyVC alloc]init];
    [self absPushViewController:pullvc animated:YES];
}
-(void)cancelPull{
    [self.backgroungView removeFromSuperview];
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
