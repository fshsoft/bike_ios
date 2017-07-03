//
//  SportDetailView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/20.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "SportDetailView.h"

@implementation SportDetailView
/*CGContextRef ctx = UIGraphicsGetCurrentContext();

//每调用一次，往上下文添加路径
CGContextMoveToPoint(ctx, 20, 40);
CGContextAddLineToPoint(ctx, self.frame.size.width-20, 40);
CGContextSetLineWidth(ctx, 0.5);
CGContextSetRGBStrokeColor(ctx, 0.5, 0.6, 0.7, 1);

CGContextMoveToPoint(ctx, self.frame.size.width*0.5, self.frame.size.height-(self.frame.size.height-40)*0.5-40);
CGContextAddLineToPoint(ctx, self.frame.size.width*0.5, self.frame.size.height-(self.frame.size.height-40)*0.5+40);

CGContextMoveToPoint(ctx,self.frame.size.width*0.5-40, self.frame.size.height-(self.frame.size.height-40)*0.5);
CGContextAddLineToPoint(ctx,self.frame.size.width*0.5+40 ,self.frame.size.height-(self.frame.size.height-40)*0.5);
//先把所有的路径定义好，然后一次性往上下文中添加
CGMutablePathRef path = CGPathCreateMutable();
// 把路径添加到上下文
CGContextAddPath(ctx, path);
// 渲染
CGContextStrokePath(ctx);
 
//CGPathRelease(path);
// 能用
CFRelease(path);*/


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef text = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(text, self.frame.size.width/3.0, 10);
    CGContextAddLineToPoint(text, self.frame.size.width/3.0, self.frame.size.height-10);
    CGContextSetLineWidth(text, 0.5);
    CGContextSetRGBStrokeColor(text, 0.6, 0.6, 0.6, 1);
    CGContextMoveToPoint(text, 2*self.frame.size.width/3.0, 10);
    CGContextAddLineToPoint(text,2*self.frame.size.width/3.0, self.frame.size.height-10);
    CGContextStrokePath(text);
    
    


}
 

@end
