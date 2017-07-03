//
//  ShearVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "ShearVC.h"
#import "ShareView.h"
#import "JSHAREService.h"
@interface ShearVC ()

@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic, strong)JSHAREMessage *message;
@end

@implementation ShearVC
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [self setNaivTitle:@"风享"];
    self.message = [JSHAREMessage message];
    self.message.mediaType = JSHARELink;
    self.message.url = @"https://www.jiguang.cn/";
    self.message.text = @"欢迎使用极光社会化组件JShare，SDK包体积小，集成简单，支持主流社交平台、帮助开发者轻松实现社会化功能！";
    self.message.title = @"欢迎使用极光社会化组件JShare";
    
    NSString *imageURL = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1308/02/c0/24056523_1375430477597.jpg";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    self.message.image = imageData;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareText:(id)sender {
    [self.shareView showWithContentType:JSHAREText];
}

- (IBAction)shareImage:(id)sender {
    [self.shareView showWithContentType:JSHAREImage];
}

- (IBAction)shareLink:(id)sender {
    [self.shareView showWithContentType:JSHARELink];
}

- (IBAction)shareAudio:(id)sender {
    [self.shareView showWithContentType:JSHAREAudio];
}

- (IBAction)shareVideo:(id)sender {
    [self.shareView showWithContentType:JSHAREVideo];
}

- (IBAction)shareApp:(id)sender {
    [self.shareView showWithContentType:JSHAREApp];
}

- (IBAction)shareGif:(id)sender {
    [self.shareView showWithContentType:JSHAREEmoticon];
}

- (IBAction)shareFile:(id)sender {
    [self.shareView showWithContentType:JSHAREFile];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
      //[self.shareView showWithContentType:JSHAREFile];
    // [self.shareView showWithContentType:JSHAREImage];
     //[self.shareView showWithContentType:JSHAREText];
    [self.shareView showWithContentType:JSHARELink];

}
- (ShareView *)shareView {
    if (!_shareView) {
        _shareView = [ShareView getFactoryShareViewWithCallBack:^(JSHAREPlatform platform, JSHAREMediaType type) {
            switch (type) {
                case JSHAREText:
                    [self shareTextWithPlatform:platform];
                    break;
                case JSHAREImage:
                    [self shareImageWithPlatform:platform];
                    break;
                case JSHARELink:
                    //常用
                    [self shareLinkWithPlatform:platform];
                    break;
                case JSHAREAudio:
                    [self shareMusicWithPlatform:platform];
                    break;
                case JSHAREVideo:
                    [self shareVideoWithPlatform:platform];
                    break;
                case JSHAREApp:
                    [self shareAppWithPlatform:platform];
                    break;
                case JSHAREEmoticon:
                    [self shareEmoticonWithPlatform:platform];
                    break;
                case JSHAREFile:
                    [self shareFileWithPlatform:platform];
                    break;
                default:
                    break;
            }
            
        }];
        [self.view addSubview:self.shareView];
    }
    return _shareView;
}
//常用
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHARELink;
    message.url = @"https://www.jiguang.cn/";
    message.text = @"欢迎使用极光社会化组件JShare，SDK包体积小，集成简单，支持主流社交平台、帮助开发者轻松实现社会化功能！";
    message.title = @"欢迎使用极光社会化组件JShare";
    message.platform = platform;
    NSString *imageURL = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1308/02/c0/24056523_1375430477597.jpg";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.image = imageData;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];
}


- (void)shareTextWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.text = @"欢迎使用极光社会化组件JShare，SDK包体积小，集成简单，支持主流社交平台、帮助开发者轻松实现社会化功能！";
    message.platform = platform;
    message.mediaType = JSHAREText;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];
}

- (void)shareImageWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    NSString *imageURL = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1308/02/c0/24056523_1375430477597.jpg";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.mediaType = JSHAREImage;
    message.platform = platform;
    message.image = imageData;
    
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];
}

- (void)shareMusicWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREAudio;
    message.url =  @"https://y.qq.com/n/yqq/song/003OUlho2HcRHC.html";
    message.text = @"欢迎使用极光社会化组件JShare，SDK包体积小，集成简单，支持主流社交平台、帮助开发者轻松实现社会化功能！";
    message.title = @"欢迎使用极光社会化组件JShare";
    message.platform = platform;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];
}

- (void)shareVideoWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREVideo;
    message.url =@"http://v.youku.com/v_show/id_XNTUxNDY1NDY4.html";
    message.text = @"欢迎使用极光社会化组件JShare，SDK包体积小，集成简单，支持主流社交平台、帮助开发者轻松实现社会化功能！";
    message.title = @"欢迎使用极光社会化组件JShare";
    message.platform = platform;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
    }];
}

- (void)shareAppWithPlatform:(JSHAREPlatform)platform {
    Byte* pBuffer = (Byte *)malloc(10*1024*1024);
    memset(pBuffer, 0, 10*1024);
    NSData* data = [NSData dataWithBytes:pBuffer length:10*1024*1024];
    free(pBuffer);
    
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREApp;
    message.url =@"https://www.jiguang.cn/";
    message.text = @"欢迎使用极光社会化组件JShare，SDK包体积小，集成简单，支持主流社交平台、帮助开发者轻松实现社会化功能！";
    message.title = @"欢迎使用极光社会化组件JShare";
    message.extInfo = @"<xml>extend info</xml>";
    message.fileData = data;
    message.platform = platform;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];
}

- (void)shareEmoticonWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREEmoticon;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6" ofType:@"gif"];
    NSData *emoticonData = [NSData dataWithContentsOfFile:filePath];
    message.emoticonData = emoticonData;
    message.platform = platform;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
    }];
}

- (void)shareFileWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREFile;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ML" ofType:@"pdf"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    message.fileData = fileData;
    message.fileExt = @"pdf";
    message.platform = platform;
    message.title = @"ML.pdf";
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];
}


@end
