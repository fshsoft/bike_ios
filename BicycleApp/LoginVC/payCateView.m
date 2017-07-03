//
//  payCateView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/20.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "payCateView.h"

@implementation payCateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cheakSelect:(UIButton *)sender {
    
    if(self.cheakBlock){
        self.cheakBlock (self.cheakBtn);
    }
}

@end
