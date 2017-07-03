//
//  MessageCell.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "MessageCell.h"
@interface MessageCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation MessageCell
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder])
    {
       
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.cornerRadius =10;
  
    //self.backView.layer.masksToBounds  = YES;
    
    
//    CALayer *subLayer=[CALayer layer];
//    
//    CGRect fixframe=self.backView.layer.frame;
//    
//    fixframe.size.width=self.frame.size.width-20;
//    
//    subLayer.frame=fixframe;
//    
//    subLayer.cornerRadius=10;
//    
//    subLayer.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
//    
//    subLayer.masksToBounds=NO;
//    
//    subLayer.shadowColor=[UIColor grayColor].CGColor;
//    
//    subLayer.shadowOffset=CGSizeMake(10,10);
//    
//    subLayer.shadowOpacity=0.5;
//    
//    subLayer.shadowRadius=10;
//    
//    [self.layer insertSublayer:subLayer below:self.backView.layer];

    
    self.backView.layer .shadowOffset= CGSizeMake(0, 1);
    self.backView.layer.borderColor = [UIColor redColor].CGColor;
//    CALayer *layer = [[CALayer alloc]init];
//    layer.frame =CGRectMake(0, 0, self.backView.frame.size.width, 200);
//    layer.contents = (__bridge id)Img(@"logo").CGImage;
//    [self.backView.layer addSublayer:layer];
    //self.backView.layer.borderWidth =1;
    self.backView.layer.shadowRadius = 5.f;
    self.backView.layer.shadowOpacity =0.1;
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super  layoutSubviews];
}
@end
