//
//  searchManager.m
//  BicycleApp
//
//  Created by 雨停 on 2017/6/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "searchManager.h"

@implementation searchManager
//缓存搜索数组
+(void)SearchText :(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组
        
    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT addObject:seaTxt];
    if(searTXT.count > 5)
    {
        [searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
    //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:searTXT forKey:@"myArray"];
    [userDefaultes synchronize];
}
+(void)removeAllArray{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"myArray"];
    [userDefaults synchronize];
}

@end
