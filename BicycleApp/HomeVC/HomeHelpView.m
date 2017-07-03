//
//  HomeHelpView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/12.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "HomeHelpView.h"
#import "UIButton+TitleImgEdgeInsets.h"

@interface HomeHelpView()
@property (nonatomic,strong)UILabel   * protmLab;
@property (nonatomic,strong)UIButton  * btnLock;
@property (nonatomic,strong)UIButton  * btnStop;
@property (nonatomic,strong)UIButton  * btnBreakdown;
@property (nonatomic,strong)UIButton  * btnOther;
@end
@implementation HomeHelpView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
       [self setSubview];
        self.layer.cornerRadius=5;
        self.userInteractionEnabled=YES;
        self.layer.masksToBounds=YES;
        }
    return self;
    
    
}
-(void)setSubview{
    CGFloat cw      =  self.frame.size.width;
    CGFloat ch      =  self.frame.size.height;
    self.protmLab   =  [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width , 40)];
    [self addSubview : self.protmLab];
    self.protmLab.textAlignment = NSTextAlignmentCenter;
    self.protmLab.font    =  FontSize(14);
    self.protmLab.text    =  @"客户服务";
   
    self.btnLock     = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview : self.btnLock];
    self.btnLock.tag = 0;
  
    [self.btnLock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cw*0.5-2,(ch-40)*0.5-2 ));
        make.left.equalTo(self.mas_left).with.offset(1);
        make.top.equalTo(self.mas_top).with.offset(41);
    }];
    [self setBtntitle:@"开不了锁" Imgstr:@"suo" Btn:self.btnLock];
    [self.btnLock addTarget:self action:@selector(getSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnLock layoutButtonTitleImageEdgeInsetsWithStyle:3 titleImgSpace:10];
    self.btnLock.adjustsImageWhenHighlighted =NO;
    self.btnStop     = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btnStop];
    self.btnStop.tag =1 ;
    [self.btnStop layoutButtonTitleImageEdgeInsetsWithStyle:3 titleImgSpace:10];
    [self.btnStop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cw*0.5-2,(ch-40)*0.5-2 ));
        make.left.equalTo(self.mas_left).with.offset(1);
        make.top.equalTo(self.btnLock.mas_bottom).with.offset(2);
    }];
     [self setBtntitle:@"举报违停" Imgstr:@"jubao" Btn:self.btnStop];
     [self.btnStop addTarget:self action:@selector(getSelected:) forControlEvents:UIControlEventTouchUpInside];
     self.btnStop.adjustsImageWhenHighlighted =NO;
     [self.btnStop layoutButtonTitleImageEdgeInsetsWithStyle:3 titleImgSpace:10];

   
    self.btnBreakdown     = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btnBreakdown];
    self.btnBreakdown.tag = 2;
    [self.btnBreakdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cw*0.5-2,(ch-40)*0.5-2 ));
        make.top.equalTo(self.mas_top).with.offset(41);
        make.left.equalTo(self.btnLock.mas_right).with.offset(2);
    }];
      [self setBtntitle:@"发现车辆故障" Imgstr:@"guzhang" Btn:self.btnBreakdown];
      [self.btnBreakdown  addTarget:self action:@selector(getSelected:) forControlEvents:UIControlEventTouchUpInside];

      [self.btnBreakdown layoutButtonTitleImageEdgeInsetsWithStyle:3 titleImgSpace:10];
          self.btnBreakdown.adjustsImageWhenHighlighted =NO;
    
    self.btnOther = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btnOther];
        self.btnOther.tag = 3;
       [self.btnOther mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cw*0.5-2,(ch-40)*0.5-2 ));
        make.top.equalTo(self.btnBreakdown.mas_bottom).with.offset(2);
        make.left.equalTo(self.btnLock.mas_right).with.offset(2);
    }];
    [self setBtntitle:@"其他问题" Imgstr:@"problem" Btn:self.btnOther];
    [self.btnOther addTarget:self action:@selector(getSelected:) forControlEvents:UIControlEventTouchUpInside];
     self.btnOther.adjustsImageWhenHighlighted =NO;
    [self.btnOther layoutButtonTitleImageEdgeInsetsWithStyle:3 titleImgSpace:10];


}

-(void)getSelected:(UIButton *)sender{
    if(sender.tag==0){
        if(self.lockBlock){
            self.lockBlock(self.btnLock);
        }
    }else if(sender.tag==1){
        if(self.stopBlock){
            self.stopBlock(self.btnStop);
        }
    }else if(sender.tag==2){
        if(self.breakdownBlock){
            self.breakdownBlock(self.btnBreakdown);
        }
    }else if(sender.tag==3){
        if(self.otherBlock){
            self.otherBlock(self.btnOther);
        }
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
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
    //开发过程中，ARC环境 C语言的资源是不会自动释放
    // 什么情况下创建的C语言资源，需要释放 以create，retain,copy创建的数据要释放
    //CGPathRelease(path);
    // 能用
    CFRelease(path);
    

}
-(void)setBtntitle :(NSString *)title Imgstr:(NSString*)img Btn:(UIButton *)sender{
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setImage:Img(img) forState:UIControlStateNormal];
    sender.titleLabel.font = FontSize(12);
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

@end
