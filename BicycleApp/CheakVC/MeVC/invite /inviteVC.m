//
//  inviteVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "inviteVC.h"
#import "LogoTextField.h"
#import "ShareView.h"
#import "JSHAREService.h"
@interface inviteVC ()
@property (nonatomic,strong)LogoTextField *number;
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic, strong)JSHAREMessage *message;
@end

@implementation inviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubView];
    }
-(void)setSubView{
    [self setNaivTitle:@"邀请好友"];
    [self.view addSubview:self.number];
    UILabel *labPromot =[[UILabel alloc]initWithFrame:CGRectMake(0, self.number.bottom+10, SCREEN_WIDTH, 20)];
    labPromot.textAlignment =NSTextAlignmentCenter;
    labPromot.textColor =mainColor;
    labPromot.font =FontSize(12);
    labPromot.text =@"好友用您的邀请码成功注册，您的信用会增加哦!";
    [self.view addSubview:labPromot];
    UIButton *btnShear = [[UIButton alloc]initWithFrame:CGRectMake(14, labPromot.bottom+30, SCREEN_WIDTH-28, 40)];
    [self.view addSubview:btnShear];
    [btnShear setBackgroundColor:mainColor];
    [btnShear setTitle:@"分享给好友" forState:UIControlStateNormal];
    [btnShear addTarget:self action:@selector(shearFromto) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)shearFromto{
      [self.shareView showWithContentType:JSHARELink];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }
 //常用
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
  
    message.mediaType = JSHARELink;
    message.url = @"http://xiaoying.shnow.cn";
    message.text = @"欢迎使用乐享单车";
    message.title = @"乐享单车期待你的加入";
    message.platform = platform;
   // NSString *imageURL = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1308/02/c0/24056523_1375430477597.jpg";
    NSData *imageData = UIImageJPEGRepresentation(Img(@"logo"),1);
    
    message.image = imageData;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
       
        
    }];
}
- (ShareView *)shareView {
    if (!_shareView) {
        _shareView = [ShareView getFactoryShareViewWithCallBack:^(JSHAREPlatform platform, JSHAREMediaType type) {
                                 //常用
                    [self shareLinkWithPlatform:platform];
                  
            
        }];
        [self.view addSubview:self.shareView];
    }
    return _shareView;
}


 - (LogoTextField *)number {
    if (!_number) {
        
        _number = [[LogoTextField alloc] initWithFrame:CGRectMake(14,  94, SCREEN_WIDTH-28, kRowHeight)];
        
        
        _number.tittle.text =@"邀请码";
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSForegroundColorAttributeName] = RGBColor(170, 170, 170);
        attributes[NSFontAttributeName] =  [UIFont fontWithName:@"Arial-BoldMT" size:14];
        _number.field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邀请码" attributes:attributes];
        _number.field.text =@"MUSE9737";
        
    }
    return _number;
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
