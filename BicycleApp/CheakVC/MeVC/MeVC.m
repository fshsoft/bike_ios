//
//  MeVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/8.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "MeVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "personInfo.h"
#import "personInfoCell.h"
#import "CertifyTopView.h"
#import "ShearVC.h"
#import "SportDetailView.h"
#import "MywalletVC.h"
#import "preferentialVC.h"
#import "travelVC.h"
#import "inviteVC.h"
#import "messageVC.h"
#import "SetInfoVC.h"
#import "SocerVC.h"
#import "consumerVC.h"
#import "personModel.h"
#import "listInfoModel.h"
#import "annotionInfoModel.h"
#import "appInfoModel.h"

@interface MeVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong)UIButton     * personPhoto;
@property (nonatomic,strong)UILabel      *  personName;
@property (nonatomic,strong)UITableView  * personalTableV;
@property (nonatomic,strong)NSMutableArray * arr;
@property (nonatomic,strong)UIButton  *  promiseBtn;
@property (nonatomic,strong)UIView    *  viewInfoCheak;
@property (nonatomic,strong)CertifyTopView * bottomView;
@property (nonatomic,strong)SportDetailView * SbottomView;
@property (nonatomic,strong)NSString      * price;

@end

@implementation MeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    

     [self initUI];
    //[self startLoading];
    // Do any additional setup after loading the view.
}
-(NSMutableArray*)arr{
    if(!_arr){
        NSArray *arr1 =[NSArray arrayWithObjects:@"我的钱包",@"我的优惠",@"我的行程", nil];
        NSArray *arr2 =[NSArray arrayWithObjects:@"我的消息",@"邀请好友",@"用户指南",@"设置", nil];
        _arr =[NSMutableArray arrayWithObjects:arr1,arr2, nil];
    }
    return _arr;
}
  - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)initUI{
    
    [self setNaivTitle:@"个人中心"];
    self.navi.backgroundColor =gary153;
    self.personalTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStyleGrouped];
    self.personalTableV.delegate = self;
  
 
    self.personalTableV.dataSource = self;
    self.personalTableV.bounces =NO ;
    
    self.personalTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.personalTableV];
    
    self.personalTableV.tableHeaderView = [self obtainHeaderView];
    
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)obtainHeaderView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.3*SCREEN_WIDTH +185)];
   
    headerView.backgroundColor = gary153;
    
    
    UIButton *personPhoto = [[UIButton alloc]init];
    
    [headerView addSubview:personPhoto];
 
    self.personPhoto = personPhoto;
    [personPhoto.layer setCornerRadius:0.15*SCREEN_WIDTH];
    personPhoto.layer.masksToBounds = YES;

    [self.personPhoto setBackgroundImage :Img(@"toux.png") forState:UIControlStateNormal];
    [personPhoto addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchDown];
    [personPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.3*SCREEN_WIDTH, 0.3*SCREEN_WIDTH));
        make.centerX.equalTo(headerView);
        make.top.mas_equalTo(headerView.mas_top).with.offset(10);
    }];
   
    UIImageView  * icon = [[UIImageView alloc]initWithImage:Img(@"ziliaoxg")];
    icon.frame = CGRectMake(0.65*SCREEN_WIDTH-25, 0.3*SCREEN_WIDTH-13, 23, 23);
    [headerView addSubview: icon];
   
    UILabel *personName = [[UILabel alloc]init];
    [headerView addSubview:personName];
    self.personName =personName ;
    personName.font =FontSize(12);
    personName.textColor = [UIColor whiteColor];
    personName.textAlignment = NSTextAlignmentCenter   ;
    [personName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.centerX.equalTo(headerView);
        make.top.equalTo(personPhoto.mas_bottom).with.offset(10);
        make.width.equalTo(@SCREEN_WIDTH);
    }];
    
    self.promiseBtn = [[UIButton alloc]init];
     [headerView addSubview:self.promiseBtn];
    [self.promiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(106, 23));
        make.centerX.equalTo(headerView);
        make.top.equalTo(personName.mas_bottom).with.offset(10);
    }];
    self.promiseBtn.layer.cornerRadius=10;
    self.promiseBtn.layer.masksToBounds =YES;
    [self.promiseBtn setBackgroundImage :Img(@"btn_xyfen") forState:UIControlStateNormal];
    [self.promiseBtn setTitle:@"信用积分 100" forState:UIControlStateNormal];
    self.promiseBtn.titleLabel.font =FontSize(11);
    [self.promiseBtn addTarget:self action:@selector(getSocer) forControlEvents:UIControlEventTouchUpInside];
    self.viewInfoCheak = [[UIView alloc]initWithFrame:CGRectMake(0,  0.3*SCREEN_WIDTH+75, SCREEN_WIDTH, 110)];
    self.viewInfoCheak.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.viewInfoCheak];
    
    self.bottomView  = [[NSBundle mainBundle]loadNibNamed:@"CerifyTop" owner:self options:nil].lastObject;
    self.bottomView.frame =CGRectMake(0, 0, SCREEN_WIDTH, 110);
    self.bottomView.firstImg.contentMode =UIViewContentModeScaleAspectFit;

    
  

   [self.viewInfoCheak addSubview:self.bottomView];
    
    self.SbottomView = [[NSBundle mainBundle]loadNibNamed:@"SportDetail" owner:self options:nil].lastObject;
    self.SbottomView.frame =CGRectMake(0, 0, SCREEN_WIDTH, 110);
  
    
    
    UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    labTitle.font = FontSize(14);
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.text =@"完成实名认证即可立即开始用车";
    [self.bottomView addSubview:labTitle];

    return headerView;
    
    
}
-(void)getSocer{
    SocerVC *vc  = [[SocerVC alloc]init];
    [self absPushViewController:vc  animated:YES];
}
-(void)getPhoto :(UIButton *)sender{
    personInfo   *per  =[[personInfo alloc]init];
    
    __block MeVC  *selfblock=self;
    per.block= ^(UIImage *image ){
        
        
        [selfblock.personPhoto setBackgroundImage:image forState:UIControlStateNormal ];
        
    };
    
    [self.navigationController pushViewController:per animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(![[DB getStringById:@"money" fromTable:tabName] isEqualToString:@"1"]){
            self.bottomView.tag=1;
    }else{
   if(![[DB getStringById:@"certify" fromTable:tabName] isEqualToString:@"1"]){
              self.bottomView.tag=2;
   }else{
          [self.bottomView  removeFromSuperview ];
          [self.viewInfoCheak addSubview:self.SbottomView];
       [self sendRequest];
   }
        }

    
    
   
    if(  [ DB getStringById:@"name" fromTable:tabName]){
        self.personName.text = [DB getStringById:@"name" fromTable:tabName];
    }else{
        self.personName.text =@"小樱单车";
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    //设置一个图片的存储路径
    NSString *imagePath = [path stringByAppendingString:@"/pic.png"];
    if([UIImage imageWithContentsOfFile:imagePath]!=nil){
    [self.personPhoto setImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
    }
}
-(void)sendRequest{
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"getUserInfo",
                           
                           };
    
    [self requestType:HttpRequestTypePost
                  url:[DB getStringById:@"source_url" fromTable:tabName]
     
           parameters:dic
         successBlock:^(id response) {
             BaseModel * model = [BaseModel yy_modelWithJSON:response];
             appInfoModel * appInfo = model.data;
            // NSLog(@"%@==%@",appInfo.nickname,appInfo.truename);
             [DB putString: appInfo.nickname withId:@"name" intoTable:tabName];
             [DB putString: appInfo.truename withId:@"truename" intoTable:tabName];
             [DB putString:appInfo.balance withId:@"balance" intoTable:tabName];
             self.price = appInfo.balance;
             [self.promiseBtn setTitle:[NSString stringWithFormat:@"信用积分 %@",appInfo.integral] forState:UIControlStateNormal];
             
             [self.personalTableV reloadData];
         } failureBlock:^(NSError *error) {
             
         }];

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
        if(indexPath.row==0){
            cell.detailtitle.text=self.price;
            
        }else if(indexPath.row==arr.count-1){
            cell.line.hidden=YES;
        }

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
    if(indexPath.row==0){
        MywalletVC *wallet = [[MywalletVC alloc]init];
        [self absPushViewController:wallet animated:YES];
        
    }else if(indexPath.row==1){
        preferentialVC *vc = [[preferentialVC alloc]init];
        [self absPushViewController:vc animated:YES];
    }else if (indexPath.row==2){
        travelVC *trave = [[travelVC alloc]init];
        [self absPushViewController:trave animated:YES];
        
    }

    }else if(indexPath.section==1){
        if(indexPath.row==3)
           {
               SetInfoVC *set = [[SetInfoVC alloc]init];
               [self absPushViewController:set animated:YES];
           }
        else if(indexPath.row==1)
           {
            inviteVC *invite = [[inviteVC alloc]init];
            [self absPushViewController:invite animated:YES];
           }else if(indexPath.row==0)
           {
               messageVC *message = [[messageVC alloc]init];
               [self absPushViewController:message animated:YES];
               
           }else if(indexPath.row==2){
               consumerVC *vc  = [[consumerVC alloc]init];
               [self absPushViewController:vc animated:YES];
           }
       }
   }
# pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    }


@end


