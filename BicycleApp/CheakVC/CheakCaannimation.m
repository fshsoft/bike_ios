//
//  CheakCaannimation.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/19.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "CheakCaannimation.h"
@interface CheakCaannimation()
@property (nonatomic,strong)UILabel * labTitle;
@property (nonatomic,strong)UIImageView * logo;
@end
@implementation CheakCaannimation
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        CGFloat textH = 20;
        CGFloat textW = 30;
        CGFloat viewW = frame.size.width;
        CGFloat viewH = frame.size.height;
        
        CGFloat textX = (viewW - textW) * 0.5;
        CGFloat textY = viewH - textH-20;
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,140, 80)];
        self.logo.center =CGPointMake(frame.size.width/2.0, viewH/2.0);
        self.logo.image =Img(@"kaisuo_loogo");
        [self addSubview:self.logo];
        // 1.画文字
        //NSString *text = [NSString stringWithFormat:@"%.0f%%",self.pregress*100];
        
        self.labTitle = [[UILabel alloc]initWithFrame:CGRectMake(textX, textY, textW, textH)];
        self.labTitle.textAlignment = NSTextAlignmentCenter;
        self.labTitle.textColor = [UIColor whiteColor];
        self.labTitle.font  = FontSize(14);
        [self addSubview:self.labTitle];
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   // CGFloat textH = 20;
    //CGFloat textW = 30;
    CGFloat viewW = rect.size.width;
    CGFloat viewH = rect.size.height;
    
    //CGFloat textX = (viewW - textW) * 0.5;
    //CGFloat textY = viewH - textH-10;
    
    // 1.画文字
 self.labTitle.text = [NSString stringWithFormat:@"%.0f%%",self.pregress*100];
   // [text drawInRect:CGRectMake(textX, textY, textW, textH) withAttributes:nil];
    //半径
    
    
    CGFloat radius = (viewW - 10) * 0.5;
    
    
    // 2.画弧
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetRGBfillColor(context, 254, 147, 68, 1);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    CGContextAddArc(context, viewW * 0.5, viewH * 0.5, radius, 0, M_PI*2, 0);
    CGContextSetLineWidth(context, 10);
    //RGBColor(254, 147, 68)
    CGContextStrokePath(context);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGFloat endAngle = self.pregress * 2 * M_PI - M_PI_2;
    CGContextSetRGBStrokeColor(context, 0.9, 0.5, 0.3, 1);
    CGContextAddArc(context, viewW * 0.5, viewH * 0.5, radius, - M_PI_2, endAngle, 0);
    CGContextSetLineWidth(context, 10);
    
    CGContextStrokePath(context);

}
-(void)setPregress:(float)pregress{
    _pregress = pregress;
    
    //重绘
    [self setNeedsDisplay];
}


@end
