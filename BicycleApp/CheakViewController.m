//
//  CheakViewController.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/4.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "CheakViewController.h"
#import "XYScanView.h"
#import <AVFoundation/AVFoundation.h>

#import "CkeakDetaitleVC.h"
#import "UIButton+TitleImgEdgeInsets.h"
#import "CheakNumberVC.h"
#import "WalletMoneyVC.h"
@interface CheakViewController ()<XYScanViewDelegate
>

@property   (nonatomic,assign)int num;
@property   (nonatomic,assign)BOOL upOrdown;

@property   (nonatomic,assign)BOOL  lightStatus;

@property   (nonatomic,strong)UIButton *lightButton;
@property   (nonatomic,strong)UIButton *leftButton;

@property  (nonatomic,copy)NSString *userID;


 

@property (strong, nonatomic)   AVCaptureDevice *device;

@property (nonatomic,weak) XYScanView *scanV;
@end

@implementation CheakViewController

- (void)viewDidLoad {
   
    XYScanView *scanV = [[XYScanView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64)];
    scanV.delegate = self;
 
    [self.view addSubview:scanV];
    _scanV = scanV;
    [super viewDidLoad];
    [self setNaivTitle:@"扫码用车"];
    
    [self setLightStatusButton];
}
-(void)getScanDataString:(NSString*)scanDataString{
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"scanCode",
                           @"sn":scanDataString
                           };
    
    [self requestType:HttpRequestTypePost
                  url:[DB getStringById:@"source_url" fromTable:tabName]
     
           parameters:dic
         successBlock:^(id response) {
             BaseModel   * model = [BaseModel yy_modelWithJSON:response];
             if([model.errorno   isEqualToString:@"0"]){
                 CkeakDetaitleVC *vc =[[CkeakDetaitleVC alloc]init];
                 [self.navigationController pushViewController:vc  animated:YES];
             }else if([model.errorno  isEqualToString:@"40020"]){
            
                 UIAlertController  * alra = [UIAlertController  alertControllerWithTitle:@"友情提示" message:model.errmsg preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction * select = [UIAlertAction actionWithTitle:@"充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     WalletMoneyVC  *vc  = [[WalletMoneyVC alloc]init];
                     [self.navigationController pushViewController:vc animated:YES];
                 } ];
                 UIAlertAction * unselect = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                     
                 } ];
                 [alra addAction:select];
                 [alra addAction:unselect];
                 [self presentViewController:alra animated:YES completion:nil];
                             }
             else{
                    Toast(model.errmsg);
             }
         } failureBlock:^(NSError *error) {
             [self.scanV startRunning];
         }];

    NSLog(@"二维码内容：%@",scanDataString);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
     //[self Getphoto];
}
-(void)setLightStatusButton {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:Img(@"flashlight") forState:UIControlStateNormal];
    [btn setTitle:@"打开手电筒" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0.5*SCREEN_WIDTH, SCREENH_HEIGHT-110, 110, 110);
    btn.titleLabel.font = FontSize(10);
    btn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:btn];
    self.lightButton=btn;
    [btn layoutButtonTitleImageEdgeInsetsWithStyle:3 titleImgSpace:20];
    self.lightStatus =NO;
    [btn addTarget:self action:@selector(turnTorchOn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setImage:Img(@"input_hand") forState:UIControlStateNormal];
     btnRight.adjustsImageWhenHighlighted = NO;
    [btnRight setTitle:@"编码解锁" forState:UIControlStateNormal];
   btnRight.frame = CGRectMake(0.5*SCREEN_WIDTH-110, SCREENH_HEIGHT-110, 110, 110);
    btnRight.titleLabel.font = FontSize(10);
    
    [self.view addSubview:btnRight];
    self.leftButton=btnRight;
    [btnRight layoutButtonTitleImageEdgeInsetsWithStyle:3 titleImgSpace:20];
     [btnRight addTarget:self action:@selector(cheakNumber) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)cheakNumber{
    CheakNumberVC *vc =[[CheakNumberVC alloc]init];
    [self.navigationController pushViewController:vc  animated:YES];
    
}
- (void) turnTorchOn
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
      self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([self.device hasTorch] && [self.device hasFlash]){
            
            [self.device lockForConfiguration:nil];
            if (self.lightStatus==NO) {
                [self.device setTorchMode:AVCaptureTorchModeOn];
                [self.device setFlashMode:AVCaptureFlashModeOn];
                self.lightStatus = YES;
                [ self.lightButton setImage:Img(@"flashlight_after") forState:UIControlStateNormal];
                [self.lightButton setTitle:@"关闭手电筒" forState:UIControlStateNormal];
            } else {
                [self.device setTorchMode:AVCaptureTorchModeOff];
                [self.device setFlashMode:AVCaptureFlashModeOff];
               self.lightStatus= NO;
                [ self.lightButton setImage:Img(@"flashlight") forState:UIControlStateNormal];
                [self.lightButton setTitle:@"打开手电筒" forState:UIControlStateNormal];
            }
            [self.device unlockForConfiguration];
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated{
   
    [self turnTorchOff];
}
-(void)turnTorchOff{
    if(self.lightStatus==YES){
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([self.device hasTorch] && [self.device hasFlash]){
            
            [self.device lockForConfiguration:nil];
            [ self.lightButton setImage:Img(@"flashlight_after")  forState:UIControlStateNormal];
            [self.lightButton setTitle:@"关闭手电筒"       forState:UIControlStateNormal];
                [self.device setTorchMode:AVCaptureTorchModeOff];
                [self.device setFlashMode:AVCaptureFlashModeOff];
                self.lightStatus= NO;
           
            [self.device unlockForConfiguration];
        }
    }
}
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
