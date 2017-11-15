//
//  CheakViewController.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/4.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"
@protocol scanDelegate <NSObject>
- (void)scanBlueTooth:(NSString * )str;
@end
@interface CheakViewController : XYBaseVC
//@property   (nonatomic,strong)UIButton *lightButton;
@property (nonatomic,weak)id <scanDelegate>blueToothdelegate;
@end
