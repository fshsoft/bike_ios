//
//  HomeTopCheakView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/17.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "HomeTopCheakView.h"

@implementation HomeTopCheakView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cheakSelecd:(id)sender {
    if(self.cheakBlock){
        self.cheakBlock();
    }
}

@end
