//
//  AboutMeCell.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AboutMeCell.h"

@implementation AboutMeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.left  =[[UILabel alloc]initWithFrame:CGRectMake(14, 0, 0.5*SCREEN_WIDTH-14, self.frame.size.height)];
        self.left.font =FontSize(13);
        self.left.textColor =gary51;
        [self addSubview:self.left];
        self.right = [[UILabel alloc]initWithFrame:CGRectMake(0.5*SCREEN_WIDTH, 0, 0.5*SCREEN_WIDTH-14, self.frame.size.height)];
        self.right.font =FontSize(11);
        self.right.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.right];
        self.line = [[UIImageView alloc]initWithFrame:CGRectMake(14, self.frame.size.height-1.,SCREEN_WIDTH-14, 1)];
        self.line.backgroundColor =gary238;
        [self addSubview:self.line];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
