//
//  travelVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "travelVC.h"
#import "SportDetailView.h"
#import "travelCell.h"
@interface travelVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)SportDetailView * topView;
@property (nonatomic,strong)UITableView     * tab ;
@end

@implementation travelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}
-(void)setTopView{
    [self setNaivTitle:@"我的行程"];

    self.topView  = [[NSBundle mainBundle]loadNibNamed:@"SportDetail" owner:self options:nil].lastObject;
    [self.view addSubview:self.topView];
 
    self.topView.frame =CGRectMake(0, 64, SCREEN_WIDTH, 100);
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 164, SCREEN_WIDTH, SCREENH_HEIGHT-164) style:UITableViewStylePlain ];

    self.tab.delegate   = self;
    self.tab.dataSource = self;
   
    self.tab.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tab];
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str =@"wqew";
    travelCell  *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        
        cell =[[NSBundle mainBundle]loadNibNamed:@"travel" owner:self options:nil].lastObject;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
