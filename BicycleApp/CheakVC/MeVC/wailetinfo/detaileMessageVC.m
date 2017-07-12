//
//  detaileMessageVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "detaileMessageVC.h"
#import "DemessageCell.h"
#import "listInfoModel.h"
#import "annotionInfoModel.h"
@interface detaileMessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView   *tab ;
@property (nonatomic,strong)NSMutableArray  * array;
@end

@implementation detaileMessageVC

- (void)viewDidLoad {
    self.array   = [NSMutableArray array];
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
    return self.array.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    DemessageCell *cell = [tableView  dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell = [[DemessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    annotionInfoModel * model = self.array[indexPath.row];
    if([model.paidtype   isEqualToString:@"0"]){
        cell.payName.text  =@"支付宝";
        cell.title.text  = model.note;
        cell.money.text  = model.changed;
    }else{
        cell.payName.text  =@"微信";
        cell.title.text  = model.note;
        cell.money.text  = model.changed;
    }
    
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
             listInfoModel * model = [listInfoModel yy_modelWithJSON:response];
             if([model.errorno   isEqualToString:@"0"]){
                 [self.array addObjectsFromArray: model.data];
                 [self.tab reloadData];
             }else{
                
                 Toast(model.errmsg);

             }
             
         } failureBlock:^(NSError *error) {
             
         }];
    
}
@end
