//
//  DemessageCell.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "DemessageCell.h"

@implementation DemessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5,SCREEN_WIDTH*0.5-10, 20)];
        self.title.font = FontSize(14);
        [self addSubview:self.title];
        
        self.money = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5, 5, SCREEN_WIDTH*0.5-10, 20)];
        self.money.font = FontSize(14);
        self.money.textAlignment= NSTextAlignmentRight;
        [self addSubview:self.money];
        
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(10, self.money.bottom, SCREEN_WIDTH*0.5-10, 15)];
        self.time.font =FontSize(12);
        self.time.textColor = gary170;
        [self addSubview:self.time];
        
        self.payName = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5, self.money.bottom, SCREEN_WIDTH*0.5-10, 15)];
        
        self.payName.font =FontSize(12);
        self.payName.textColor = gary170;
        self.payName.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.payName];
        
        self.line = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH-10, 1)];
        [self addSubview:self.line];
        self.line.backgroundColor =gary221;
        
        
    }
    return self;
}
@end
