//
//  listInfoModel.m
//  BicycleApp
//
//  Created by 雨停 on 2017/7/7.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "listInfoModel.h"
#import "annotionInfoModel.h"
@implementation listInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : [annotionInfoModel class],
           
             };
}
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
