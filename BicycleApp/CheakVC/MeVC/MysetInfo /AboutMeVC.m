//
//  AboutMeVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AboutMeVC.h"
#import "AboutMeCell.h"
@interface AboutMeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tab ;
@property   (nonatomic,strong)  NSMutableArray * arr;
@end

@implementation AboutMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
    [self setbottomView];
    }
-(void)setbottomView{
    UILabel  *lab =[[UILabel alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT-60, SCREEN_WIDTH, 13)];
    lab.text = @"Copyright©2014-2046";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = FontSize(12);
    [self.view addSubview: lab];
    UILabel  *labbottom =[[UILabel alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT-34, SCREEN_WIDTH, 17)];
    labbottom.text = @"乐享科技有限公司";
    labbottom.textAlignment = NSTextAlignmentCenter;
    labbottom.font = FontSize(14);
    [self.view addSubview:labbottom];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     }
-(void)setSubView{
    self.view.backgroundColor = gary245;
    [self setNaivTitle:@"关于我们"];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 324) style:UITableViewStylePlain ];
    self.tab.delegate   = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.bounces =NO;
    self.tab.tableHeaderView = [self headView];
    [self.view addSubview:self.tab];

    
}
-(UIView*)headView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    view .backgroundColor =gary245;
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5-30, 40, 60, 60)];
   
 
    logo.image =[UIImage imageNamed:@"logo"];

    logo.layer.cornerRadius=10;
    logo.layer.masksToBounds =YES;
       [view addSubview:logo];
    UILabel *labTitle  = [[UILabel alloc]initWithFrame:CGRectMake(0, logo.bottom+10, SCREEN_WIDTH, 20)];
    labTitle.textAlignment  = NSTextAlignmentCenter;
    labTitle.font = FontSize(14);
    labTitle.text = @"乐享单车";
    
    [view addSubview:labTitle];
    UILabel *labNum  = [[UILabel alloc]initWithFrame:CGRectMake(0, labTitle.bottom, SCREEN_WIDTH, 20)];
    labNum.textAlignment  = NSTextAlignmentCenter;
    labNum.font = FontSize(12);
    labNum.text =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [view addSubview:labNum];

    view .backgroundColor =gary245;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(NSMutableArray*)arr{
    
    if(!_arr){
        _arr =[NSMutableArray arrayWithObjects:@{@"title":@"微信公众号",@"content":@"leShearBike"},@{@"title":@"联系电话",@"content":@"021-55698974"},@{@"title":@"电子邮箱",@"content":@"admin@shnow.cn"},@{@"title":@"官方网站",@"content":@"http://leshear.shnow.cn"} ,nil];
    }
    return _arr;
}

-(void)leftFoundation{
    [self.navigationController  popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"str";
    AboutMeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell = [[AboutMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dic  = self.arr[indexPath.row];
    cell.left.text =[dic objectForKey:@"title"];
    cell.right.text = [dic objectForKey:@"content"];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dic  = self.arr[indexPath.row];
    if(indexPath.row==0){
        
    }else if(indexPath.row==1){
         [[UIApplication  sharedApplication] openURL:[NSURL  URLWithString:  [NSString stringWithFormat:@"tel://%@",[dic objectForKey:@"content"]]]];
    }else if(indexPath.row==2){
         [[UIApplication  sharedApplication] openURL:[NSURL  URLWithString:  [NSString stringWithFormat:@"mailto://%@",[dic objectForKey:@"content"]]]];
    }else if(indexPath.row==3){
        [[UIApplication  sharedApplication] openURL:[NSURL  URLWithString:[dic objectForKey:@"content"]]];
    }
}
@end
