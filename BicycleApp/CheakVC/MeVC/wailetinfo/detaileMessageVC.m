//
//  detaileMessageVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "detaileMessageVC.h"
#import "DemessageCell.h"
@interface detaileMessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView   *tab ;
@end

@implementation detaileMessageVC

- (void)viewDidLoad {
    [self sendRequest];
    [super viewDidLoad];
    [self setSubView];
}
-(void)setSubView{
    
    [self setNaivTitle:@"明细"];
    
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStylePlain];
    self.tab.delegate = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    DemessageCell *cell = [tableView  dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell = [[DemessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row==0){
        
    }
    cell.time.text     =@"2017-05-16 15:23";
    cell.title.text    =@"退款成功";
    cell.payName.text  =@"支付宝";
    cell.money.text    =@"199元";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 50;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)leftFoundation{
    [self.navigationController   popViewControllerAnimated:YES];
}
-(void)sendRequest{
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"getUserRecharge",
                           
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
@end
