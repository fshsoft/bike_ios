//
//  paymentVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/19.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "paymentVC.h"
#import "CertifyTopView.h"
#import "payCateView.h"
#import "PaySelect.h"
#import "certifyPersonInfoVC.h"
#import "PaySelect.h"
#import "appInfoModel.h"
@interface paymentVC ()
@property (nonatomic,strong)CertifyTopView *topView;
@property (nonatomic,strong)payCateView    *pormot;
@property (nonatomic,strong)payCateView    *Wx;
@property (nonatomic,strong)payCateView    *Alipay;
@end

@implementation paymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaivTitle:@"押金充值"];
    [self setTopview ];
    [self setSelectView];
    
    // Do any additional setup after loading the view.
}
-(void)leftFoundation{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setTopview{
    self.topView = [[NSBundle mainBundle]loadNibNamed:@"CerifyTop" owner:self options:nil].lastObject;
    self.topView.tag=1;
    self.topView.frame  = CGRectMake(0,64, SCREEN_WIDTH, 110);
    [self.view addSubview: self.topView];
   
}
-(void)setSelectView{
    self.pormot  = [[NSBundle mainBundle]loadNibNamed:@"payCate" owner:self options:nil].lastObject;
    self.pormot.frame = CGRectMake(0, self.topView.bottom, SCREEN_WIDTH, 50);
    self.pormot.img.image =Img(@"yajin");
       [self.view addSubview:self.pormot];
    NSString * textStr =@"押金(可秒退)";
    
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    [attribtStr addAttribute:NSForegroundColorAttributeName
                       value: mainColor
                       range:NSMakeRange(textStr.length-5, 5)];
    self.pormot.title.attributedText =attribtStr;
    
    [self.pormot.cheakBtn setTitle:@"¥199" forState:UIControlStateNormal];
    UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.pormot.height-1, SCREEN_WIDTH, 1)];
    line.backgroundColor =gary238;
    [self.pormot addSubview:line];
  
    self.Wx = [[NSBundle mainBundle]loadNibNamed:@"payCate" owner:self options:nil].lastObject;
    self.Wx.frame = CGRectMake(0, self.pormot.bottom, SCREEN_WIDTH, 50);
    self.Wx.title.text=@"微信支付";
     [self.Wx.cheakBtn setImage:Img(@"chooseplay") forState:UIControlStateNormal];
    self.Wx.img.image =Img(@"WeChatpay");
    [self.view addSubview:self.Wx];
   
    self.Alipay = [[NSBundle mainBundle]loadNibNamed:@"payCate" owner:self options:nil].lastObject;
    self.Alipay.frame = CGRectMake(0, self.Wx.bottom, SCREEN_WIDTH, 50);
    self.Alipay.title.text=@"支付宝支付";
    
    [self.Alipay.cheakBtn setImage:Img(@"choosepay_wei") forState:UIControlStateNormal];

    self.Alipay.img.image =Img(@"alipay");
    [self.view addSubview:self.Alipay];
    UIImageView *linebottom =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.Alipay.height-1, SCREEN_WIDTH, 1)];
    linebottom.backgroundColor = gary238;
    __weak paymentVC *weakself =self;
    [self.Alipay addSubview:linebottom];
    self.Wx.cheakBlock = ^{
        [weakself.Wx.cheakBtn setImage:Img(@"chooseplay") forState:UIControlStateNormal];
        [weakself.Alipay.cheakBtn setImage:Img(@"choosepay_wei") forState:UIControlStateNormal];
        
    };
    self.Alipay.cheakBlock = ^{
        [weakself.Wx.cheakBtn setImage:Img(@"choosepay_wei") forState:UIControlStateNormal];
        [weakself.Alipay.cheakBtn setImage:Img(@"chooseplay") forState:UIControlStateNormal];
    };
    

    
    UILabel *lab  = [[UILabel  alloc]initWithFrame:CGRectMake(20, self.Alipay.bottom+25, SCREEN_WIDTH-20, 60)];
    
    lab.font =FontSize(13);
    lab.numberOfLines = 0;
    lab.textColor =gary153;
    lab.text =@"•   全国百万百宝任你骑 \n•  押金随心退,安全秒到账\n•  完成注册领最高30天免费骑行大礼包";
    [self.view addSubview:lab];
    
    UIButton *btnPrice = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREENH_HEIGHT-50, SCREEN_WIDTH-20, 40)];
    [self.view addSubview:btnPrice];
    
    [btnPrice setBackgroundColor:mainColor];
    [btnPrice setTitle:@"去充值" forState:UIControlStateNormal];
    [btnPrice addTarget:self action:@selector(payStyle) forControlEvents:UIControlEventTouchUpInside ];
    
 
}
-(void)payStyle{
    
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"getAlipayOrder",
                           @"total": @"199"
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
                               Price:@"0.01"
                            orderNum:appmodel.orderid
                           orderTime:appmodel.createtime
                          PrivateKey:appmodel.private_key
                                Body:appmodel.createtime
                             subJect:appmodel.createtime];
             }
         } failureBlock:^(NSError *error) {
             
         }];

        //[DB putString: appmodel.access_token  withId: @"access_token"  intoTable:tabName];
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
- (void)getOrderalPayResult:(NSNotification *)notification
{
    NSLog(@"userInfo: %@",notification.userInfo);
    
    if ([notification.object isEqualToString:@"9000"])
    {
        certifyPersonInfoVC *vc =[[certifyPersonInfoVC alloc]init];
        [DB putString:@"1"   withId: @"money"  intoTable:tabName];
        [self absPushViewController:vc animated:YES];

    }else
    {
        [self alert:@"提示" msg:@"支付失败"];
    }
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
