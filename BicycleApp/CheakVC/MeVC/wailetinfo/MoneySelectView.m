//
//  MoneySelectView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "MoneySelectView.h"

@implementation MoneySelectView
- (IBAction)hunFoundation:(UIButton *)sender {
    if(self.hunBlock){
        self.hunBlock(self.hundredBtn);
    }
}
- (IBAction)halfHtnFoundation:(UIButton *)sender {
    if(self.halfhunBlock){
        self.halfhunBlock(self.halfHunBtn);
    }
}
- (IBAction)twoTenFoundation:(UIButton *)sender {
    if(self.twotenBlock){
        self.twotenBlock(self.twoTenBtn);
    }
}
- (IBAction)tenBtn:(UIButton *)sender {
    if(self.tenBlock){
        self.tenBlock(self.tenBtn);
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
