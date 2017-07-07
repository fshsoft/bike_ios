//
//  SocerVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "SocerVC.h"
#import "SocerCell.h"
#import "HcdProcessView.h"
@interface SocerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tab;
@end

@implementation SocerVC

- (void)viewDidLoad {
    [self sendRequest ];
    [super viewDidLoad];
    [self setSubView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIView*)setHeadView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 285)];
    
    view.backgroundColor =gary245;
    
    UIView *ring = [[UIView alloc]initWithFrame:CGRectMake( view.frame.size.width *0.5-80, 30, 160,  160)];
    [view addSubview:ring];
    ring .layer .cornerRadius=80;
    ring.backgroundColor =[UIColor whiteColor];
    
    HcdProcessView *customView = [[HcdProcessView alloc]initWithFrame:CGRectMake( 0, 0, 200,  200) ];
    customView.center =CGPointMake(80, 80);
 
    customView.time =@"评估于2017.05.16";
    customView.num=@"80";
    customView.backWaterColor  =[UIColor whiteColor];
    customView.percent =[customView.num integerValue]/100.0;
    customView.layer.masksToBounds=YES;
    [ring  addSubview:customView];
    
    UIButton *btn = [[UIButton alloc ]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5-50, ring.bottom +20, 100, 25)];
    [view addSubview:btn];
    btn.layer.cornerRadius=12.5;
    btn.layer.masksToBounds =YES;
    [btn setBackgroundImage :Img(@"btn_xyfen") forState:UIControlStateNormal];
    [btn setTitle:@"信用分规则" forState:UIControlStateNormal];
    btn.titleLabel.font  =FontSize(14);
    UILabel *labRecomend = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 34)];
    labRecomend.backgroundColor = [UIColor whiteColor];
    labRecomend.font = FontSize(15);
    labRecomend.textColor = gary51;
    labRecomend.text = @"  信用分变更记录";
    [view addSubview:labRecomend];
    return view;
}
-(void)sendRequest{
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"getUserIntegral",
                           
                           };
    
    [self requestType:HttpRequestTypePost
                  url:[DB getStringById:@"source_url" fromTable:tabName]
     
           parameters:dic
         successBlock:^(id response) {
             BaseModel   * model = [BaseModel yy_modelWithJSON:response];
             Toast(model.errmsg);
             NSString *errmsg = model.errmsg;
             NSLog(@"errmsg==%@",errmsg);
             
         } failureBlock:^(NSError *error) {
             
         }];
    
}
-(void)setSubView{
    [self setNaivTitle:@"我的信用积分"];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64)];
    self.tab.delegate  = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle  = UITableViewCellSeparatorStyleNone ;
    self.tab.tableHeaderView  = [self setHeadView];
    [self.view addSubview:self.tab];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str  =@"wqew";
    SocerCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell = [[SocerCell   alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle =UITableViewCellSelectionStyleNone  ;
    }
    if(indexPath.row%2==0){
    cell.title.text =@"违规停车";
    cell.time.text = @"2015-05  15-23";
    cell.name.text=@"信用分";
    cell.num.textColor =[UIColor greenColor];
        cell.num.text=@"-6";}else{
            cell.title.text =@"邀请好友注册";
            cell.time.text = @"2015-05  15-23";
            cell.name.text=@"信用分";
            cell.num.textColor =mainColor;
            cell.num.text=@"+2";
            
        }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end
