//
//  CheakNumberVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/20.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "CheakNumberVC.h"
#import "LogoTextField.h"
#import "CkeakDetaitleVC.h"
@interface CheakNumberVC ()
@property (nonatomic,strong)LogoTextField *Num;
@end

@implementation CheakNumberVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaivTitle:@"编号解锁"];
    [self.view addSubview:self.Num];
    [self setBtnView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftFoundation{
    [self.navigationController   popViewControllerAnimated:YES];
}
- (LogoTextField *)Num {
    if (!_Num) {
        
        _Num = [[LogoTextField alloc] initWithFrame:CGRectMake(14,  94, SCREEN_WIDTH-28-40-10, kRowHeight)];
        
        
        _Num.tittle.text =@"单车编号";
//        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//        attributes[NSForegroundColorAttributeName] = RGBColor(170, 170, 170);
//        attributes[NSFontAttributeName] =  [UIFont fontWithName:@"Arial-BoldMT" size:14];
//        _Num.field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入单车编号" attributes:attributes];
        _Num.field.placeholder =@"请输入单车编号";
        }
    return _Num;
}
-(void)setBtnView{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-28-20, 94, 40, 40)];
    [self.view addSubview:btn];
    [btn setImage:Img(@"jiesuo_enter") forState:UIControlStateNormal];
    [btn setBackgroundColor:mainColor];
    [btn addTarget:self action:@selector(cheakView) forControlEvents:UIControlEventTouchUpInside];
}
-(void)cheakView{
    if(self.cheakNum==1){
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cheakcenter" object:@"2132132132"];
    NSArray * viewControllers = self.navigationController.viewControllers;
    [self.navigationController popToViewController:viewControllers[1] animated:NO];
    }else{
        
        [self requestType:HttpRequestTypePost
                      url:nil
               parameters:@{ @"action":      @"scanCode",
                             @"sn":self.Num.field.text}
             successBlock:^(BaseModel *response) {
                 if([response.errorno   isEqualToString:@"0"]){
                     CkeakDetaitleVC *vc =[[CkeakDetaitleVC alloc]init];
                   
                     
                     [[NSNotificationCenter defaultCenter]postNotificationName:@"mac" object:response.mac];
                     [self.navigationController pushViewController:vc  animated:YES];
                 }else{
                     Toast(response. errmsg);
                 }
                 
             } failureBlock:^(NSError *error) {
                 
             }];
   
    }
    
}

@end
