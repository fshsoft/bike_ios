//
//  breakView.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "breakView.h"

@implementation breakView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)BtnFoundation:(UIButton *)sender {
    if(sender.tag>0&&sender.tag<9){
        if([sender.imageView.image isEqual:Img(@"xkuang_onclick")]){
            [sender setImage:Img(@"xkuang_nor") forState:UIControlStateNormal];
      }else{
            [sender setImage:Img(@"xkuang_onclick") forState:UIControlStateNormal];
        }
    }
    if(sender.tag==0){
        if(self.cheakNumBlock){
            self.cheakNumBlock(self.cheakBtn);
        }
        
    }else if (sender.tag==10){
        if(self.photoselectBlock){
            self.photoselectBlock(self.photoSelect);
        }
    }else if(sender.tag==9){
        if(self.subMitBlock){
            self.subMitBlock(self.submitBtn);
        }
    }
}
@end
