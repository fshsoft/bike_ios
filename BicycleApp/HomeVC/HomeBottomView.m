//
//  HomeBottomView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/11.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "HomeBottomView.h"

@implementation HomeBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        self.backgroundColor =[UIColor clearColor];
        [self setSubview ];
    }
    
    return self;
}

-(void)setSubview{
    
    self.refreshButton  = [[UIButton alloc]init];
    
    [self addSubview:self.refreshButton];
    [self.refreshButton setBackgroundImage:Img(@"refresh") forState:UIControlStateNormal];

    self.refreshButton.tag=0;
    self.refreshButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.refreshButton addTarget:self action:@selector(BlockTag:) forControlEvents:UIControlEventTouchUpInside];
    
    self.refreshButton. clipsToBounds = YES;
    [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35 , 35));
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(10);
    }];
    self.mapcenterButton  = [[UIButton alloc]init];
    [self addSubview:self.mapcenterButton];
    self.mapcenterButton.tag=1;
    [self.mapcenterButton addTarget:self action:@selector(BlockTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapcenterButton setBackgroundImage:Img(@"dw_pic") forState:UIControlStateNormal];
    [self.mapcenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35,  35));
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.left.equalTo(self.mas_left).with.offset(10);
    }];
    
    self.helpcenterButton  = [[UIButton alloc]init];
    [self addSubview:self.helpcenterButton];
    self.helpcenterButton.tag=2;
    [self.helpcenterButton setBackgroundImage:Img(@"service_pic") forState:UIControlStateNormal];
    [self.helpcenterButton addTarget:self action:@selector(BlockTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.helpcenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( 35, 35));
        make.bottom .equalTo(self.mas_bottom).with.offset(-10);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
    
   self.cheakcodeButton  =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width*0.5-60,  40, 120, 40)];
    [self addSubview: self.cheakcodeButton];
    [self.cheakcodeButton addTarget:self action:@selector(BlockTag:) forControlEvents:UIControlEventTouchUpInside];
    self.cheakcodeButton.tag =3;
    ViewBorderRadius(self.cheakcodeButton, 20, 0, [UIColor clearColor]);
    [self.cheakcodeButton setImage:Img(@"home_ic_sm") forState:UIControlStateNormal];
    self.cheakcodeButton.imageView.contentMode =UIViewContentModeScaleAspectFit;
    self.cheakcodeButton.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, self.cheakcodeButton.titleLabel.bounds.size.width+10);
    [self.cheakcodeButton setBackgroundColor:mainColor];
   self.cheakcodeButton.titleLabel.font =FontBold(14);
    
    [self.cheakcodeButton setTitle:@"扫码开锁" forState:UIControlStateNormal];
     self.cheakcodeButton.adjustsImageWhenHighlighted =NO;
    [self.cheakcodeButton addTarget:self action:@selector(BlockTag:) forControlEvents:UIControlEventTouchUpInside];

    
}
-(void)BlockTag:(UIButton *)sender{
    if(sender.tag ==0){
        if(self.freshBlock){
            self.freshBlock(self.refreshButton);
        }
    
    }else
    if(sender.tag==1){
        if(self.mapBlock){
            self.mapBlock(self.mapcenterButton);
        }
        
    }else if(sender.tag==2){
        if(self.helpBlock){
            self.helpBlock(self.helpcenterButton);
        }
        
    }else if(sender.tag==3){
        if(self.cheakBlock){
            self.cheakBlock(self.cheakcodeButton);
      }
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
