//
//  HomeTopCheakView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/17.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^cheakBlock)();
@interface HomeTopCheakView : UIView
@property (weak, nonatomic) IBOutlet UILabel *LocalInfoLab;
 
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceTimeLab;
@property (nonatomic,copy)cheakBlock cheakBlock;
@end
