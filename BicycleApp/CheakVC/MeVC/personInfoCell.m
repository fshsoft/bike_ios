//
//  personInfoCell.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "personInfoCell.h"
@interface personInfoCell ()


@end
@implementation personInfoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
 
        [self setSubview];
    }
    
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setSubview{
    __weak typeof(self) typeWeak  = self;

    UILabel *title = [[UILabel alloc]init];
    [self addSubview:title];
    title.text=@"name";
    title.font= FontSize(13);
    self.title =title;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeWeak   );
        make.height.equalTo (@20);
        make.left.equalTo(typeWeak.mas_left).with.offset(14);
        make.width.equalTo(@(0.3*SCREEN_WIDTH));
    }];
    
    
    UIImageView *prompt = [[UIImageView alloc]init];
    [self addSubview:prompt];
    prompt.image = Img(@"home_ic_enter");
     self.prompt = prompt;
    [prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make .size .mas_equalTo(CGSizeMake(8, 12));
        make .centerY.equalTo(typeWeak);
        make.right.equalTo(typeWeak.mas_right).with.offset(-20);
        
    }];
    
    
    UIImageView *personPhoto = [[UIImageView alloc]init];
    
    [self addSubview:personPhoto];
    personPhoto.hidden =YES;
    personPhoto.userInteractionEnabled = YES;
    personPhoto.layer.masksToBounds = YES;
    personPhoto.layer.contentsGravity = kCAGravityResizeAspectFill;
    personPhoto.layer.cornerRadius =20;
    self.personPhoto = personPhoto;
    [personPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( 40,40 ));
        make.centerY.equalTo(typeWeak);
        make.right.equalTo(prompt.mas_left).with.offset(-20);
    }];
    UILabel  *detailtitle = [[UILabel alloc]init];
    [self addSubview:detailtitle];
    
    detailtitle.textAlignment  = NSTextAlignmentRight;
    detailtitle.font = FontSize(11);
    detailtitle.textColor =gary105;
    self.detailtitle=detailtitle;
    [detailtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.width.equalTo(@(0.3*SCREEN_WIDTH));
        make.centerY.equalTo(typeWeak);
        make.right.equalTo(prompt.mas_left).with.offset(-10);
    }];
    UILabel *unselectedLab = [ [UILabel alloc] init];
    [self addSubview:unselectedLab   ];
    unselectedLab.font = FontSize(10);
    unselectedLab.textAlignment = NSTextAlignmentRight;
    self.unselectedLab =unselectedLab;
    unselectedLab.hidden = YES;
    [unselectedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.width.equalTo(@(0.3*SCREEN_WIDTH));
        make.centerY.equalTo(typeWeak);
        make.right.equalTo(typeWeak.mas_right).with.offset(-30);
    }];
    
    self.line = [[UIImageView alloc]init];
    [self addSubview:self.line];
    self.line.backgroundColor =gary238;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(typeWeak.mas_bottom).with.offset(-0.5);
        make.height.equalTo(@0.5 );
        make.left.equalTo(typeWeak.mas_left).with.offset(14);
        make.right.equalTo(typeWeak.mas_right).with.offset(0);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
