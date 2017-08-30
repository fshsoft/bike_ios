//
//  messageVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "messageVC.h"
#import "MessageCell.h"
@interface messageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong )UITableView *tab;
@end

@implementation messageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)setSubview{
    [self setNaivTitle:@"我的消息"];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStylePlain];
    self.tab.delegate   = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewScrollPositionNone;
    [self showPlaceholderViewWithImage:nil message:@"无新消息" buttonTitle:nil centerOffsetY:0 onSuperView:self.tab];
    [self.view addSubview:self.tab];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"qqq";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell = [[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
