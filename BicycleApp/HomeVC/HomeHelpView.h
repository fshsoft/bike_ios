//
//  HomeHelpView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/12.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^lockBlock)();
typedef void(^otherBlock)();
typedef void(^stopBlock)();
typedef void(^breakdownBlock)();

@interface HomeHelpView : UIView
@property (nonatomic,copy) lockBlock      lockBlock;
@property (nonatomic,copy) otherBlock   otherBlock;
@property (nonatomic,copy) stopBlock      stopBlock;
@property (nonatomic,copy) breakdownBlock breakdownBlock;
@end
