//
//  LogoAgreement.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "LogoAgreement.h"

@implementation LogoAgreement
-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(6,(self.frame.size.height-12.5)/2.0,12.5,12.5 )];
       self.img.image =Img(@"cheaked");
        [self addSubview:self.img];
        self.img.userInteractionEnabled = YES;
        self.img.layer.masksToBounds =YES;
        self.img.layer.cornerRadius =2;
        self.img.layer.borderColor = RGBColor(170, 170, 170).CGColor;
        self.img.layer.borderWidth = 0.5;
        UIButton *btn = [[UIButton alloc]initWithFrame:self.img.frame];
        [self.img addSubview:btn];
        [btn addTarget:self action:@selector(imgChange) forControlEvents:UIControlEventTouchUpInside];
        self.title =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width-20, self.frame.size.height)];
        self.title.font  = FontSize(10);
        [self addSubview:self.title];
    }
    return  self;
}
-(void)imgChange{
    if(self.imgSelect){
        self.imgSelect();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
