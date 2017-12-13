//
//  AppDelegate.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/3.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "LaunchIntroductionView.h"
#import "JSHAREService.h"
#import "HomeVC.h"
#import <WXApi.h>
//#import <AdSupport/AdSupport.h>
#import "XHLaunchAdManager.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<WXApiDelegate ,JPUSHRegisterDelegate>{
    HomeVC * home;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setTabifno];
    [self setGaodeMapInfo];
    [self setKeyboardManager];
    [WXApi registerApp:WXAppId];
    [self setPushInfo:launchOptions];
    [self setzShearInfo];
    [self setRootView];
    [self setLaunchfirst];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    

    return YES;
    
}
- (void)networkDidReceiveMessage:(NSNotification *)notification{
    
}
-(void)setLaunchfirst{
   [LaunchIntroductionView sharedWithImages:@[@"01",@"page02",@"page03",@"04"] buttonImage:nil buttonFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];

}
-(void)setTabifno{
    Tab;
    }
-(void)setKeyboardManager{
    
    // 控制点击背景是否收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // 控制键盘上的工具条文字颜色是否用户自定义
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    // 控制是否显示键盘上的工具条
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;}

-(void)setRootView{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
     self.window.backgroundColor = [UIColor whiteColor];
    home =[[HomeVC alloc]init];
     NavigationVC  *niv = [[NavigationVC  alloc]initWithRootViewController:home ];
     self.window.rootViewController =niv;
     [self.window makeKeyAndVisible];
  
    }

-(void)setGaodeMapInfo{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    [AMapServices sharedServices].apiKey =@"8d62d02999642e9a3e88e94ffd1106f1";
    
    [[AMapServices sharedServices] setEnableHTTPS:YES];
}


 - (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];

    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if
    // appropriate. See also applicationDidEnterBackground:.
}
    // ===================================         推送        ==============================================
-(void)setPushInfo :(NSDictionary *)launchOptions{
    
   // NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //      NSSet<UNNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
        //    else {
        //      NSSet<UIUserNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            [DB putString:registrationID withId:@"pushID" intoTable:tabName];
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];

}



// 实现该回调方法并添加回调方法中的代码
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    rootViewController.deviceTokenValueLabel.text =
//    [NSString stringWithFormat:@"%@", deviceToken];
//    rootViewController.deviceTokenValueLabel.textColor =
//    [UIColor colorWithRed:0.0 / 255
//                    green:122.0 / 255
//                     blue:255.0 / 255
//                    alpha:1];
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}
//注册失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    
    
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {

}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
    
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
   // [rootViewController addNotificationCount];
     [home requestCheakNOtify];
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
         [home requestCheakNOtify];
       // [rootViewController addNotificationCount];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
      //  [rootViewController addNotificationCount];
  [home requestCheakNOtify];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
       // [rootViewController addNotificationCount];
        [home requestCheakNOtify];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

 // ===================================         分享        ==============================================
#pragma 分享
-(void)setzShearInfo{
    JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
    config.appKey = appKey;
    config.SinaWeiboAppKey = @"3335491129";
    config.SinaWeiboAppSecret = @"f55f2f6a2720b22b79a6c32674ed15b7";
    config.SinaRedirectUri = @"https://www.jiguang.cn";
    config.QQAppId =  @"1106093023";
    config.QQAppKey = @"gpRgdKRhSojPPKMr";
    config.WeChatAppId = @"wx9befb1503750db67";
    config.WeChatAppSecret = @"efc5e55b871586594e964d0ead38d8cd";
    [JSHAREService setupWithConfig:config];
    [JSHAREService setDebug:YES];

    
}
  // ===================================        支付        ==============================================
#pragma mark 跳转处理


//新的方法
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    if ([url.host isEqualToString:@"safepay"]) {
                //跳转支付宝钱包进行支付，处理支付结果
             [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                   NSLog(@"result = %@",resultDic);
                                 
                 NSNotification * notification = [NSNotification notificationWithName:@"alPay" object:[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]]];
                 [[NSNotificationCenter defaultCenter] postNotification:notification];
              }];
          }
    if([url.scheme isEqualToString:WXAppId]){
        return [WXApi handleOpenURL:url delegate:self];
    }
        return YES;
   }

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
                        NSNotification * notification = [NSNotification notificationWithName:@"alPay" object:[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]]];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }];
    }
    if([url.scheme isEqualToString:WXAppId]){
        return [WXApi handleOpenURL:url delegate:self];
    }

    
    return  YES;
    
}

 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if([url.scheme isEqualToString:WXAppId]){
        return [WXApi handleOpenURL:url delegate:self];
    }
   [JSHAREService handleOpenUrl:url];
    return YES;
}
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
//                                                        message:payResoult
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
        //        [[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
        //这里可以向外面跑消息
        //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
        NSNotification * notification = [NSNotification notificationWithName:@"WXPay" object:[NSString stringWithFormat:@"%d",resp.errCode]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
}


@end
