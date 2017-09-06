//
//  XYBaseVC.m
//  CateTool
//
//  Created by 雨停 on 2016/12/18.
//  Copyright © 2016年 雨停. All rights reserved.
//

#import "XYBaseVC.h"
#import "UIView+Frame.h"
#import "UIColor+XYColor.h"
#import "LoginVC.h"
#import "UIImage+anniGIF.h"
NSString *const kName = @"Alun Chen";
@interface XYBaseVC ()
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@end

@implementation XYBaseVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dictionary:(NSDictionary *)dic {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavi];
    self.navBarHairlineImageView  = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
  
  
    
}
-(void)setNavi{
    self.navi = [[NSBundle mainBundle]loadNibNamed:@"Navi" owner:self options:nil].lastObject;
    self.navi .frame  =CGRectMake(0, 0, SCREEN_WIDTH, 64);
    self.navi.backgroundColor = mainColor;
    [self.navi.leftBtn addTarget:self action:@selector(leftFoundation) forControlEvents:UIControlEventTouchUpInside];
    [self.navi.rightBtn addTarget:self action:@selector(rightFoundation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navi];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     }
-(void)leftFoundation{
    
}
-(void)setNaivBackgroundColor :(UIColor*)color{
    self.navi.backgroundColor =color;
}
-(void)setNaivTitle:(NSString *)title{
    self.navi.title.text =title;
}
-(void)rightFoundation{
    
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    /* if (self.navigationController) {
         self.navBarHairlineImageView.hidden = YES;
//        [self.navigationController.navigationBar setBackgroundImage: Img(@"new")                                                      forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }*/
}

//视图将要消失时取消隐藏
- (void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden =NO;
   
}

- (void)setData {
    
}

- (void)setSubviews {
    
}

- (void)absPushViewController:(XYBaseVC *) controller animated:(BOOL) animated {
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:animated];
}

- (void)absRootPushViewController:(XYBaseVC *) controller animated:(BOOL) animated {
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)showPlaceholderViewWithImage:(UIImage *)image
                             message:(NSString *)message
                         buttonTitle:(NSString *)title
                       centerOffsetY:(CGFloat)centerOffsetY
                         onSuperView:(UIView *)superView {
    
    self.placeholderView = [self setPlaceholderViewWithImage:image
                                                     message:message
                                                 buttonTitle:title
                                               centerOffsetY:centerOffsetY];
    self.placeholderView.hidden = NO;
    [superView addSubview:self.placeholderView];
}

- (UIView *)setPlaceholderViewWithImage:(UIImage *)image
                                message:(NSString *)message
                            buttonTitle:(NSString *)title
                          centerOffsetY:(CGFloat)centerOffsetY {
    
    UIView *placeholderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    //centerOffsetY = centerOffsetY ? centerOffsetY : 64;
    placeholderView.center = CGPointMake(self.view.center.x, self.view.center.y-centerOffsetY);
    
    CGFloat imageVX = (placeholderView.frame.size.width - image.size.width)/2;
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(imageVX, 20, image.size.width, image.size.height)];
    imageV.image = image;
    [placeholderView addSubview:imageV];
    
    CGFloat msgLabW = 240;
    CGFloat msgLabX = (placeholderView.frame.size.width - msgLabW)/2;
    UILabel *msgLab = [[UILabel alloc]initWithFrame:CGRectMake(msgLabX, imageV.bottom + 5, msgLabW, 48)];
    msgLab.text = message;
    msgLab.font =  FontSize(14);
    msgLab.numberOfLines = 0;
    msgLab.textAlignment = NSTextAlignmentCenter;
    msgLab.textColor =gary153;
    [placeholderView addSubview:msgLab];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(msgLabX, msgLab.bottom + 15, msgLabW, 50)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button setBackgroundColor:[UIColor colorWithHexString:@"#4D4D4D"]];
    button.titleLabel.font =  FontBold(16);
    [button addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = title.length ? NO : YES;
    [placeholderView addSubview:button];
    placeholderView.hidden = YES;
    self.placeholderView = placeholderView;
    return self.placeholderView;
}

- (void)updatePlaceholderView {
    
    if (self.placeholderView.hidden == NO) {
        [self.placeholderView removeFromSuperview];
    }
}

- (void)playBtnClick {
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)setNavLeftItemTitle:(NSString *)str andImage:(UIImage *)image {
    if ([self.navigationController.viewControllers count] ==1){
        if ([str isEqualToString:@""] || !str)
        {
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
        else
        {
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
    }
}

- (void)setNavRightItemTitle:(NSString *)str andImage:(UIImage *)image
{
    if ([str isEqualToString:@""] || !str)
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    else
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        [rightItem setTintColor:[UIColor colorWithHexString:@"#4D4D4D"]];
        [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)rightItemClick:(id)sender {
    
}

- (void)leftItemClick:(id)sender{
    
}

- (void)setBackBarButtonItem {
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc] init];
    UIButton *btnleftView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    btnleftView.imageEdgeInsets =UIEdgeInsetsMake(0, -30, 0, 0);
    
    if ([self.navigationController.viewControllers count] > 1) {
        
        [btnleftView setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btnleftView setContentMode:UIViewContentModeScaleAspectFit];
        [backItem  setCustomView:btnleftView];
        [btnleftView addTarget:self action:@selector(absPopNav) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
}

- (void)absPopNav {
    BOOL animated = YES;
    
    if (self.navigationController.viewControllers.count == 2) {
        animated = NO;
    }
    [self.navigationController popViewControllerAnimated:animated];
}

-(void)loadNewData {
    
}

-(void)loadMoreData {
    
}

//- (void)startLoading {
//    self.view.userInteractionEnabled =NO;
//    CGFloat navH = self.navigationController.navigationBar.hidden ? 64 : 0;;
//    UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
//    loadingView.center = CGPointMake(self.view.center.x, self.view.center.y-64+navH);
//    loadingView.backgroundColor = [UIColor clearColor];
//    
//    CGFloat imgVWidth = 60.f;
//    CGFloat imgVX     = (120-imgVWidth)/2.f;
//    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
//    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(imgVX, imgVX, imgVWidth, imgVWidth)];
//    imageV.image = [UIImage sd_animatGIFWithData:gif];
//    [loadingView addSubview:imageV];
//    [self.view addSubview:loadingView];
//    self.loadingView = loadingView;
//
//}
- (void)startLoading {
   
   // CGFloat navH = self.navigationController.navigationBar.hidden ? 64 : 0;;
    UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64)];
 
    loadingView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2];
    loadingView.backgroundColor = [UIColor clearColor];
    
    CGFloat imgVWidth = 45.f;
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imgVWidth, imgVWidth)];
    imageV.center=CGPointMake(loadingView.center.x, loadingView.center.y-64);
    imageV.image = [UIImage sd_animatGIFWithData:gif];
    [loadingView addSubview:imageV];
   [self.view addSubview:loadingView];
    
    self.loadingView = loadingView;
    
}

- (void)endLoading {
   // self.view.userInteractionEnabled = YES;
    self.loadingView.hidden = YES;
}

- (void)updateLoading {
    if (self.loadingView.hidden == NO) {
        [self endLoading];
        [self startLoading];
    } else {
        self.loadingView.hidden = NO;
        [self endLoading];
        [self startLoading];
    }
}

- (BOOL)isLogin {
//    ABSUserModel *user = [ABSUserSession getUserModel];
//    if (user.Auth || user.PSP_CODE) {
//        return YES;
//    }
//    ABSLoginVC *loginVC = [[ABSLoginVC alloc]init];
//    loginVC.hidesBottomBarWhenPushed = YES;
//    [self presentViewController:loginVC animated:YES completion:nil];
   return NO;
}




- (float)getTextWidth:(float)textHeight text:(NSString *)text font:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    float origin = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
    return ceilf(origin);
}

- (float)getTextHeight:(float)textWidth text:(NSString *)text font:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    float origin = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.height;
    return ceilf(origin);
}
-(void)refreshPassWordToken{

    NSString *refreshtoken =@"";
    
    if(  [ DB getStringById:@"refresh_token" fromTable:tabName]){
        
        refreshtoken= [DB getStringById:@"refresh_token" fromTable:tabName];
        
        NSDictionary *dic = @{
                              @"client_id"    :@"ios",
                              @"client_secret":@"789",
                              @"grant_type":@"refresh_token",
                              @"scope":@"all",
                              @"refresh_token":refreshtoken
                              };
        //   [self getCLLocationCoordinateInfo];
        [RequestManager  requestWithType:HttpRequestTypePost urlString: url(@"oauth2/access_token") parameters:dic successBlock:^(id response) {
            NSLog(@"===============%@",response);
            //[DB putString: [response objectForKey:@"access_token"] withId:@"password_token" intoTable:tabName];
            
            //[DB putString: [response objectForKey:@"refresh_token"] withId:@"refresh_token" intoTable:tabName];
        } failureBlock:^(NSError *error) {
            
        } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];

    }else{
        [self refreshClientCredentialsToken];
    }
    

}
-(void)requestType:(HttpRequestType)type
               url:(NSString *)url
        parameters:(NSDictionary *)parm
      successBlock:(RequestSuccess)success failureBlock:(RequestFail)failure{

    
    
    
    NSMutableDictionary  * dic =[NSMutableDictionary    dictionaryWithDictionary:parm];
    
    [ dic addEntriesFromDictionary:@{
                                     @"client_id" : [DB getStringById:@"app_key" fromTable:tabName],
                                     @"state" : [DB getStringById:@"seed_secret" fromTable:tabName],
                                     @"access_token" :[DB getStringById:@"access_token" fromTable:tabName],
                                     }];
    
    [RequestManager requestWithType:type
                          urlString:[DB getStringById:@"source_url" fromTable:tabName]
                         parameters:dic
                       successBlock:^(id response) {
                           if(success){
                          
                               BaseModel * model = [BaseModel yy_modelWithDictionary:response];
//                               DLog(@"%@",model);
//                               NSLog(@"%@",response);
//                               DLog(@"%@",model.errmsg);
//                               DLog(@"%@",model.message);
                               if(![model.errorno isEqualToString:@"0"]){
                                  
                               }
                               success(model);
                           }
                           
                       }
     
                       failureBlock:^(NSError *error) {
                           if(failure){
                               
                            failure(error);
                           }
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
}
-(void)refreshClientCredentialsToken{
    NSDictionary *dic = @{
                          @"client_id"    :@"ios",
                          @"client_secret":@"789",
                          @"grant_type":@"client_credentials",
                          @"scope":@"all"
                          };
    [RequestManager  requestWithType:HttpRequestTypePost
                           urlString:url(@"oauth2/access_token")
                          parameters:dic
                        successBlock:^(id response) {
                            
                            NSLog(@"===============%@",response);
                            
                           // [DB putString: [response objectForKey:@"access_token"]
                              //     withId:@"client_credentials_token"
                              //  intoTable:tabName];
                        }
                        failureBlock:^(NSError *error) {
                            
                        }
                            progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                                
                            }];
    
    
}
 @end
