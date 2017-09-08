//
//  annotionInfoModel.h
//  BicycleApp
//
//  Created by 雨停 on 2017/6/12.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface annotionInfoModel : NSObject
@property  (nonatomic,copy)NSString  * id;
@property  (nonatomic,assign)float  lat;
@property  (nonatomic,assign)float lng;
@property  (nonatomic,copy)NSString  * distance;
@property  (nonatomic,copy)NSString  * action;

@property  (nonatomic,copy)NSString  * balance;
@property  (nonatomic,copy)NSString  * integral;
@property  (nonatomic,copy)NSString  * is_verified;
@property  (nonatomic,copy)NSString  * mobile;
@property  (nonatomic,copy)NSString  * truename;
@property  (nonatomic,copy)NSString  * nickname;

@property  (nonatomic,copy)NSString  * changed;
@property  (nonatomic,copy)NSString  * current;
@property  (nonatomic,copy)NSString  * direction;
@property  (nonatomic,copy)NSString  * note;



@property (nonatomic,copy)NSString  * payment_id;
@property (nonatomic,copy)NSString  *  paidtype;


 

 


@end
