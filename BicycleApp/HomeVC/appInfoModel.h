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
@end
