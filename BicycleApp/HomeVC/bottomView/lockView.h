//
//  lockView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/24.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cheakBlock)();
typedef  void(^submitBlock)();
@interface lockView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UIButton *cheakViewBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property  (nonatomic,copy)cheakBlock cheakBlock;
@property  (nonatomic,copy)submitBlock  submitBlock;
@property (weak, nonatomic) IBOutlet UILabel *lenghcount;

@end
