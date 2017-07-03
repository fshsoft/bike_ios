//
//  CertifyTopView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/18.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertifyTopView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *fourImg;
@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UIImageView *secondImg;
@property (weak, nonatomic) IBOutlet UIImageView *threeImg;
@property (weak, nonatomic) IBOutlet UIButton *CheakNumber;
@property (weak, nonatomic) IBOutlet UIButton *PushMoney;
@property (weak, nonatomic) IBOutlet UIButton *CheakName;
@property (weak, nonatomic) IBOutlet UIButton *CheakComplet;
@property (nonatomic,assign)NSInteger tag;

@end
