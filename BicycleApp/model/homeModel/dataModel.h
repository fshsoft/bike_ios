//
//  dataModel.h
//  BicycleApp
//
//  Created by 雨停 on 2017/6/20.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "personModel.h"
@class annotionInfoModel;
@interface dataModel : NSObject
@property (nonatomic,strong)NSArray *list;
@property (nonatomic,strong)personModel *user;
@end
