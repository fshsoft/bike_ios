//
//  UIView+ScaleAnimation.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/20.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, YGPulseViewAnimationType) {
    YGPulseViewAnimationTypeRegularPulsing,
    YGPulseViewAnimationTypeRadarPulsing
};

@interface UIView (ScaleAnimation)
- (void)startPulseWithColor:(UIColor *)color;

- (void)startPulseWithColor:(UIColor *)color animation:(YGPulseViewAnimationType)animationType;

- (void)startPulseWithColor:(UIColor *)color scaleFrom:(CGFloat)initialScale to:(CGFloat)finishScale frequency:(CGFloat)frequency opacity:(CGFloat)opacity animation:(YGPulseViewAnimationType)animationType;

- (void)stopPulse;
@end
