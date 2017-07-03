//
//  consumerVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/24.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "consumerVC.h"
#import "personInfoCell.h"
#import "ServeVC.h"
@interface consumerVC ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)NSMutableArray * arr;
@end

@implementation consumerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSub];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSub{
    [self setNaivTitle:@"用户指南"];
 
    self.tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tab.delegate = self;
    
    
    self.tab.dataSource = self;
    self.tab.bounces =NO ;
    
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tab];
}
-(NSMutableArray*)arr{
    if(!_arr){
        NSArray *arr1 =[NSArray arrayWithObjects:@"开不了锁",@"发现车辆故障",@"押金说明",@"充值说明", nil];
        NSArray *arr2 =[NSArray arrayWithObjects:@"其他问题", nil];
        _arr =[NSMutableArray arrayWithObjects:arr1,arr2, nil];
    }
    return _arr;
}
     -(void)leftFoundation{
         [self.navigationController popViewControllerAnimated:YES];
     }
     
         # pragma mark - UITableViewDataSource
     - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
         return self.arr.count;
         
     }
     
     - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
         if (section==0) {
             NSArray *arr =self.arr[0];
             return  arr.count;
         }else if(section==1){
             NSArray *arr =self.arr[1];
             return  arr.count;
         }
         return 0;
     }
     
     
# pragma mark - UITableViewDelegate
     - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
         
         static NSString *cellIndentifier = @"personInfoCell";
         personInfoCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
         if (cell == nil) {
             cell = [[personInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
         }
         if(indexPath.section ==0){
             NSArray *arr=self.arr[indexPath.section];
             cell.title.text =arr[indexPath.row];
                          
         }else if(indexPath.section==1){
             NSArray *arr=self.arr[indexPath.section];
             cell.title.text =arr[indexPath.row];
             if(indexPath.row ==arr.count-1){
                 
                 cell.line.hidden=YES;
             }
         }
         
         
         return cell;
     }
     -(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
         return 0.001;
     }
     -(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
         
         return 10;
     }
     - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
         
         if(indexPath.section==0){
             ServeVC *vc = [[ServeVC alloc]init];
             NSArray *arr =self.arr[0];
             vc.navTitle=arr[indexPath.row];
             [self absPushViewController:vc animated:YES];
             if(indexPath.row==0){
                
                 
             }else if(indexPath.row==1){
                 
             }else if (indexPath.row==2){
                 
                 
             }
             
         }else if(indexPath.section==1){
             ServeVC *vc = [[ServeVC alloc]init];
             NSArray *arr =self.arr[1];
             vc.navTitle=arr[indexPath.row];
             [self absPushViewController:vc animated:YES];

             
             
         }}

@end
