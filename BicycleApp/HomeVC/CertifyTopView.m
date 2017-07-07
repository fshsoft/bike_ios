//
//  CertifyTopView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/18.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "CertifyTopView.h"
#import "UIView+ScaleAnimation.h"
@implementation CertifyTopView
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self awakeFromNib];
       
//        [self.fourImg startPulseWithColor:[UIColor whiteColor] scaleFrom:1 to:2 frequency:2 opacity:0.6 animation:YGPulseViewAnimationTypeRegularPulsing];
        
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.fourImg.layer.cornerRadius=5;
    self.fourImg.layer.masksToBounds= YES;
    self.firstImg.layer.cornerRadius=5;
    self.firstImg.layer.masksToBounds= YES;
    self.secondImg.layer.cornerRadius=5;
    self.secondImg.layer.masksToBounds= YES;
    self.threeImg.layer.cornerRadius=5;
    self.threeImg.layer.masksToBounds= YES;
//    [self.fourImg startPulseWithColor:[UIColor whiteColor] scaleFrom:1 to:2 frequency:2 opacity:0.6 animation:YGPulseViewAnimationTypeRegularPulsing];
}
-(void)layoutSubviews{
    [super layoutSubviews];
   
    [self setImgarcTag:self.tag];
  
       }
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setImgarcTag :(NSInteger)tag{
    if(tag ==0){
          [self.firstImg startPulseWithColor:mainColor scaleFrom:1 to:2 frequency:2 opacity:0.6 animation:YGPulseViewAnimationTypeRegularPulsing];
          self.firstImg.backgroundColor =mainColor;
        
        
        
           }else if(tag==1){
          [self.secondImg startPulseWithColor:mainColor scaleFrom:1 to:2 frequency:2 opacity:0.6 animation:YGPulseViewAnimationTypeRegularPulsing];
               CALayer *Mylayer=[CALayer layer];
               Mylayer.bounds=CGRectMake(0, 0, 20, 20);
               Mylayer.position=CGPointMake(5, 5);
               Mylayer.contents=(id)[UIImage imageNamed:@"pass_per"].CGImage;
               self.firstImg.layer.masksToBounds=NO;
               [self.firstImg.layer addSublayer:Mylayer ];
        self.secondImg.backgroundColor=mainColor;
     
    }else if(tag==2){
          [self.threeImg startPulseWithColor:mainColor scaleFrom:1 to:2 frequency:2 opacity:0.6 animation:YGPulseViewAnimationTypeRegularPulsing];
        CALayer *Mylayer=[CALayer layer];
        Mylayer.bounds=CGRectMake(0, 0, 20, 20);
        Mylayer.position=CGPointMake(5, 5);
        Mylayer.contents=(id)[UIImage imageNamed:@"pass_per"].CGImage;
        self.firstImg.layer.masksToBounds=NO;
        [self.firstImg.layer addSublayer:Mylayer ];
       CALayer *Mylayer2=[CALayer layer];
        Mylayer2.bounds=CGRectMake(0, 0, 20, 20);
       Mylayer2.position=CGPointMake(5, 5);
        Mylayer2.contents=(id)[UIImage imageNamed:@"pass_per"].CGImage;
        self.secondImg.layer.masksToBounds=NO;
        [self.secondImg.layer addSublayer:Mylayer2 ];
        self.threeImg.backgroundColor =mainColor    ;
       
    }else if(tag==3){
          [self.fourImg startPulseWithColor:mainColor scaleFrom:1 to:2 frequency:2 opacity:0.6 animation:YGPulseViewAnimationTypeRegularPulsing];
        self.fourImg.backgroundColor =mainColor;
        
        
    }
}
@end
