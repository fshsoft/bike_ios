//
//  XYScanView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/6/13.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XYScanViewDelegate <NSObject>

-(void)getScanDataString:(NSString*)scanDataString;

@end

@interface XYScanView : UIView
@property (nonatomic,assign) int scanW; //扫描框的宽
@property (nonatomic,assign) id<XYScanViewDelegate> delegate;
- (void)startRunning; //开始扫描
- (void)stopRunning; //停止扫描
@end
