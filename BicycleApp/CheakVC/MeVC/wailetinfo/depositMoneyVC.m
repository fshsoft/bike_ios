//
//  depositMoneyVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "depositMoneyVC.h"
#import "payCateView.h"
#import "PaySelect.h"
@interface depositMoneyVC ()
@property (nonatomic,strong)payCateView    *pormot;
@property (nonatomic,strong)payCateView    *Wx;
@property (nonatomic,strong)payCateView    *Alipay;
@end

@implementation depositMoneyVC

- (void)viewDidLoad {
 
    [self setSelectView];
    [super viewDidLoad];
    [self setNaivTitle:@"押金充值"];
    
    // Do any additional setup after loading the view.
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSelectView{
    
    self.pormot  = [[NSBundle mainBundle]loadNibNamed:@"payCate" owner:self options:nil].lastObject;
    self.pormot.frame = CGRectMake(0, 79, SCREEN_WIDTH, 50
                                   );
    [self.view addSubview:self.pormot];
    NSString * textStr =@"押金(可秒退)";
    
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    [attribtStr addAttribute:NSForegroundColorAttributeName
                       value: mainColor
                       range:NSMakeRange(textStr.length-5, 5)];
    self.pormot.title.attributedText =attribtStr;
    
    [self.pormot.cheakBtn setTitle:[NSString stringWithFormat:@"¥%@",[DB getStringById:@"deposit" fromTable:tabName]] forState:UIControlStateNormal];
    UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.pormot.height+14, SCREEN_WIDTH, 1)];
    line.backgroundColor =gary170;
    [self.pormot addSubview:line];
    
    self.Wx = [[NSBundle mainBundle]loadNibNamed:@"payCate" owner:self options:nil].lastObject;
    self.Wx.frame = CGRectMake(0, self.pormot.bottom+15, SCREEN_WIDTH, 50);
    self.Wx.title.text=@"微信支付";
  
    [self.view addSubview:self.Wx];
    
    self.Alipay = [[NSBundle mainBundle]loadNibNamed:@"payCate" owner:self options:nil].lastObject;
    self.Alipay.frame = CGRectMake(0, self.Wx.bottom, SCREEN_WIDTH, 50);
    self.Alipay.title.text=@"支付宝支付";
    [self.view addSubview:self.Alipay];

    
    
       
    UIButton *btnPrice = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREENH_HEIGHT-50, SCREEN_WIDTH-20, 40)];
    [self.view addSubview:btnPrice];
    
    [btnPrice setBackgroundColor:mainColor];
    [btnPrice setTitle:@"去充值" forState:UIControlStateNormal];
    [btnPrice addTarget:self action:@selector(payStyle) forControlEvents:UIControlEventTouchUpInside ];
    
    UILabel *pormot = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT-50-30, SCREEN_WIDTH, 20)];
    [self.view addSubview:pormot];
    pormot.textColor = gary221;
    pormot.font = FontSize(12);
    pormot.textAlignment = NSTextAlignmentCenter ;
    pormot.text = @"小樱不会以任何形式要求您输入银行账号和密码";
    
    
    
}

-(void)payStyle{
//    certifyPersonInfoVC *vc =[[certifyPersonInfoVC alloc]init];
//    [self absPushViewController:vc animated:YES];
    //PaySelect *a =[[PaySelect alloc]init];
    //[a  wxpay];
    //[a getWeChatPayWithOrderName:@"yifenqian" price:@"1"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPay" object:nil];
    
}

#pragma mark 移除通知
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 事件
- (void)getOrderPayResult:(NSNotification *)notification
{
    NSLog(@"userInfo: %@",notification.userInfo);
    
    if ([notification.object isEqualToString:@"0"])
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if([notification.object isEqualToString:@"-2"])
    {
        [self alert:@"提示" msg:@"用户取消了支付"];
    }
    else
    {
        [self alert:@"提示" msg:@"支付失败"];
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}

@end
