//
//  lockView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/24.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "lockView.h"

@implementation lockView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)Foundation:(UIButton *)sender {
    if(sender.tag==0){
        if(self.cheakBlock){
            self.cheakBlock(self.cheakViewBtn);
        }
    }else{
        if(self.submitBlock){
            self.submitBlock(self.submitBtn);
        }
    }
}

@end
