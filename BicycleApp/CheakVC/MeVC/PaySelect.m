//
//  PaySelect.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/10.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "PaySelect.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import "AlipaySDK/AlipaySDK.h"
#import <WXApi.h>



@interface   PaySelect () 

@end
@implementation PaySelect



+(void)aliPay:(NSString *)order{
    NSString *appScheme = @"bikeAlipay";
    
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:order fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        NSNotification * notification = [NSNotification notificationWithName:@"alPay" object:[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
  
}
+(void)WxpayappID:(NSString * )appid
        partnerID:(NSString *)partnertid
         noncestr:(NSString *)noncestr
         package :(NSString *)package
       timestamp :(NSString *)timestamp
         prepayid:(NSString *)prepayid
             sign:(NSString *)sign
{
    
    // 调起微信支付
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = partnertid;
    request.prepayId  = prepayid;
    request.package   = package;
    request.nonceStr  = noncestr;
    request.timeStamp = [timestamp intValue];
    
    //添加签名
    request.sign = sign;
    
    [WXApi sendReq:request];
    
    
}

@end
