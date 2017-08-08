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
        make.size.mas_equalTo(CGSizeMake(35,  35));
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.left.equalTo(self.mas_left).with.offset(10);
    }];
    self.mapcenterButton  = [[UIButton alloc]init];
    [self addSubview:self.mapcenterButton];
    self.mapcenterButton.tag=1;
    [self.mapcenterButton addTarget:self action:@selector(BlockTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapcenterButton setBackgroundImage:Img(@"dw_pic") forState:UIControlStateNormal];
    [self.mapcenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35 , 35));
        make.top.equalTo(self.refreshButton).with.offset(0);
        make.left.equalTo(self.refreshButton.mas_right).with.offset(10);
        
    }];
    
    self.helpcenterButton  = [[UIButton alloc]init];
    [self addSubview:self.helpcenterButton];
    self.helpcenterButton.tag=2;
    [self.helpcenterButton setBackgroundImage:Img(@"service") forState:UIControlStateNormal];
    [self.helpcenterButton addTarget:self action:@selector(BlockTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.helpcenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( 35, 35));
        make.bottom .equalTo(self.mas_bottom).with.offset(-10);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
    
    
    self.cheakinfoButton  = [[UIButton alloc]init];
    [self addSubview:self.cheakinfoButton];
    self.cheakinfoButton.tag=4;
    [self.cheakinfoButton setBackgroundImage:Img(@"huodong") forState:UIControlStateNormal];
    [self.cheakinfoButton addTarget:self action:@selector(BlockTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.cheakinfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( 35, 35));
        make.bottom .equalTo(self.mas_bottom).with.offset(-10);
        make.right.equalTo(self.helpcenterButton.mas_left).with.offset(-10);
    }];
    
    
    
    
    
    
    self.cheakcodeButton  =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width*0.5-40,  0, 80, 80)];
    [self addSubview: self.cheakcodeButton];
    
    
    
    
    [self.cheakcodeButton addTarget:self action:@selector(BlockTag:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.cheakcodeButton.tag =3;
    ViewBorderRadius(self.cheakcodeButton, 40, 0, [UIColor clearColor]);
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*0.5-20,  20, 40, 40)];
    img.image = Img(@"home_ic_sm");
    [self addSubview: self.cheakcodeButton];
    [self.cheakcodeButton setBackgroundColor:mainColor];
    
    [self addSubview:img];
    
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
        }else if(sender.tag==4){
            if(self.infoBlock){
                self.infoBlock(self.cheakinfoButton);
            }
        }
    
}
@end
