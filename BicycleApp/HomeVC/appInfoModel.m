//
//  appInfoModel.m
//  BicycleApp
//
//  Created by 雨停 on 2017/7/3.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "appInfoModel.h"

@implementation appInfoModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    
    return @{
           @"errorno":@"errno"
             };
}
/// Dic -> model
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    self.errorno = dic[@"errno"];
    
    return YES;
}

/// model -> Dic
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    
    dic[@"errno"] =self.errorno;
    
    return YES;
}

@end
