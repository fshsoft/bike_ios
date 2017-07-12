//
//  ChangePhoneNumberVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "ChangePhoneNumberVC.h"
#import "LogoTextField.h"
#import "TimerButton.h"
#import "NSString+ABSAdd.h"
@interface ChangePhoneNumberVC ()<UITextFieldDelegate >
@property (nonatomic,strong)LogoTextField *name;
@property (nonatomic,strong)LogoTextField *personID;
@property (nonatomic,strong)LogoTextField *PhoneNumber;
@property (nonatomic,strong)LogoTextField *CheakNum;
@property (nonatomic, strong) TimerButton *pinBtn;
@property (nonatomic,strong)   UIButton   *PushInfo;

@end

@implementation ChangePhoneNumberVC
-(id)init{
    if(self =[super init  ]){
        self.arr  =[NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaivTitle:@"跟换手机号"];
    [self.view addSubview:self.name];
    [self.view addSubview:self.personID];
    [self.view addSubview:self.PhoneNumber];
    [self.view addSubview:self.CheakNum];
    [self.view addSubview: self.pinBtn];
    [self.view addSubview:self.PushInfo ];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (LogoTextField *)name {
    if (!_name) {
        
        _name = [[LogoTextField alloc] initWithFrame:CGRectMake(14,64, SCREEN_WIDTH-28, kRowHeight)];
        _name .backgroundColor = [UIColor whiteColor];
        _name.tittle.text =@"姓名";
 //       NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//        attributes[NSForegroundColorAttributeName] = RGBColor(170, 170, 170);
//        attributes[NSFontAttributeName] =  [UIFont fontWithName:@"Arial-BoldMT" size:14];
//        _name.field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入真实姓名" attributes:attributes];
        _name.field.text=[DB getStringById:@"truename" fromTable:tabName];
    }
    return _name;
}

- (LogoTextField *)personID {
    if (!_personID) {
        _personID = [[LogoTextField alloc] initWithFrame:CGRectMake(14,self.name.bottom+10, SCREEN_WIDTH-28,kRowHeight)];
//        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//        attributes[NSForegroundColorAttributeName] = RGBColor(170, 170, 170);
//        attributes[NSFontAttributeName] =  [UIFont fontWithName:@"Arial-BoldMT" size:14];
//        _personID.field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输身份证号" attributes:attributes];
            _personID.field.placeholder =@"请输身份证号";
        
        _personID.tittle.text= @"身份证";
        
        
    }
    return _personID;
}
- (LogoTextField *)PhoneNumber {
    if (!_PhoneNumber) {
        _PhoneNumber = [[LogoTextField alloc] initWithFrame:CGRectMake(14,self.personID.bottom+10, SCREEN_WIDTH-28,kRowHeight)];
        //NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        //attributes[NSForegroundColorAttributeName] = RGBColor(170, 170, 170);
        //attributes[NSFontAttributeName] =  [UIFont fontWithName:@"Arial-BoldMT" size:14];
       // _PhoneNumber.field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输新手机号" attributes:attributes];
        _PhoneNumber.field.placeholder  =@"请输新手机号";
        _PhoneNumber.field.keyboardType = UIKeyboardTypeNumberPad;
        
        
        _PhoneNumber.tittle.text= @"新手机号";
         _PhoneNumber.field.delegate =self;
        
    }
    return _PhoneNumber;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([textField isEqual:self.PhoneNumber.field]){
        if( textField.text.length>0){
            _pinBtn.userInteractionEnabled =YES;
            
        }
    }
}

- (LogoTextField *)CheakNum {
    if (!_CheakNum) {
        _CheakNum = [[LogoTextField alloc] initWithFrame:CGRectMake(14,self.PhoneNumber.bottom+10,426/750.0*SCREEN_WIDTH,kRowHeight)];
        //NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        //attributes[NSForegroundColorAttributeName] = RGBColor(170, 170, 170);
        //attributes[NSFontAttributeName] =  [UIFont fontWithName:@"Arial-BoldMT" size:14];
       // _CheakNum.field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:attributes];
        _CheakNum.field.placeholder  =@"请输入验证码";

        _CheakNum.field.keyboardType = UIKeyboardTypeNumberPad;
        
        
        _CheakNum.tittle.text= @"验证码";
        
        
    }
    return _CheakNum;
}
- (TimerButton *)pinBtn {
    if (!_pinBtn) {
        CGRect frame = CGRectMake(self.CheakNum.right+10, self.CheakNum.top, SCREEN_WIDTH-self.CheakNum.frame.size.width-38 , kRowHeight);
        _pinBtn = [TimerButton buttonWithType:UIButtonTypeCustom];
        
        _pinBtn = [[TimerButton alloc] initWithFrame:frame title:@"获取验证码" durationTitle:@"重新获取" seconds:60 progressBlock:^(TimerButton *button, TimeState state, NSString *restTime) {
            if (state == TimeStart) {
                NSLog(@"计时开始");
            }
        }];
        _pinBtn.userInteractionEnabled =NO;
        
        [_pinBtn setBackgroundColor:RGBColor(221, 221, 221)];
        [_pinBtn addTarget:self action:@selector(pinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _pinBtn.titleLabel.font = FontSize(13);
        [_pinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    }
    return _pinBtn;
}




- (void)pinBtnClick {
    
    if ([NSString isMobileNumber:self.PhoneNumber.field.text]) {
             } else {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码！"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(UIButton *)PushInfo{
    if(!_PushInfo){
        
        _PushInfo  = [[UIButton alloc]initWithFrame:CGRectMake(14, self.pinBtn.bottom+30, SCREEN_WIDTH-28, 40)];
        [_PushInfo setBackgroundColor:mainColor];
        [_PushInfo setTitle:@"跟换手机号" forState:UIControlStateNormal];
        [_PushInfo    addTarget:self action:@selector(pushinfo) forControlEvents:UIControlEventTouchUpInside ];
        
    }
    return _PushInfo;
}
-(void)pushinfo{
    [self sendRequest];
    
}
-(void)leftFoundation{
    [self postNotation];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)postNotation{
    [self.arr replaceObjectAtIndex:self.tag withObject:_PhoneNumber.field.text];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"personcenter" object:self.arr];
}
-(void)sendRequest{
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"modifyMobile",
                           @"mobile":    self.PhoneNumber.field.text,
                           @"idno"  :    self.personID.field.text,
                           @"vericode":  self.CheakNum.field.text
                           
                           };
    
    [self requestType:HttpRequestTypePost
                  url:[DB getStringById:@"source_url" fromTable:tabName]
     
           parameters:dic
         successBlock:^(id response) {
             BaseModel   * model = [BaseModel yy_modelWithJSON:response];
             Toast(model.errmsg);
             if([model.errmsg isEqualToString:@"0"]){
                 [self.navigationController popViewControllerAnimated:YES];
             }else{
                 NSString *errmsg = model.errmsg;
                 NSLog(@"errmsg==%@",errmsg);
             }
           
             
         } failureBlock:^(NSError *error) {
             
         }];
    
}

@end
