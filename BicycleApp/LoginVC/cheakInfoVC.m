//
//  cheakInfoVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/7/15.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "cheakInfoVC.h"
#import "CertifyTopView.h"
@interface cheakInfoVC (){
    int _count;
    UILabel *_label;
}
@property (nonatomic,strong)CertifyTopView *topView;
@end

@implementation cheakInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];  [self setNaivTitle:@"注册结果"];
    self.topView = [[NSBundle mainBundle]loadNibNamed:@"CerifyTop" owner:self options:nil].lastObject;
    self.topView.tag=2;
    self.topView.frame  = CGRectMake(0,64, SCREEN_WIDTH, 110);
    
    
    [self.view addSubview: self.topView];
    [self setCompletView];
    // Do any additional setup after loading the view.
}
-(void)leftFoundation{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setCompletView{
    CALayer *Mylayer1=[CALayer layer];
    Mylayer1.bounds=CGRectMake(0, 0, 20, 20);
    Mylayer1.position=CGPointMake(5, 5);
    Mylayer1.contents=(id)[UIImage imageNamed:@"pass_per"].CGImage;
    self.topView.threeImg.layer.masksToBounds=NO;
    [self.topView.threeImg.layer addSublayer:Mylayer1 ];
    self.topView.fourImg.backgroundColor =mainColor;
    
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
