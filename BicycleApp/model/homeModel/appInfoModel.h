//
//  appInfoModel.h
//  BicycleApp
//
//  Created by 雨停 on 2017/7/3.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appInfoModel : NSObject
@property  (nonatomic,copy)NSString  * app_key;
@property  (nonatomic,copy)NSString  * app_secret;
@property  (nonatomic,copy)NSString  * authorize_url;
@property  (nonatomic,copy)NSString  * expire_time;
@property  (nonatomic,copy)NSString  * refresh_url;
@property  (nonatomic,copy)NSString  * seed_secret;
@property  (nonatomic,copy)NSString  * source_url;
@property  (nonatomic,copy)NSString  * token_url;
@property  (nonatomic,copy)NSString  * authorize_code;
@property  (nonatomic,copy)NSString  * message;
@property  (nonatomic,copy)NSString  * access_token;
@property  (nonatomic,copy)NSString  * refresh_token;
@property  (nonatomic,copy)NSString  * body;
@property  (nonatomic,copy)NSString  * createtime;
@property  (nonatomic,copy)NSString  * out_trade_no;
@property  (nonatomic,copy)NSString  * total_amout;
@property  (nonatomic,copy)NSString  * private_key;
//@property  (nonatomic,copy)NSString  * appId;
@property  (nonatomic,copy)NSString  * orderid;
@property  (nonatomic,copy)NSString  * subject;
@property  (nonatomic,copy)NSString  * balance;
@property  (nonatomic,copy)NSString  * integral;
@property  (nonatomic,copy)NSString  * is_verified;
@property  (nonatomic,copy)NSString  * mobile;
@property  (nonatomic,copy)NSString  * truename;
@property  (nonatomic,copy)NSString  * nickname;
@property  (nonatomic,copy)NSString  * idno;
@property  (nonatomic,copy)NSString  * is_paydeposit;
@property  (nonatomic,strong)NSArray   * bikes;
@property  (nonatomic,copy) NSString  * islogin;
@property  (nonatomic,copy)NSString  *deposit ;
@property  (nonatomic,copy)NSString  * order;
@property  (nonatomic,copy)NSString  *appid  ;
@property  (nonatomic,copy)NSString  *noncestr  ;
@property  (nonatomic,copy)NSString  *package  ;
@property  (nonatomic,copy)NSString  *partnerid  ;
@property  (nonatomic,copy)NSString  *prepayid  ;
@property  (nonatomic,copy)NSString  *sign  ;
@property  (nonatomic,copy)NSString  *timestamp  ;
@property  (nonatomic,copy)NSString  *cost;
@property  (nonatomic,copy)NSString  *display;
@property  (nonatomic,copy)NSString  *duration ;
@property  (nonatomic,copy)NSString  *scene ;
@property  (nonatomic,copy)NSString  * mac;
@property  (nonatomic,copy)NSString  *  uid ;
@end
