//
//  personInfo.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/8.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"
@protocol cheshidelegate<NSObject>
-(void)PersonName :(NSString *)str;
@end
@interface personInfo : XYBaseVC
@property (nonatomic,copy)void(^block)( UIImage *image );
@end
