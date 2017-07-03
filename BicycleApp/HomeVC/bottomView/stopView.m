//
//  stopView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/24.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "stopView.h"

@implementation stopView

- (IBAction)BtnFoundation:(UIButton *)sender {
    if(sender.tag==0){
        if(self.cheakNumBlock){
            self.cheakNumBlock();
        }
    }else if(sender.tag==1){
        if(self.photoBlock){
            self.photoBlock();
        }
        
    }else if (sender.tag==2){
        if(self.subMitBtn){
            self.subMitBtn();
        }
        
    }
}


@end
