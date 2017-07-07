//
//  certifyPersonInfoVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/18.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "certifyPersonInfoVC.h"
#import "CertifyTopView.h"
#import "LogoTextField.h"
#import "BaseModel.h"
@interface certifyPersonInfoVC ()
{
    int _count;
    UILabel *_label;
}
@property (nonatomic,strong)CertifyTopView *topView;
@property (nonatomic, strong) LogoTextField * name;
@property (nonatomic, strong) LogoTextField * personID;
@property (nonatomic,strong)   UIButton *btn;

@end

@implementation certifyPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
  [self setTopview];
    
}
-(void)setTopview{
    [self setNaivTitle:@"实名注册"];
    self.topView = [[NSBundle mainBundle]loadNibNamed:@"CerifyTop" owner:self options:nil].lastObject;
    self.topView.tag=2;
    self.topView.frame  = CGRectMake(0,64, SCREEN_WIDTH, 110);
    
//    CALayer *Mylayer=[CALayer layer];
//    Mylayer.bounds=CGRectMake(0, 0, 20, 20);
//    Mylayer.position=CGPointMake(5, 5);
//    Mylayer.contents=(id)[UIImage imageNamed:@"pass_per"].CGImage;
//    self.topView.firstImg.layer.masksToBounds=NO;
//    [self.topView.firstImg.layer addSublayer:Mylayer ];
//    
//    CALayer *Mylayer1=[CALayer layer];
//    Mylayer1.bounds=CGRectMake(0, 0, 20, 20);
//    Mylayer1.position=CGPointMake(5, 5);
//    Mylayer1.contents=(id)[UIImage imageNamed:@"pass_per"].CGImage;
//    self.topView.secondImg.layer.masksToBounds=NO;
//    [self.topView.secondImg.layer addSublayer:Mylayer1 ];

    [self.view addSubview: self.topView];
    [self.view addSubview:self.name];
    [self.view addSubview:self.personID];
    [self setPushPersonInfo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftFoundation{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (LogoTextField *)name {
    if (!_name) {
        
        _name = [[LogoTextField alloc] initWithFrame:CGRectMake(14,194, SCREEN_WIDTH-28, kRowHeight)];
        
        
        _name.tittle.text =@"姓名";
       
        _name.field.placeholder =@"请输入真实姓名"  ;
    }
    return _name;
}
- (LogoTextField *)personID {
    if (!_personID) {
        _personID = [[LogoTextField alloc] initWithFrame:CGRectMake(14,244, SCREEN_WIDTH-28,kRowHeight)];
        _personID.field.placeholder= @"请输身份证号" ;
        _personID.tittle.text= @"身份证";
    }
    return _personID;
}
-(void)setPushPersonInfo{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(14, self.personID.bottom+30, SCREEN_WIDTH-28, 40)];
    [self.view addSubview:btn];
    self.btn=btn;
    [btn setBackgroundColor:mainColor];
    [btn setTitle:@"认证" forState:UIControlStateNormal ];
    [btn addTarget:self action:@selector(cheakInfo) forControlEvents:UIControlEventTouchUpInside];
}
-(void)cheakInfo{
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"verified",
                           @"truename":self.name.field.text,
                           @"idno"    :self.personID.field.text
                           };
    
    [self requestType:HttpRequestTypePost
                  url:[DB getStringById:@"source_url" fromTable:tabName]
     
           parameters:dic
         successBlock:^(id response) {
             BaseModel   * model = [BaseModel yy_modelWithJSON:response];
          
             if([model.errorno isEqualToString:@"0"]){
                 [DB putString: @"1"  withId: @"certify"  intoTable:tabName];
                 //[DB putString:self.name.field.text withId:@"IDname" intoTable:tabName];
                 [self setCompletView];
             }else{
                 Toast(model.errmsg);
             }
            
             
         } failureBlock:^(NSError *error) {
             
         }];

   
}
-(void)setCompletView{
    CALayer *Mylayer1=[CALayer layer];
    Mylayer1.bounds=CGRectMake(0, 0, 20, 20);
    Mylayer1.position=CGPointMake(5, 5);
    Mylayer1.contents=(id)[UIImage imageNamed:@"pass_per"].CGImage;
    self.topView.threeImg.layer.masksToBounds=NO;
    [self.topView.threeImg.layer addSublayer:Mylayer1 ];
    self.topView.fourImg.backgroundColor =mainColor;
    [self.personID removeFromSuperview];
    [self.name removeFromSuperview];
    [self.btn removeFromSuperview];
    UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    img.center=CGPointMake(SCREEN_WIDTH*0.5, self.topView.bottom+30);
    [self.view addSubview:img];
    UILabel * labSuccess = [[UILabel alloc]initWithFrame:CGRectMake(0, img.bottom+10, SCREEN_WIDTH, 30)];
    labSuccess.textColor =mainColor;
    labSuccess.textAlignment = NSTextAlignmentCenter;
    labSuccess.text =@"恭喜您注册成功";
    [self.view addSubview:labSuccess];
    [self performSelectorInBackground:@selector(thread) withObject:nil];
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, labSuccess.bottom+5,SCREEN_WIDTH , 20)];
    
    _label.textAlignment=NSTextAlignmentCenter;
    _label.font=[UIFont systemFontOfSize:13];
    
    NSString  *str =@"3秒后跳转首页";
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attribtStr addAttribute:NSForegroundColorAttributeName
                       value: mainColor
                       range:NSMakeRange(0, 1)];
    
    /*  [attribtStr addAttribute:NSUnderlineStyleAttributeName
     value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
     range:NSMakeRange(textStr.length-11, 11)];*/
    
    _label.attributedText = attribtStr;

    [self.view addSubview:_label];
}
// 在异步线程中无法操作UI，如果想要操作UI必须回调主线程
- (void)thread
{
    for(int i=3;i>=0;i--)
    {
        _count = i;
        // 回调主线程
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
        sleep(1);
    }
}

// 此函数主线程执行
- (void)mainThread
{NSString  *str =[NSString stringWithFormat:@"%d秒后跳转首页",_count];;
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attribtStr addAttribute:NSForegroundColorAttributeName
                       value: mainColor
                       range:NSMakeRange(0, 1)];

     _label.attributedText = attribtStr;
    if (_count==0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
