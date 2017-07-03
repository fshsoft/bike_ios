//
//  HomeNaviView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/19.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "HomeNaviView.h"

@implementation HomeNaviView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)leftBtnFoundation:(UIButton *)sender {
    if(self.leftBlock){
        self.leftBlock(self.leftBtn);
    }
}
- (IBAction)mesBtnFoundation:(UIButton *)sender {
    if(self.mesBlock){
        self.mesBlock(self.mesBtn);
    }
}
- (IBAction)seachBtnFoundation:(UIButton *)sender {
    if(self.searchBlock){
        self.searchBlock(self.searchBtn);
    }
}

@end
