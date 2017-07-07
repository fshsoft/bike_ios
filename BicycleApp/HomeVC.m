
//
//  ViewController.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/3.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "HomeVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "CommonUtility.h"
#import "MANaviRoute.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "CheakViewController.h"
#import "MeVC.h"
#import "PaySelect.h"
#import "LoginVC.h"
#import "HomeBottomView.h"
#import "HomeHelpView.h"
#import "HomeTopCheakView.h"
#import "ReGeocodeAnnotation.h"
#import "startAnnotationView.h"
#import "shouTitleAnnotation.h"
#import "certifyPersonInfoVC.h"
#import "HomeNaviView.h"
#import "activityView.h"
#import "messageVC.h"
#import "LockVC.h"
#import "StopVC.h"
#import "ServesVC.h"
#import "breakDownVC.h"
#import "SearchDisPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIColor+XYColor.h"
#import "CustomAnnotationView.h"
#import "dataModel.h"
#import "annotionInfoModel.h"
#import "ZKUDID.h"
#import "CusMD5.h"
#import "appInfoModel.h"
#import "certifyPersonInfoVC.h"
#import "paymentVC.h"
#import "listInfoModel.h"

static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                   = 20;

@interface HomeVC ()<AMapSearchDelegate,MAMapViewDelegate,AMapLocationManagerDelegate>

@property (nonatomic,strong)MAMapView * mapView ;

@property (nonatomic,strong)AMapSearchAPI *search;

@property (nonatomic, strong) NSMutableArray *annotations;


@property (nonatomic, strong) AMapRoute *route;

/* 当前路线方案索引值. */
@property (nonatomic) NSInteger currentCourse;
/* 路线方案个数. */
@property (nonatomic) NSInteger totalCourse;

@property (nonatomic ,assign)NSInteger tag;

/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;

@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *endAnnotation;
@property (nonatomic, strong) MAPointAnnotation *changeAnnotation;

@property (nonatomic,strong)  AMapLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D   MyCoordinate;


@property (nonatomic, strong) UIButton     *    mapCenter;
@property (nonatomic, strong) UIButton     *    heleCenter;
@property (nonatomic, strong) HomeHelpView *    animationView ;
@property (nonatomic,strong)  UIView       *    backView;
@property (nonatomic,strong)  HomeTopCheakView * topCheakView;

@property (nonatomic) CLLocationCoordinate2D  centerCoordinate;
@property (nonatomic,strong) UIImageView  * centerImage;
@property (nonatomic,strong) HomeNaviView *homeNaiv;
@property (nonatomic,strong) activityView *actView;
@property (nonatomic,assign) NSInteger    paopaoTag;

@end

@implementation HomeVC
- (void)viewDidLoad {
   
    [self getInfo];
    NSLog(@"%@",kName);
    [self cheakToken];
    [self initMapInfoDetaile];
   // [self.mapView clearDisk];
    [self cheakMap];
 
    self.tag = 1;
    self.paopaoTag = 1;
    [self setHomeNaviView];
    [super viewDidLoad];
    self.navi.hidden=YES;
    [self getLocationInfo];
    [self setMapSubview];
    [self setTopCheakview];
    [self setSearchMapPath];
    [self setBottomSubview];
    [self setNavLeftItemTitle:nil andImage:Img(@"catage")];
   
       //[self startLoading];
    }
#pragma mark 初始化地图所需数据
-(void)initMapInfoDetaile{
    self.annotations = [NSMutableArray array];
    self.changeAnnotation = [[MAPointAnnotation alloc]init];
    self.startAnnotation  = [[MAPointAnnotation alloc] init];
    self.endAnnotation    = [[MAPointAnnotation alloc] init];
    self.changeAnnotation.lockedScreenPoint = CGPointMake(self.view.frame.size.width/2.0,(self.view.frame.size.height-64)/2.0);
    self.changeAnnotation.lockedToScreen = YES;
    self.changeAnnotation.title =@"11111111";

}
#pragma mark token获取
-(void)cheakToken{
    if(!refressh_access_token){
     
        [self getInfo];
     
 }
}

-(void)getInfo{
    [ZKUDID setDebug:YES];   // default is NO.
    NSString *UDID = [ZKUDID value];
   
    NSLog(@"UDID: %@",UDID);

    NSString *strEnRes = [CusMD5 md5String:UDID];
     NSLog(@"strEnRes: %@",strEnRes);
    [RequestManager requestWithType:HttpRequestTypePost urlString:@"http://partner.baibaobike.com/authed/register.html" parameters:@{@"imei":UDID,@"code":strEnRes} successBlock:^(id response) {
    NSLog(@"response==%@",response);
        BaseModel  * model = [BaseModel yy_modelWithJSON: response];
        appInfoModel    * appinfomodel = model.data;
        
        [DB putString:appinfomodel.app_key       withId:@"app_key"      intoTable:tabName];
        [DB putString:appinfomodel.app_secret    withId:@"app_secret"   intoTable:tabName];
        [DB putString:appinfomodel.refresh_url   withId:@"refrsh_url"   intoTable:tabName];
        [DB putString:appinfomodel.seed_secret   withId:@"seed_secret"  intoTable:tabName];
        [DB putString:appinfomodel.source_url    withId:@"source_url"   intoTable:tabName];
        [DB putString:appinfomodel.token_url     withId:@"token_url"    intoTable:tabName];
        [DB putString:appinfomodel.authorize_url withId:@"authorize_url" intoTable:tabName];
[RequestManager requestWithType:HttpRequestTypePost
                      urlString:[DB getStringById:@"authorize_url" fromTable:tabName]
                     parameters:
          @{
           @"response_type" :@"code",
           @"client_id"     :[DB getStringById:@"app_key" fromTable:tabName],
           @"state"         :[DB getStringById:@"seed_secret" fromTable:tabName]
                                                         
                                                         }
                successBlock:^(id response) {
                    
              [DB putString:[[response objectForKey:@"data"] objectForKey:@"authorize_code"]withId:@"authorize_code" intoTable:tabName];
[RequestManager requestWithType:HttpRequestTypePost
                      urlString:[DB getStringById:@"token_url" fromTable:tabName]
                     parameters:@{
                                                                 
              @"client_id"     :[DB getStringById:@"app_key" fromTable:tabName],
              @"client_secret" :[DB getStringById:@"app_secret" fromTable:tabName],
              @"grant_type"    :@"authorization_code",
              @"code"          :[DB getStringById:@"authorize_code" fromTable:tabName],
              @"state"         :[DB getStringById:@"seed_secret" fromTable:tabName]
                                                                 }
                  successBlock:^(id response) {
                                                    
                BaseModel    * model    = [BaseModel yy_modelWithJSON:response];
                appInfoModel * appmodel = model.data;
                [DB putString: appmodel.refresh_token withId:@"refresh_token"   intoTable:tabName];
                [DB putString: appmodel.access_token  withId: @"access_token"  intoTable:tabName];
                                                      
                } failureBlock:^(NSError *error) {
                                                      
                    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                                                      }];

                           }
                           failureBlock:^(NSError *error) {
                               
                           } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                               
                    }];

              } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
   }
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // [self setActivityView];
    PaySelect    * pay =[[PaySelect alloc]init];
    //[pay doAlipayPay];
   }
#pragma mark 持续定位
 -(void)getLocationInfo{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter =100;
     //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
     //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
         self.locationManager.allowsBackgroundLocationUpdates = YES;
     }
     //开始持续定位
     [self.locationManager startUpdatingLocation];
}
#pragma mark nav视图
 -(void)setHomeNaviView{
    self.homeNaiv = [[NSBundle mainBundle]loadNibNamed:@"HomeNaiv" owner:self options:nil].lastObject;
    self.homeNaiv.frame  =CGRectMake(0, 0, SCREEN_WIDTH, 64);
    __block HomeVC *weakSelf = self;
    self.homeNaiv.leftBlock = ^{
        
        if( !TelNumber){
            [weakSelf cheakToken];
            LoginVC *loginVC = [[LoginVC alloc]init];
            [weakSelf  absPushViewController:loginVC animated:YES];
            
            return;
        }
//        else{
//            if(![[DB getStringById:@"money" fromTable:tabName] isEqualToString:@"1"]){
//                paymentVC * vc = [[paymentVC alloc]init];
//                [weakSelf absPushViewController:vc animated:YES];
//            }else{
//                if(![[DB getStringById:@"certify" fromTable:tabName] isEqualToString:@"1"]){
//                    certifyPersonInfoVC * vc = [[certifyPersonInfoVC alloc]init];
//                    [weakSelf absPushViewController:vc animated:YES];
//
//                }
                else{
                    MeVC * me  = [[MeVC alloc]init];
                    [weakSelf.navigationController pushViewController:me animated:YES ];
             //   }
            //  }
        }

        };
     self.homeNaiv.mesBlock = ^{
         if( !TelNumber){
             [weakSelf cheakToken];
             LoginVC *loginVC = [[LoginVC alloc]init];
             [weakSelf  absPushViewController:loginVC animated:YES];
             
             return;
         }else{
             if(![[DB getStringById:@"money" fromTable:tabName] isEqualToString:@"1"]){
                 paymentVC * vc = [[paymentVC alloc]init];
                 [weakSelf absPushViewController:vc animated:YES];
             }else{
                 if(![[DB getStringById:@"certify" fromTable:tabName] isEqualToString:@"1"]){
                     certifyPersonInfoVC * vc = [[certifyPersonInfoVC alloc]init];
                     [weakSelf absPushViewController:vc animated:YES];
                     
                 }else{
                     messageVC *message = [[messageVC alloc]init];
                     [weakSelf absPushViewController:message animated:YES];
                 }
             }
         }
      
     };
     
     self.homeNaiv.searchBlock = ^{
         SearchDisPlayerController *vc = [[UIStoryboard storyboardWithName:@"search" bundle:nil]instantiateViewControllerWithIdentifier:@"SearchDisPlayerController"];
         [weakSelf presentViewController:vc animated:YES completion:nil];
     };
    [self.view addSubview:self.homeNaiv];
    
}
#pragma mark 活动
-(void)setActivityView{
    self.actView  = [[NSBundle mainBundle]loadNibNamed:@"activity" owner:self options:nil].lastObject;
    self.actView.frame = CGRectMake(10, 82, SCREEN_WIDTH-20, 50);
    //[self.view addSubview:self.actView];
}

/*- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
}

- (void)addCircleReionForCoordinate:(CLLocationCoordinate2D)coordinate
{
    int radius = 250;
    
    //创建circleRegion
    AMapLocationCircleRegion *cirRegion = [[AMapLocationCircleRegion alloc] initWithCenter:coordinate
                                                                                    radius:radius
                                                                                identifier:@"circleRegion"];
    
    //添加地理围栏
    [self.locationManager startMonitoringForRegion:cirRegion];
    
    //保存地理围栏
    //[self.regions addObject:cirRegion];
    
    //添加Overlay
    MACircle *circle = [MACircle circleWithCenterCoordinate:coordinate radius:radius];
    [self.mapView addOverlay:circle];
    [self.mapView setVisibleMapRect:circle.boundingMapRect];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didStartMonitoringForRegion:(AMapLocationRegion *)region
{
    NSLog(@"开始监听地理围栏:%@", region);
}

- (void)amapLocationManager:(AMapLocationManager *)manager monitoringDidFailForRegion:(AMapLocationRegion *)region withError:(NSError *)error
{
    NSLog(@"监听地理围栏失败:%@", error.localizedDescription);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didEnterRegion:(AMapLocationRegion *)region
{
    NSLog(@"进入地理围栏:%@", region);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didExitRegion:(AMapLocationRegion *)region
{
    NSLog(@"退出地理围栏:%@", region);
}*/

#pragma mark 定位代理事件
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    self.startAnnotation.coordinate    = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    self.mapView.centerCoordinate = location.coordinate;
    self.MyCoordinate=location.coordinate;
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
 
   [self getLocationManagerAnnotationLat:location.coordinate.latitude Lng:location.coordinate.longitude];
   // [self getCLLocationCoordinateInfo];
    NSLog(@"%@",reGeocode.city);
}
#pragma mark 获取标注
-(void)getLocationManagerAnnotationLat:(float)lat Lng:(float)lng{
    NSDictionary  *dic = @{
                           
                           @"client_id":   [DB getStringById:@"app_key" fromTable:tabName],
                           @"state":       [DB getStringById:@"seed_secret" fromTable:tabName],
                           @"access_token":[DB getStringById:@"access_token" fromTable:tabName],
                           @"action":      @"searchBikes",
                           @"lat"   : [NSString stringWithFormat:@"%f", lat ],
                           @"lng"   : [NSString stringWithFormat:@"%f",  lng ]
                           };
    
    [self requestType:HttpRequestTypePost
                  url:[DB getStringById:@"source_url" fromTable:tabName]
     
           parameters:dic
         successBlock:^(id response) {
             NSLog(@"response====%@",response);
            listInfoModel* model = [listInfoModel yy_modelWithJSON:response];
    if(model.data.count>0){
                 self.paopaoTag=1;
                 [self.mapView removeAnnotations:self.annotations];
                 [self.annotations removeAllObjects ];
                 self.changeAnnotation.lockedScreenPoint = CGPointMake(self.view.frame.size.width/2.0,(self.view.frame.size.height-64)/2.0);
                 //self.changeAnnotation.lockedToScreen = YES;
                 self.changeAnnotation.title =@"11111111";
                 [self.annotations addObject:self.changeAnnotation];
                 for(int i=0;i<model.data.count;i++){
                   annotionInfoModel * infomodel =  model.data[i];
                     MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
                     a1.coordinate=CLLocationCoordinate2DMake( infomodel.lat,infomodel.lng  );
                     NSLog(@"lat====%flng====%f",infomodel.lat,infomodel.lng);
                     //a1.title      = [NSString stringWithFormat:@"anno: %d", annotioninfo.id];
                     if(i==0){
                         a1.subtitle      = @"离我最近";
                         
                     }
                     [self.annotations addObject:a1];
                 }
                 NSLog(@"=============%lu",(unsigned long)self.annotations.count);
                 [self.mapView addAnnotations:self.annotations];
                 [self.mapView selectAnnotation:self.annotations[1] animated:YES];
                 [self.mapView setZoomLevel:15 animated:YES];
             }
             

             
         } failureBlock:^(NSError *error) {
             
         }];

    
  /* [self requestType:HttpRequestTypeGet url:[NSString stringWithFormat:@"https://api.baibaobike.com/v1/bikes?lat=%f&lng=%f&range=1",lat,lng] parameters:nil successBlock:^(id response) {
        NSLog(@"=============%@",response);
     BaseModel*annotion = [BaseModel yy_modelWithJSON:response];
       
       NSLog(@"=======%@+++++++++%@",annotion.errorno,annotion.errmsg);
        NSLog(@"=================++++++%ld",(unsigned long)annotionlist.list.count);
        if(annotionlist.list.count>0){
            self.paopaoTag=1;
            [self.mapView removeAnnotations:self.annotations];
            [self.annotations removeAllObjects ];
            self.changeAnnotation.lockedScreenPoint = CGPointMake(self.view.frame.size.width/2.0,(self.view.frame.size.height-64)/2.0);
            //self.changeAnnotation.lockedToScreen = YES;
            self.changeAnnotation.title =@"11111111";
            [self.annotations addObject:self.changeAnnotation];
            for(int i=0;i<annotionlist.list.count;i++){
                annotionInfoModel *annotioninfo =annotionlist.list[i];
                MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
                a1.coordinate=CLLocationCoordinate2DMake(annotioninfo.lat, annotioninfo.lng);
                NSLog(@"lat====%flng====%f",annotioninfo.lat, annotioninfo.lng);
                //a1.title      = [NSString stringWithFormat:@"anno: %d", annotioninfo.id];
                if(i==0){
                    a1.subtitle      = @"离我最近";
                    
                }
                [self.annotations addObject:a1];
            }
            NSLog(@"=============%lu",(unsigned long)self.annotations.count);
            [self.mapView addAnnotations:self.annotations];
            [self.mapView selectAnnotation:self.annotations[1] animated:YES];
            [self.mapView setZoomLevel:15 animated:YES];
        }

        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];*/
    }
#pragma mark 地图设置
-(void)setMapSubview{
    self.mapView  = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64)];
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    

    self.mapView.delegate = self;
    [self.mapView setZoomLevel:15 animated:YES];
    self.mapView.showsCompass =NO;
    self.mapView.showsScale =NO;
    self.mapView .showsUserLocation = YES;
    
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    //初始化 MAUserLocationRepresentation 对象：
  
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    
    r.enablePulseAnnimation = NO;///内部蓝色圆点是否使用律动效果, 默认YES
    
    r.strokeColor = [UIColor clearColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.fillColor = [UIColor clearColor];
    
    r.lineWidth = 8;///精度圈 边线宽度，默认0

    [self.mapView updateUserLocationRepresentation:r];
   [self.view addSubview:self.mapView];
    NSString *path = [NSString stringWithFormat:@"%@/style_json.json", [NSBundle mainBundle].bundlePath];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
  
    [self.mapView setCustomMapStyle:data];
   }
- (void)mapInitComplete:(MAMapView *)mapView {
    
    self.mapView.customMapStyleEnabled = YES;
}
- (void)setCustomMapStyle:(NSData*)customJson{
    self.mapView.customMapStyleEnabled = YES;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
  }

 #pragma mark - MAMapViewDelegate路径显示

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth = 4;
        polylineRenderer.lineDash  = NO;
        polylineRenderer.strokeColor = [UIColor colorWithHexString:@"#72c2ff"];
        polylineRenderer.lineJoinType=kMALineJoinRound;
        polylineRenderer.lineCapType =kMALineCapRound;
        return polylineRenderer;
    }
  else  if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        

        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        polylineRenderer.lineWidth = 4;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {  polylineRenderer.lineCapType =kMALineCapRound;
            polylineRenderer.lineJoinType = kMALineJoinRound;//连接类型
            polylineRenderer.strokeColor =[UIColor colorWithHexString:@"#72c2ff"];
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway)
        {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    return nil;
}

/* 展示当前路线方案. */
- (void)presentCurrentCourse
{  MANaviAnnotationType type = MANaviAnnotationTypeWalking;
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.endAnnotation.coordinate.latitude longitude:self.endAnnotation.coordinate.longitude]];
    [self.naviRoute addToMapView:self.mapView];
    
//    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
//                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
//                           animated:YES];
    self.mapView.centerCoordinate = self.endAnnotation.coordinate;
    
}
#pragma mark 路经star end
- (void)searchRoutePlanningWalk
{
    
    //self.destinationAnnotation.coordinate = self.destinationCoordinate;
    
    AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];
    
    /* 提供备选方案*/
    navi.multipath = 1;
    
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:self.changeAnnotation.coordinate.latitude
                                           longitude:self.changeAnnotation.coordinate.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:self.endAnnotation.coordinate.latitude
                                                longitude:self.endAnnotation.coordinate.longitude];
    
    [self.search AMapWalkingRouteSearch:navi];
}


-(void)setSearchMapPath{
    self.search  = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * @brief 当请求发生错误时，会调用代理的此方法.
 * @param request 发生错误的请求.
 * @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{

     //NSLog(@"Error: %@ - %@", error, [ErrorInfoUtility errorDescriptionWithCode:error.code]);

}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    
   
    if (response.route == nil)
    {
        return;
    }
    
    self.route = response.route;
    [self updateTotal];
    self.currentCourse = 0;
    
    [self updateCourseUI];
    [self updateDetailUI];
    
    if (response.count > 0)
    {
        [self presentCurrentCourse];
    }
    

//    if (response.route == nil)
//    {
//        return;
//    }
//    self.route = response.route;
//    [self updateTotal];
//    self.currentCourse = 0;
//    if (response.count > 0)
//    {
//        [self presentCurrentCourse];
//    }
}
#pragma mark - Utility
/* 更新"上一个", "下一个"按钮状态. */
- (void)updateCourseUI
{
    /* 上一个. */
    //self.previousItem.enabled = (self.currentCourse > 0);
    
    /* 下一个. */
    //self.nextItem.enabled = (self.currentCourse < self.totalCourse - 1);
}

/* 更新"详情"按钮状态. */
- (void)updateDetailUI
{
    self.navigationItem.rightBarButtonItem.enabled = self.route != nil;
}

- (void)updateTotal
{
    self.totalCourse = self.route.paths.count;
}

- (BOOL)increaseCurrentCourse
{
    BOOL result = NO;
    
    if (self.currentCourse < self.totalCourse - 1)
    {
        self.currentCourse++;
        
        result = YES;
    }
    
    return result;
}

- (BOOL)decreaseCurrentCourse
{
    BOOL result = NO;
    
    if (self.currentCourse > 0)
    {
        self.currentCourse--;
        
        result = YES;
    }
    
    return result;
}

#pragma mark 标注出现
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
   
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        NSLog(@"========0000990000000000");
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        
        if([annotationView.annotation   isEqual:self.changeAnnotation]||[annotationView.annotation.title isEqualToString:@"11111111"]){
            NSLog(@"wqewqewqewqewqewqewqewqewq");
            
            annotationView.image =Img(@"center");
            //设置中心心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -18);
            return annotationView;
        }
        //在地图上添加圆
//      if ([annotationView.annotation.title isEqualToString:@"11111111"]) {
//            annotationView.image =Img(@"home_center_pic");
//           //设置中心心点偏移，使得标注底部中间点成为经纬度对应点
//            annotationView.centerOffset = CGPointMake(0, -15);
//            return annotationView;
//       
//            
//        }
//    else{
            if([annotationView.annotation.subtitle isEqualToString:@"离我最近"]){
                annotationView.canShowCallout   = YES;
                UIView *vc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20,80)];
                vc.backgroundColor=[UIColor redColor];
                [annotationView.customCalloutView addSubview:vc];
            }
        annotationView.centerOffset = CGPointMake(0, -18);
            annotationView.image =Img(@"bike");
            return annotationView;
          }
    
    return nil;
}
 
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*!
 @brief 当选中一个annotation views时调用此接口
 @param mapView 地图View
 @param view 选中的annotation views
 */


# pragma mark 点击标注
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    
    if ([view isKindOfClass:[MAPinAnnotationView class]]) {
        if(self.paopaoTag==1){
            self.paopaoTag=2;
        }else{
        Toast(@"路径规划中");
        [self clearLine];
        MAPointAnnotation *Annotation = (MAPointAnnotation*)view.annotation;
            if([Annotation.title isEqualToString:@"11111111"]){
                
            }else{
            
        NSLog(@" %f,%f",Annotation.coordinate.latitude,Annotation.coordinate.longitude);
        self.centerCoordinate =[self.mapView convertPoint:self.view.center toCoordinateFromView:self.view];
        self.endAnnotation.coordinate  = self.centerCoordinate;
       
        self.startAnnotation.coordinate =Annotation.coordinate ;
        BOOL isContains = MACircleContainsCoordinate(self.startAnnotation.coordinate, self.endAnnotation.coordinate, 200);
        NSLog(@"isContains===%d",isContains);
        [self clearLine];
        [self searchRoutePlanningWalk];
        //1.将两个经纬度点转成投影点
        MAMapPoint point1 = MAMapPointForCoordinate(Annotation .coordinate);
        MAMapPoint point2 = MAMapPointForCoordinate(self.endAnnotation.coordinate);
        //2.计算距离
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
          //self.changeAnnotation.lockedToScreen = NO;
        self.topCheakView.distanceLab.text =[NSString stringWithFormat:@"%.0f米",distance];
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location                    = [AMapGeoPoint locationWithLatitude:Annotation.coordinate.latitude longitude:Annotation.coordinate.longitude];
        regeo.requireExtension =YES;
        [self.search AMapReGoecodeSearch:regeo];

        //CLLocationCoordinate2D coordinate =  self.endAnnotation.coordinate;
        //ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
                                                                                        // reGeocode:response.regeocode];
        self.topCheakView.hidden=NO;
        //self.changeAnnotation.lockedToScreen=NO;
                
            }
        }
    }
   // [_mapView  deselectAnnotation:view.annotation animated:YES];

    
}
- (void)setStartandendAnnotations
{
    /*
     { //  UIImageView *imageview=[[UIImageView alloc]init];
     //异步加载
     //    [imageview sd_setImageWithURL:[NSURL URLWithString:annotation.subtitle] placeholderImage:[UIImage imageNamed:@"placehodeLoading.png"]];
     
     //    [imageview sd_setImageWithURL:[NSURL URLWithString:annotation.subtitle] placeholderImage:[UIImage imageNamed:@"placehodeLoading.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     //     {
     //         annotationView.image=[self getImageFromView:viewForImage];//修改默认图片不替换问题
     //     }];
     
     //在地图上添加圆
     }
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    self.startAnnotation = startAnnotation;
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    self.destinationAnnotation = destinationAnnotation;*/
}

/* 清空地图上已有的路线. */
- (void)clearLine
{
    [self.naviRoute removeFromMapView];
}
#pragma 底部视图
-(void)setBottomSubview{
    HomeBottomView *bottom = [[HomeBottomView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT-90, SCREEN_WIDTH, 90)];

    __block HomeVC  *selfblock=self;
    bottom.freshBlock=^{
        
    [self clearLine];
        [self.mapView removeAnnotations:self.annotations];
        self.changeAnnotation.lockedScreenPoint = CGPointMake(self.view.frame.size.width/2.0,(self.view.frame.size.height-64)/2.0);
        if(self.changeAnnotation.coordinate.latitude==0){
             self.changeAnnotation.coordinate =self.startAnnotation.coordinate;
             [selfblock getLocationManagerAnnotationLat:   self.startAnnotation.coordinate.latitude Lng:   self.startAnnotation.coordinate.longitude];
        }else{
            [selfblock getLocationManagerAnnotationLat:   self.changeAnnotation.coordinate.latitude Lng:   self.changeAnnotation.coordinate.longitude];}
    };
    bottom.cheakBlock=^{
        if( !TelNumber){
            [selfblock cheakToken];
            LoginVC *loginVC = [[LoginVC alloc]init];
            [selfblock  absPushViewController:loginVC animated:YES];
            
            return;
        }else{
            if(![[DB getStringById:@"money" fromTable:tabName] isEqualToString:@"1"]){
                paymentVC * vc = [[paymentVC alloc]init];
                [selfblock absPushViewController:vc animated:YES];
            }else{
                if(![[DB getStringById:@"certify" fromTable:tabName] isEqualToString:@"1"]){
                    certifyPersonInfoVC * vc = [[certifyPersonInfoVC alloc]init];
                    [selfblock absPushViewController:vc animated:YES];

                }else{
                    [selfblock jumpCheakViewConroller];
                }
            }
        }
    };
    
    bottom.mapBlock = ^{
        if(self.MyCoordinate.latitude ==0){
            [self clearLine];
            selfblock.mapView.centerCoordinate=self.startAnnotation.coordinate;
            
        }else{
            [self clearLine];
            selfblock.mapView.centerCoordinate=  self.MyCoordinate;
                   }
            };
    
    bottom.helpBlock = ^{
        if( !TelNumber){
            [selfblock cheakToken];
            LoginVC *loginVC = [[LoginVC alloc]init];
            [selfblock  absPushViewController:loginVC animated:YES];
            
            return;
        }else{
            if(![[DB getStringById:@"money" fromTable:tabName] isEqualToString:@"1"]){
                paymentVC * vc = [[paymentVC alloc]init];
                [selfblock absPushViewController:vc animated:YES];
            }else{
                if(![[DB getStringById:@"certify" fromTable:tabName] isEqualToString:@"1"]){
                    certifyPersonInfoVC * vc = [[certifyPersonInfoVC alloc]init];
                    [selfblock absPushViewController:vc animated:YES];
                    
                }else{
                    [selfblock BaseUpAnimation];
                }
            }
        }
    };
     [self.view addSubview:bottom];
     self.backView  = [[UIView alloc]initWithFrame:self.view.bounds];
     self.backView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2];
     UIButton *hideHomebottomview = [[UIButton alloc]initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-210)];
     self.backView.hidden = YES;
     [self.backView  addSubview:hideHomebottomview ];
     [self.view      addSubview:self.backView];
    
     [hideHomebottomview   addTarget:self action:@selector(BaseDownAnimation) forControlEvents:UIControlEventAllEvents];
   
    self.animationView =[[ HomeHelpView alloc]initWithFrame:CGRectMake(10, SCREENH_HEIGHT+210, SCREEN_WIDTH-20, 200)];
    self.animationView.lockBlock = ^{
        LockVC    *vc = [[LockVC alloc]init];
        [selfblock absPushViewController:vc animated:YES];
    };
    
    self.animationView.otherBlock = ^{
         ServesVC *vc =[[ServesVC alloc]init];
         [selfblock.navigationController pushViewController:vc animated:YES];
    };
    
    self.animationView.stopBlock = ^{
        StopVC  *vc =[[StopVC alloc]init];
        [selfblock absPushViewController:vc animated:YES];
    };
    
    self.animationView.breakdownBlock = ^{
        breakDownVC *vc  =[[breakDownVC alloc]init];
        [selfblock absPushViewController:vc animated:YES];
    };
    [self.view addSubview:self.animationView ];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.actView.hidden=YES;
    self.topCheakView.hidden=YES;
    [self clearLine];
   }

#pragma 跳转验证页

-(void)jumpCheakViewConroller{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        Toast(@"请允许app访问你的相机和相册");
    } else {
        
        CheakViewController *vic  = [[CheakViewController alloc ]init];
       // vic.lightButton = [[UIButton alloc]init];
        [self.navigationController pushViewController:vic animated:YES];
    }
   
    }

-(void)BaseUpAnimation{
   [UIView animateWithDuration:0.50f animations:^{
       self.animationView.frame =CGRectMake(10, SCREENH_HEIGHT-210, SCREEN_WIDTH-20, 200);
           }];
    
    self.backView.hidden=NO;

}
-(void)BaseDownAnimation{
    [UIView animateWithDuration:0.50f animations:^{
        self.backView.hidden=YES;
        self.animationView.frame =CGRectMake(10, SCREENH_HEIGHT+210, SCREEN_WIDTH-20, 200);
    }];
}

#pragma  头部视图 
-(void)setTopCheakview{
    self.topCheakView = [[NSBundle mainBundle]loadNibNamed:@"homeTopCheakView" owner:nil  options:nil].lastObject;
    self.topCheakView.hidden =YES;
    self.topCheakView.cheakBlock = ^{
    };
    self.topCheakView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 170);
    __weak HomeVC *weakself =self;
    self.topCheakView.cheakBlock = ^{
        LoginVC *loginVC = [[LoginVC alloc]init];
        [weakself  absPushViewController:loginVC animated:YES];
    };
    [self.view addSubview:self.topCheakView];
}
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView{
    
}

- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error{
    UIAlertView *ale =[ [UIAlertView alloc]initWithTitle:nil message:@"地图加载失败请检查网络后重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [ale show];

}
-(void)setLocalInfoDetaile{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location                    = [AMapGeoPoint locationWithLatitude:self.endAnnotation.coordinate.latitude longitude:self.endAnnotation.coordinate.longitude];
    regeo.requireExtension =YES;
    [self.search AMapReGoecodeSearch:regeo];
}
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述，具体解析见 Demo
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate reGeocode:response.regeocode];
        NSLog(@"%@==%@",reGeocodeAnnotation.title ,reGeocodeAnnotation.subtitle);
        self.topCheakView.LocalInfoLab.text =reGeocodeAnnotation.title ;

    }
}
-(void)cheakMap{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorized)) {
        
        //定位功能可用
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"请允许获取您的位置，不然可能获取不到信息欧～" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        [alert show];
        //定位不能用
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        
    }else if(buttonIndex==1){
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
            
        }
        
        //NSURL*url=[NSURL URLWithString:@"prefs:root=WIFI"];
        [[UIApplication sharedApplication] openURL:url];
    }
}
/**
 * @brief 地图区域改变过程中会调用此接口 since 4.6.0
 * @param mapView 地图View
 */
- (void)mapViewRegionChanged:(MAMapView *)mapView{
    NSLog(@"地图区域改变过程中会调用此接口 ");
}

/**
 * @brief 地图区域即将改变时会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    NSLog(@"地图区域即将改变时会调用此接口");
    //self.changeAnnotation.lockedToScreen=NO;
}

/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"地图区域改变完成后会调用此接口");
}

/**
 * @brief 地图将要发生移动时调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    NSLog(@" 地图将要发生移动时调用此接口");
}

/**
 * @brief 地图移动结束后调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    NSLog(@"地图移动结束后调用此接口");
}




@end
