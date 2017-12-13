//
//  CkeakDetaitleVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/19.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "CkeakDetaitleVC.h"
#import "CheakCaannimation.h"

@interface CkeakDetaitleVC (){
    int _count;
   
}
@property (nonatomic ,strong)CheakCaannimation  * AnimationView;
@property (nonatomic,strong)NSTimer             * timer;
@end

@implementation CkeakDetaitleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViewBase];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSubViewBase{
    [self setNaivTitle:@"扫码开锁"];
    [self setNaivBackgroundColor:RGBColor(51, 51, 51)];
    [self.view setBackgroundColor:RGBColor(51, 51, 51)];
    self.AnimationView  = [[CheakCaannimation  alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5-100, 163, 200, 200)];
    self.AnimationView.backgroundColor = RGBColor(51, 51, 51);
    [self.view addSubview:self.AnimationView];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.10f target:self selector:@selector(delayMethod) userInfo:nil repeats:YES];
    //多线程读秒操作(可以加在button里控制)
    //[self performSelectorInBackground:@selector(thread) withObject:nil];
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)delayMethod{
    _count = _count+1;
  
    self.AnimationView.pregress= _count/100.0;
  
    if(_count==100){
        [self.timer invalidate];
         [self.navigationController popToRootViewControllerAnimated:YES];
    }}

// 在异步线程中无法操作UI，如果想要操作UI必须回调主线程
- (void)thread
{
    for(int i=0;i<=20;i++)
    {
        _count = i;
        // 回调主线程
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
        sleep(1);
    }
}

// 此函数主线程执行
- (void)mainThread
{
     self.AnimationView.pregress= _count/20.0;
    if (_count==20) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
