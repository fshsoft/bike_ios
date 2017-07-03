//
//  LogoTextField.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "LogoTextField.h"

@implementation LogoTextField


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = gary242;
        self.tittle  = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 64, self.frame.size.height)];
        self.tittle.textAlignment =NSTextAlignmentLeft;
        self.tittle.font =FontSize(14);
        [self addSubview:self.tittle ];
        self.field   = [[UITextField alloc]initWithFrame:CGRectMake(79, 0, self.frame.size.width-89, self.frame.size.height)];
        self.field.textColor = gary51;
        self.field.font      = FontSize(14);
        self.field.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.field ];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
