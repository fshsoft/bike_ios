//
//  PaySelect.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/10.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaySelect : NSObject
 

+(void)aliPay:(NSString *)order;
+(void)WxpayappID:(NSString * )appid
        partnerID:(NSString *)partnertid
         noncestr:(NSString *)noncestr
         package :(NSString *)package
       timestamp :(NSString *)timestamp
         prepayid:(NSString *)prepayid
             sign:(NSString *)sign;
@end
