//
//  listInfoModel.h
//  BicycleApp
//
//  Created by 雨停 on 2017/7/7.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>
@class annotionInfoModel;
@interface listInfoModel : NSObject
@property  (nonatomic,strong) NSArray   * data;
@property  (nonatomic,copy)   NSString  * errorno;
@property  (nonatomic,copy)   NSString  * status;
@property  (nonatomic,copy)   NSString  * errmsg;
@property  (nonatomic,copy)   NSString  * message;
@end
