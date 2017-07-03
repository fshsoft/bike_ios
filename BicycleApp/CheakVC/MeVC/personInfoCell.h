//
//  personInfoCell.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personInfoCell : UITableViewCell
@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *detailtitle;
@property (nonatomic ,strong)UIImageView *personPhoto;
@property (nonatomic ,strong)UIImageView *prompt;
@property (nonatomic ,strong)UILabel *unselectedLab;
@property (nonatomic,strong)  UIImageView *line;
@end
