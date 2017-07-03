//
//  payCateView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/20.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cheakBlock)();
@interface payCateView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *cheakBtn;
@property (nonatomic,copy)cheakBlock cheakBlock;
@end
