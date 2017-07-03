//
//  SocerCell.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocerCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *line;
@property (strong, nonatomic)  UILabel     * title;
@property (nonatomic,strong)   UILabel     * name;
@property (nonatomic,strong)   UILabel     * time;
@property (nonatomic,strong   )UILabel     * num;
@end
