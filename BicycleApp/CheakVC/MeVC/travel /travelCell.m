//
//  travelCell.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/23.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "travelCell.h"

@implementation travelCell
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self= [super initWithCoder:aDecoder]){
        self.backgroundColor =gary245;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)drawRect:(CGRect)rect{
    CGContextRef   text  = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(text, kCGLineCapRound);
    CGContextSetLineJoin(text, kCGLineJoinRound);

    CGContextMoveToPoint(text, 75, 0);
    CGContextSetLineWidth(text, 0.5);
    CGContextSetRGBStrokeColor(text, 1, 141/255.0, 40/255.0, 1);
    CGContextAddLineToPoint(text, 75, 90);
    
    //CGContextAddArc(text, 75, 15, 5, 0, M_PI*2, 0);
    CGContextSetRGBStrokeColor(text, 1, 141/255.0, 40/255.0, 1);
    CGContextStrokePath(text);
    CGContextAddArc(text, 75, 15, 5, 0, M_PI*2, 0);
    CGContextSetRGBFillColor(text, 1, 1, 1, 1);
    CGContextFillPath(text);
}

@end
