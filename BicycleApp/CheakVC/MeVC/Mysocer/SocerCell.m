//
//  SocerCell.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "SocerCell.h"

@implementation SocerCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5,SCREEN_WIDTH*0.5-10, 20)];
        self.title.font = FontSize(14);
        self.title.textColor  = gary51;
        [self addSubview:self.title];
        
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5, 5, SCREEN_WIDTH*0.5-40, 20)];
        self.name.font = FontSize(14);
        self.name.textAlignment= NSTextAlignmentRight;
        self.name.textColor= gary51;
        [self addSubview:self.name];
        
        self.num = [[UILabel alloc]initWithFrame:CGRectMake(self.name.right, 5, 40, 20)];
        [self addSubview:self.num];
        self.num.font = FontSize(14);
        self.num.textAlignment= NSTextAlignmentLeft;
        
        
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(10, self.name.bottom, SCREEN_WIDTH*0.5-10, 15)];
        self.time.font =FontSize(12);
        self.time.textColor = gary153;
        [self addSubview:self.time];
        
        
        
        self.line = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH-10, 1)];
        [self addSubview:self.line];
        self.line.backgroundColor =gary238;
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
