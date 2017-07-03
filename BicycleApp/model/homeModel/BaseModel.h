//
//  BaseModel.h
//  BicycleApp
//
//  Created by 雨停 on 2017/6/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>
@class dataModel;
@interface BaseModel : NSObject
@property (nonatomic,strong) dataModel * data;
@property (nonatomic,copy) NSString  * errorno;
@property (nonatomic,copy) NSString  * errmsg;
@end
