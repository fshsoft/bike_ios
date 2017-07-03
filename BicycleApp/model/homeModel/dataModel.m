//
//  dataModel.m
//  BicycleApp
//
//  Created by 雨停 on 2017/6/20.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "dataModel.h"
#import "annotionInfoModel.h"
@implementation dataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [annotionInfoModel class],
             
             };
}

@end
