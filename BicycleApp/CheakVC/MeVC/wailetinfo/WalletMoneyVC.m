//
//  WalletMoneyVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "WalletMoneyVC.h"
#import "MoneySelectView.h"
#import "payCateView.h"
#import "PaySelect.h"
#import "appInfoModel.h"
@interface WalletMoneyVC ()
@property (nonatomic,strong)payCateView    *Wx;
@property (nonatomic,strong)payCateView    *Alipay;
@property (nonatomic,strong)MoneySelectView *topSelctView;
@property (nonatomic,strong)NSString        * price;
@end

@implementation WalletMoneyVC

- (void)viewDidLoad {
    self.price =@"100";
    [super viewDidLoad];
    [self setNaivTitle:@"钱包充值"];
    [self setSelectView];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     }
-(void)setSelectView{
     __weak WalletMoneyVC *weakself = self;
    self.topSelctView = [[NSBundle mainBundle]loadNibNamed:@"moneySelect" owner:self options:nil].lastObject;
    self.topSelctView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 140);
    [self.view addSubview:self.topSelctView];
    self.topSelctView.hunBlock = ^{
        weakself.price =@"100";
        [weakself.topSelctView.hundredBtn setBackgroundColor:mainColor];
        [weakself.topSelctView.halfHunBtn setBackgroundColor:gary221];
        [weakself.topSelctView.twoTenBtn setBackgroundColor:gary221];
        [weakself.topSelctView.tenBtn setBackgroundColor:gary221];
        [weakself .topSelctView.hundredBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal ];
        [weakself.topSelctView.halfHunBtn  setTitleColor:gary170 forState:UIControlStateNormal];
        [weakself.topSelctView.twoTenBtn  setTitleColor:gary170 forState:UIControlStateNormal];
        [weakself.topSelctView.tenBtn  setTitleColor:gary170 forState:UIControlStateNormal];
    };
    
    self.topSelctView. halfhunBlock = ^{
           weakself.price =@"50";
        [weakself.topSelctView.hundredBtn setBackgroundColor:gary221];
        [weakself.topSelctView.halfHunBtn setBackgroundColor:mainColor];
        [weakself.topSelctView.twoTenBtn setBackgroundColor:gary221];
        [weakself.topSelctView.tenBtn setBackgroundColor:gary221];
        
        [weakself .topSelctView.hundredBtn setTitleColor:gary170 forState:UIControlStateNormal ];
        [weakself.topSelctView.halfHunBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [weakself.topSelctView.twoTenBtn  setTitleColor:gary170 forState:UIControlStateNormal];
          [weakself.topSelctView.tenBtn  setTitleColor:gary170 forState:UIControlStateNormal];

    };
    
    self.topSelctView.twotenBlock = ^{
           weakself.price =@"20";
        [weakself.topSelctView.hundredBtn setBackgroundColor:gary221];
        [weakself.topSelctView.halfHunBtn setBackgroundColor:gary221];
        [weakself.topSelctView.twoTenBtn setBackgroundColor:mainColor];
        [weakself.topSelctView.tenBtn setBackgroundColor:gary221];
        [weakself .topSelctView.hundredBtn setTitleColor:gary170 forState:UIControlStateNormal ];
        [weakself.topSelctView.halfHunBtn  setTitleColor:gary170 forState:UIControlStateNormal];
        [weakself.topSelctView.twoTenBtn  setTitleColor:[UIColor whiteColor ] forState:UIControlStateNormal];
        [weakself.topSelctView.tenBtn  setTitleColor:gary170 forState:UIControlStateNormal];
    };
    
    self.topSelctView.tenBlock = ^{
           weakself.price =@"10";
        [weakself.topSelctView.hundredBtn setBackgroundColor:gary221];
        [weakself.topSelctView.halfHunBtn setBackgroundColor:gary221];
        [weakself.topSelctView.twoTenBtn setBackgroundColor:gary221];
        [weakself.topSelctView.tenBtn setBackgroundColor:mainColor];
        [weakself .topSelctView.hundredBtn setTitleColor:gary170 forState:UIControlStateNormal ];
        [weakself.topSelctView.halfHunBtn  setTitleColor:gary170 forState:UIControlStateNormal];
        [weakself.topSelctView.twoTenBtn  setTitleColor:gary170 forState:UIControlStateNormal];
        [weakself.topSelctView.tenBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    };
    UIImageView *line  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 139, SCREEN_WIDTH, 1)];
    line.backgroundColor =gary170;
    [self.topSelctView addSubview:line];
    
    self.Wx = [[NSBundle mainBundle]loadNibNamed:@"payCate" owner:self options:nil].lastObject;
    self.Wx.frame = CGRectMake(0,self.topSelctView.bottom  , SCREEN_WIDTH, 50);
    self.Wx.title.text=@"微信支付";
      self.Wx.img.image =Img(@"WeChatpay");
    [self.Wx.cheakBtn setImage:Img(@"choosepay_wei") forState:UIControlStateNormal];
    [self.view addSubview:self.Wx];
    
    self.Alipay = [[NSBundle mainBundle]loadNibNamed:@"payCate" owner:self options:nil].lastObject;
    self.Alipay.frame = CGRectMake(0, self.Wx.bottom, SCREEN_WIDTH, 50);
    [self.Alipay.cheakBtn setImage:Img(@"chooseplay") forState:UIControlStateNormal];
    self.Alipay.title.text=@"支付宝支付";
    self.Alipay.img.image =Img(@"alipay");
    [self.view addSubview:self.Alipay];
   
    self.Wx.cheakBlock = ^{
        Toast(@"暂未开通");
        //[weakself.Wx.cheakBtn setImage:Img(@"chooseplay") forState:UIControlStateNormal];
        //[weakself.Alipay.cheakBtn setImage:Img(@"choosepay_wei") forState:UIControlStateNormal];
        
    };
    self.Alipay.cheakBlock = ^{
        //[weakself.Wx.cheakBtn setImage:Img(@"choosepay_wei") forState:UIControlStateNormal];
        //[weakself.Alipay.cheakBtn setImage:Img(@"chooseplay") forState:UIControlStateNormal];
    };
    
    
    UIButton *btnPrice = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREENH_HEIGHT-60, SCREEN_WIDTH-20, 40)];
    [self.view addSubview:btnPrice];
    
    [btnPrice setBackgroundColor:mainColor];
    [btnPrice setTitle:@"去充值" forState:UIControlStateNormal];
    [btnPrice addTarget:self action:@selector(payStyle) forControlEvents:UIControlEventTouchUpInside ];
    
    UILabel *pormot = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT-60-30, SCREEN_WIDTH, 20)];
    [self.view addSubview:pormot];
    pormot.textColor = gary170;
    pormot.font = FontSize(12);
    pormot.textAlignment = NSTextAlignmentCenter ;
    pormot.text = @"小樱不会以任何形式要求您输入银行账号和密码";
    
    
    
}
-(void)payStyle{
    
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"getAlipayOrder",
                           @"total": self.price,
                           @"type": @"2"
                           };
    
    [self requestType:HttpRequestTypePost
                  url:[DB getStringById:@"source_url" fromTable:tabName]
     
           parameters:dic
         successBlock:^(id response) {
             
             NSLog(@"response====%@",response);
             BaseModel   * model = [BaseModel yy_modelWithJSON:response];
             if([model.errorno isEqualToString:@"0"]){
             appInfoModel *appmodel= model.data;
                 PaySelect *a =[[PaySelect alloc]init];
                 [a doAlipayPayAppID:appmodel.appId
                               Price:self.price
                            orderNum:appmodel.out_trade_no
                        orderTime:   appmodel.createtime
                          PrivateKey:appmodel.private_key
                                Body:appmodel.body
                             subJect:appmodel.subject];
             }
         } failureBlock:^(NSError *error) {
             
         }];

    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderalPayResult:) name:@"alPay" object:nil];
    
}

#pragma mark 移除通知
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)getOrderalPayResult:(NSNotification *)notification
{
    NSLog(@"userInfo: %@",notification.userInfo);
    
    if ([notification.object isEqualToString:@"9000"])
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [self alert:@"提示" msg:@"支付失败"];
      }
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

-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
