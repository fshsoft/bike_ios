//
//  searchManager.h
//  BicycleApp
//
//  Created by 雨停 on 2017/6/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchManager : NSObject
//缓存搜索的数组
+(void)SearchText :(NSString *)seaTxt;
//清除缓存数组
+(void)removeAllArray;

@end
