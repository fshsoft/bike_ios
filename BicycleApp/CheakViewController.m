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
    NSArray  * arr = @[
                       @{@"K":@"802001000",@"D":@"FF:FF:11:00:05:68"},
                       @{@"K":@"802001001",@"D":@"FF:FF:11:00:05:5B"},
                       @{@"K":@"802001002",@"D":@"FF:FF:11:00:05:5F"},
                       @{@"K":@"802001003",@"D":@"FF:FF:11:00:05:3C"},
                       @{@"K":@"802001004",@"D":@"FF:FF:11:00:05:45"},
                       @{@"K":@"802001005",@"D":@"FF:FF:11:00:05:76"},
                       @{@"K":@"802001006",@"D":@"FF:FF:11:00:05:95"},
                       @{@"K":@"802001007",@"D":@"FF:FF:11:00:05:20"},
                       @{@"K":@"802001008",@"D":@"FF:FF:11:00:05:6D"},
                       @{@"K":@"802001009",@"D":@"FF:FF:11:00:05:4B"},
                       @{@"K":@"802001010",@"D":@"FF:FF:11:00:05:71"},
                       @{@"K":@"802001011",@"D":@"FF:FF:11:00:05:1F"},
                       @{@"K":@"802001012",@"D":@"FF:FF:11:00:05:4A"},
                       @{@"K":@"802001013",@"D":@"FF:FF:11:00:05:16"},
                       @{@"K":@"802001014",@"D":@"FF:FF:11:00:05:83"},
                       @{@"K":@"802001015",@"D":@"FF:FF:11:00:05:0A"},
                       @{@"K":@"802001016",@"D":@"FF:FF:11:00:05:8F"},
                       @{@"K":@"802001017",@"D":@"FF:FF:11:00:05:33"},
                       @{@"K":@"802001018",@"D":@"FF:FF:11:00:05:3E"},
                       @{@"K":@"802001019",@"D":@"FF:FF:11:00:05:3F"},
                       @{@"K":@"802001020",@"D":@"FF:FF:11:00:05:64"},
                       @{@"K":@"802001021",@"D":@"FF:FF:11:00:05:07"},
                       @{@"K":@"802001022",@"D":@"FF:FF:11:00:05:19"},
                       @{@"K":@"802001023",@"D":@"FF:FF:11:00:05:1C"},
                       @{@"K":@"802001024",@"D":@"FF:FF:11:00:05:39"},
                       @{@"K":@"802001025",@"D":@"FF:FF:11:00:05:70"},
                       @{@"K":@"802001026",@"D":@"FF:FF:11:00:05:40"},
                       @{@"K":@"802001027",@"D":@"FF:FF:11:00:05:10"},
                       @{@"K":@"802001028",@"D":@"FF:FF:11:00:05:1B"},
                       @{@"K":@"802001027",@"D":@"FF:FF:11:00:05:7B"},
                       @{@"K":@"802001030",@"D":@"FF:FF:11:00:05:22"},
                       @{@"K":@"802001031",@"D":@"FF:FF:11:00:05:96"},
                       @{@"K":@"802001032",@"D":@"FF:FF:11:00:05:65"},
                       @{@"K":@"802001033",@"D":@"FF:FF:11:00:05:30"},
                       @{@"K":@"802001034",@"D":@"FF:FF:11:00:05:59"},
                       @{@"K":@"802001035",@"D":@"FF:FF:11:00:05:44"},
                       @{@"K":@"802001036",@"D":@"FF:FF:11:00:05:5D"},
                       @{@"K":@"802001037",@"D":@"FF:FF:11:00:05:47"},
                       @{@"K":@"802001038",@"D":@"FF:FF:11:00:05:7D"},
                       @{@"K":@"802001039",@"D":@"FF:FF:11:00:05:51"},
                       @{@"K":@"802001040",@"D":@"FF:FF:11:00:05:85"},
                       @{@"K":@"802001041",@"D":@"FF:FF:11:00:05:72"},
                       @{@"K":@"802001042",@"D":@"FF:FF:11:00:05:67"},
                       @{@"K":@"802001043",@"D":@"FF:FF:11:00:05:0C"},
                       @{@"K":@"802001044",@"D":@"FF:FF:11:00:05:11"},
                       @{@"K":@"802001045",@"D":@"FF:FF:11:00:05:46"},
                       @{@"K":@"802001046",@"D":@"FF:FF:11:00:05:27"},
                       @{@"K":@"802001047",@"D":@"FF:FF:11:00:05:4F"},
                       @{@"K":@"802001048",@"D":@"FF:FF:11:00:05:94"},
                       @{@"K":@"802001049",@"D":@"FF:FF:11:00:05:3B"},
                       ];

    NSLog(@"二维码内容：%@",scanDataString);
    
    NSArray * str =[scanDataString componentsSeparatedByString:@"?"];
    if(![str.lastObject hasPrefix:@"8020010"]){
        Toast(@"可能不是车锁二维码");
          [self.scanV startRunning];
        return;
    }
   
    //[self.blueToothdelegate  scanBlueTooth:mac];
    //[self.navigationController popViewControllerAnimated:YES];
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{ @"action":      @"scanCode",
                         @"sn":str.lastObject
}
         successBlock:^(BaseModel *response) {

             if([response.errorno   isEqualToString:@"0"]){
                [self.blueToothdelegate  scanBlueTooth:response.mac];
                 CkeakDetaitleVC *vc =[[CkeakDetaitleVC alloc]init];
                 [self.navigationController pushViewController:vc  animated:YES];
             }else if([response.errorno  isEqualToString:@"40020"]){

                 UIAlertController  * alra = [UIAlertController  alertControllerWithTitle:@"友情提示" message:response.errmsg preferredStyle:UIAlertControllerStyleAlert];
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
                 Toast(response.errmsg);
             }

         } failureBlock:^(NSError *error) {
              [self.scanV startRunning];
         }];

    
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
