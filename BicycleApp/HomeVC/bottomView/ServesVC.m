//
//  ServesVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/24.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "ServesVC.h"
#import "personInfoCell.h"
#import "ServeVC.h"
@interface ServesVC ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)NSMutableArray * arr;
@end

@implementation ServesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSub];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSub{
    [self setNaivTitle:@"客户服务"];
    
    self.tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStylePlain];
    self.tab.delegate = self;
    
    
    self.tab.dataSource = self;
    self.tab.bounces =NO ;
    
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tab];
}
-(NSMutableArray*)arr{
    if(!_arr){
        
            _arr =[NSMutableArray arrayWithObjects:@"注册与账户",@"预约，开关锁问题 ",@"押金与车费",@"还车相关", nil];
    }
    return _arr;
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}


 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

# pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"personInfoCell";
    personInfoCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[personInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
                cell.title.text =self.arr[indexPath.row];
        
    
        if(indexPath.row ==self.arr.count-1){
            
            cell.line.hidden=YES;
        }
    
    
    
    return cell;
}
 


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Toast(@"建设中");
    if(indexPath.section==0){
        
        ServeVC *vc = [[ServeVC alloc]init];
        vc.navTitle=self.arr[indexPath.row];
        [self absPushViewController:vc animated:YES];
        if(indexPath.row==0){
            
            
        }else if(indexPath.row==1){
            
        }else if (indexPath.row==2){
        }
            
    }
   }

@end
