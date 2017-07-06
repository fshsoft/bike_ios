//
//  SetInfoVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "SetInfoVC.h"
#import "personInfoCell.h"
#import "SDImageCache.h"
#import "AboutMeVC.h"

//#import "MKAnnotationView+WebCache.h"
@interface SetInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property   (nonatomic ,strong) UITableView *tab;
@property   (nonatomic,strong)  NSMutableArray * arr;
@end

@implementation SetInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
 
    
     }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)setCount{
    //调用第三方方法
    float ImageCache = [[SDImageCache sharedImageCache]getSize]/1000/1000;
    NSString * CacheString = [NSString stringWithFormat:@"缓存大小为%.2fM.确定要清理缓存么?",ImageCache];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:CacheString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 100;
    [alert show];
}
-(void)leftFoundation{
   
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setSubview{
    [self setNaivTitle:@"设置"];
    self.view.backgroundColor =gary245;
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 120) style:UITableViewStylePlain ];
    self.tab.delegate   = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.bounces =NO;
    [self.view addSubview:self.tab];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(14, self.tab.bottom+20, SCREEN_WIDTH-28, 40)];
    [self.view addSubview:btn];
    
    btn.backgroundColor = mainColor;
    btn.titleLabel.font=FontSize(14);
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteInfo) forControlEvents:UIControlEventTouchUpInside];
}
-(void)deleteInfo{
   
    [self sendLogoutRequest];
    
}

- (void)sendLogoutRequest {
    
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"logout",
                           };
    
    [self requestType:HttpRequestTypePost
                  url:[DB getStringById:@"source_url" fromTable:tabName]
           parameters:dic
         successBlock:^(id response) {
             [DB deleteObjectById:@"phone" fromTable:tabName];
             [DB deleteObjectById:@"access_token" fromTable:tabName];
             [self.navigationController    popToRootViewControllerAnimated:YES];
       } failureBlock:^(NSError *error) {
             
         }];}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

-(NSMutableArray*)arr{
    if(!_arr){
     _arr =[NSMutableArray arrayWithObjects:@"常用地址",@"清除缓存",@"关于我们", nil];
    }
    return _arr;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *str = @"qqqqqqq";
    personInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell = [[personInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
    if(indexPath.row ==self.arr.count-1){
        cell.line.hidden =YES;
    }
    cell.title.text = self.arr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==2){
        AboutMeVC *meVC = [[AboutMeVC alloc]init];
        [self absPushViewController:meVC animated:YES];
    }else if(indexPath.row==1){
           [self setCount];
    } 
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //调用第三方方法
        [self clearTmpPics];
         }
}

//清除缓存

- (void)clearTmpPics

{
 //[[SDImageCache sharedImageCache] cleanDisk];
 [[SDImageCache sharedImageCache] clearMemory];//可有可无
    
}
@end
