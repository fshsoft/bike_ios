//
//  stopView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/24.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^photoBlock)();
typedef  void(^cheakNumBlock)();
typedef  void(^subMitBtn)();

@interface stopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *palceholder;

@property (weak, nonatomic) IBOutlet UIButton *cheakBtn;
@property (weak, nonatomic) IBOutlet UIButton *photoSelect;
@property (weak, nonatomic) IBOutlet UIButton *cheakNum;
@property (copy, nonatomic) photoBlock     photoBlock;
@property (weak, nonatomic) IBOutlet UILabel *lenghCount;
@property (copy, nonatomic) cheakNumBlock  cheakNumBlock;
@property (copy, nonatomic) subMitBtn      subMitBtn;
@end
