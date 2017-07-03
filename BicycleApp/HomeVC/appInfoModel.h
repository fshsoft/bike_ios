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
@property  (nonatomic,copy)NSString  * errorno;
@property  (nonatomic,copy)NSString  * expire;
@property  (nonatomic,copy)NSString  * refresh_url;
@property  (nonatomic,copy)NSString  * seed_secret;
@property  (nonatomic,copy)NSString  * source_url;
@property  (nonatomic,copy)NSString  * status;
@property  (nonatomic,copy)NSString  * token_url;

@end
