//
//  LogoAgreement.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^imgSelect)();
@interface LogoAgreement : UIView
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,copy)imgSelect imgSelect;
@end
