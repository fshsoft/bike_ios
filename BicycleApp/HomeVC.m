
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
#import "JSCenterAnnotation.h"
#import "ZXNLocationGaoDeManager.h"
#import "WalletMoneyVC.h"

#import <CoreBluetooth/CoreBluetooth.h>
#import "NSData+CRC16.h"
#import "NSString+WithCRCModbus.h"
#import "changeNumTool.h"
#include <stdlib.h>

@interface HomeVC ()<AMapSearchDelegate,MAMapViewDelegate,AMapLocationManagerDelegate,AMapGeoFenceManagerDelegate,CBCentralManagerDelegate,CBPeripheralDelegate,scanDelegate>
{
    NSMutableArray *all_arrayList;
    ZXNLocationGaoDeManager *currentPosition;
    
    BOOL isShowView;//上部自行车信息框弹出
    BOOL isMoveView;//是否移动地图
    CLLocationCoordinate2D currentCoordinate;
    
    JSCenterAnnotation *centerAnnotaion;
    MAAnnotationView *centerAnnoView;
    
    
}


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
//@property (nonatomic ,strong)AMapGeoFenceManager *geoFenceManager;
@property (nonatomic,assign) int loadStatus;
@property (nonatomic,assign) int moneyStatus;
@property (nonatomic,assign) int certifyStatus;
@property (nonatomic,assign) float moneyNum;

@property (nonatomic,strong)CBCentralManager  * mgr;
@property (nonatomic,strong)CBPeripheral      * peripheral;
@property (nonatomic,strong)NSData   * data;
@property (nonatomic,strong)CBCharacteristic  * write;
@property (nonatomic,strong)CBCharacteristic  * read;
@property (nonatomic,strong)CBCharacteristic  * notify;
@property (nonatomic,strong)CBCharacteristic  * unknow;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *detaile;
@property (nonatomic,assign)int num;
@property (nonatomic,copy)NSString * key;

@property (nonatomic,assign)BOOL    BlueTooth;
@property (nonatomic,copy  )NSString   * macStr;

@end

@implementation HomeVC
- (void)setUpData{
    
    
    __block CLLocationCoordinate2D coor;
    
    coor.latitude =[currentPosition.lat_gaode doubleValue];
    coor.longitude  = [currentPosition.lon_gaode doubleValue];
    WeakSelf(self);
    currentCoordinate = coor;
    
    [[ZXNLocationGaoDeManager sharedManager] getGps:^(NSString *lat, NSString *lon) {
        
        if(lat.length!=0&&lon.length!=0   ){
            coor.longitude = [lon doubleValue];
            coor.latitude =  [lat doubleValue];
            
            [weakself   getLocationManagerAnnotationLat:lat Lng:lon ];
        }
    }];
    isMoveView = YES;
    
}

- (void)viewDidLoad {
    
    [self cheakToken];
    [self initMapInfoDetaile];
    [self cheakMap];
 
    self.tag = 1;
    self.paopaoTag = 1;
    [self setHomeNaviView];
    [super viewDidLoad];
    self.navi.hidden=YES;
    [self setMapSubview];
    [self setTopCheakview];
    [self setSearchMapPath];
    [self setBottomSubview];
    [self setNavLeftItemTitle:nil andImage:Img(@"catage")];
    self.BlueTooth =NO;
       // self.mgr = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
- (void)local{
    //    centerAnnotaion.coordinate = currentCoordinate;
    self.mapView.showsUserLocation = true;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}
#pragma mark - mapViewDelete
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    if (!isMoveView) {
        //不能移动
        centerAnnotaion.lockedToScreen = NO;
    }else{
        centerAnnotaion.lockedToScreen = YES;
    }
}

- (void)mapInitComplete:(MAMapView *)mapView{
    centerAnnotaion = [[JSCenterAnnotation alloc]init];
    centerAnnotaion.coordinate = currentCoordinate;//self.mapView.centerCoordinate;
    centerAnnotaion.lockedScreenPoint = CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height-64)/2);
    centerAnnotaion.lockedToScreen = YES;
    self.startAnnotation.coordinate =centerAnnotaion.coordinate;
    [self.mapView addAnnotation:centerAnnotaion];
    [self.mapView showAnnotations:@[centerAnnotaion] animated:YES];
    [self local];
}

#pragma mark 初始化地图所需数据
-(void)initMapInfoDetaile{
    self.annotations = [NSMutableArray array];
    self.changeAnnotation = [[MAPointAnnotation alloc]init];
    self.startAnnotation  = [[MAPointAnnotation alloc] init];
    self.endAnnotation    = [[MAPointAnnotation alloc] init];
    

}

  #pragma mark nav视图
 -(void)setHomeNaviView{
    self.homeNaiv = [[NSBundle mainBundle]loadNibNamed:@"HomeNaiv" owner:self options:nil].lastObject;
    self.homeNaiv.frame  =CGRectMake(0, 0, SCREEN_WIDTH, 64);
    __block HomeVC *weakSelf = self;
    self.homeNaiv.leftBlock = ^{
        
        if( self.loadStatus!=1){
            [weakSelf cheakToken];
            LoginVC *loginVC = [[LoginVC alloc]init];
            [weakSelf  absPushViewController:loginVC animated:YES];
            
            return;
        }
                 else{
                    MeVC * me  = [[MeVC alloc]init];
                    [weakSelf.navigationController pushViewController:me animated:YES ];
           
        }

        };
     self.homeNaiv.mesBlock = ^{
         if( self.loadStatus!=1){
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


#pragma mark 地图设置
-(void)setMapSubview{
    self.mapView  = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64)];
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 15;
    // 开启定位
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView addAnnotation:centerAnnotaion];
    
    //初始化 MAUserLocationRepresentation 对象：
    MAUserLocationRepresentation *localPoint = [[MAUserLocationRepresentation alloc] init];
    localPoint.showsHeadingIndicator = YES;
    [self.mapView updateUserLocationRepresentation:localPoint];
    
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
   // [self configGeoFenceManager];
    //[self addGeoFencePolygonRegion];
      }



//初始化地理围栏manager
//- (void)configGeoFenceManager {
//    self.geoFenceManager = [[AMapGeoFenceManager alloc] init];
//
//    self.geoFenceManager.delegate = self;
//    self.geoFenceManager.activeAction = AMapGeoFenceActiveActionInside | AMapGeoFenceActiveActionOutside | AMapGeoFenceActiveActionStayed; //进入，离开，停留都要进行通知
//    self.geoFenceManager.allowsBackgroundLocationUpdates = YES;  //允许后台定位
//}

//添加地理围栏对应的Overlay，方便查看。地图上显示圆
- (MACircle *)showCircleInMap:(CLLocationCoordinate2D )coordinate radius:(NSInteger)radius {
    MACircle *circleOverlay = [MACircle circleWithCenterCoordinate:coordinate radius:radius];
    [self.mapView addOverlay:circleOverlay];
    return circleOverlay;
}

//地图上显示多边形
- (MAPolygon *)showPolygonInMap:(CLLocationCoordinate2D *)coordinates count:(NSInteger)count {
    MAPolygon *polygonOverlay = [MAPolygon polygonWithCoordinates:coordinates count:count];
    [self.mapView addOverlay:polygonOverlay];
    return polygonOverlay;
}

// 清除上一次按钮点击创建的围栏
- (void)doClear {
    [self.mapView removeOverlays:self.mapView.overlays];  //把之前添加的Overlay都移除掉
    //[self.geoFenceManager removeAllGeoFenceRegions];  //移除所有已经添加的围栏，如果有正在请求的围栏也会丢弃
}


#pragma mark xib btns click



//添加多边形围栏按钮点击
//- (void)addGeoFencePolygonRegion {
//    NSInteger count = 5;
//    CLLocationCoordinate2D *coorArr = malloc(sizeof(CLLocationCoordinate2D) * count);
//
//    coorArr[0] = CLLocationCoordinate2DMake(31.199987, 121.369135);     //平安里地铁站
//    coorArr[1] = CLLocationCoordinate2DMake(31.233835, 121.412253);     //西单地铁站
//    coorArr[2] = CLLocationCoordinate2DMake(31.223212, 121.558282);     //崇文门地铁站
//    coorArr[3] = CLLocationCoordinate2DMake(31.154261, 121.501653);     //东直门地铁站
//    coorArr[4] = CLLocationCoordinate2DMake(31.096887,  121.373303);
//
//    [self doClear];
//   // [self.geoFenceManager addPolygonRegionForMonitoringWithCoordinates:coorArr count:count customID:@"polygon_1"];
//
//    free(coorArr);
//    coorArr = NULL;
//}







#pragma mark - AMapGeoFenceManagerDelegate

//添加地理围栏完成后的回调，成功与失败都会调用
- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didAddRegionForMonitoringFinished:(NSArray<AMapGeoFenceRegion *> *)regions customID:(NSString *)customID error:(NSError *)error {
    
     if ([customID isEqualToString:@"polygon_1"]) {
        if (error) {
            NSLog(@"=======polygon error %@",error);
        } else {
            AMapGeoFencePolygonRegion *polygonRegion = (AMapGeoFencePolygonRegion *)regions.firstObject;
            MAPolygon *polygonOverlay = [self showPolygonInMap:polygonRegion.coordinates count:polygonRegion.count];
          // [self.mapView setVisibleMapRect:polygonOverlay.boundingMapRect edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:YES];
        }
    }
}

//地理围栏状态改变时回调，当围栏状态的值发生改变，定位失败都会调用
- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didGeoFencesStatusChangedForRegion:(AMapGeoFenceRegion *)region customID:(NSString *)customID error:(NSError *)error {
    if (error) {
        NSLog(@"status changed error %@",error);
    }else{
        if(manager.activeAction==AMapGeoFenceActiveActionInside){
            Toast(@"在电子围栏中");
            
        }else if(manager.activeAction==AMapGeoFenceActiveActionOutside){
            Toast(@"离开电子围栏中");
        }else if(manager.activeAction==AMapGeoFenceActiveActionStayed){
            Toast(@"进入电子围栏中");
        }

        
        NSLog(@"status changed %@",[region description]);
    }
}


#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    //self.userLocation = userLocation.location;
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
    }else if ([overlay isKindOfClass:[MAPolygon class]]) {
        MAPolygonRenderer *polylineRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polylineRenderer.lineWidth = 4.0f;
        polylineRenderer.lineDash  = NO;
        polylineRenderer.fillColor =[UIColor clearColor];
        polylineRenderer.lineJoinType=kMALineJoinRound;
        polylineRenderer.lineCapType =kMALineCapRound;
        polylineRenderer.strokeColor = mainColor;
        
        return polylineRenderer;
    } else if ([overlay isKindOfClass:[MACircle class]]) {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        circleRenderer.lineWidth = 4.0f;
        circleRenderer.strokeColor = mainColor;
        
        return circleRenderer;
    }

    return nil;
}

/* 展示当前路线方案. */
- (void)presentCurrentCourse
{  MANaviAnnotationType type = MANaviAnnotationTypeWalking;
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.endAnnotation.coordinate.latitude longitude:self.endAnnotation.coordinate.longitude]];
    [self.naviRoute addToMapView:self.mapView];
    
    
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
    navi.origin = [AMapGeoPoint locationWithLatitude:centerAnnotaion.coordinate.latitude
                                           longitude:centerAnnotaion.coordinate.longitude];
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
    
  
    
    if (response.count > 0)
    {
        [self presentCurrentCourse];
    }
    

 }
#pragma mark - Utility

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
    
   
    if ([annotation isMemberOfClass:[MAUserLocation class]]) {
        
        return nil;
    }
    
   
    
    if ([annotation isMemberOfClass:[JSCenterAnnotation class]]) {
        static NSString *reuseCneterid = @"myCenterId";
        MAAnnotationView *annotationView= [self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseCneterid];
        if (!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:reuseCneterid];
        }
        annotationView.image =Img(@"home_center_pic");
        //设置中心心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        annotationView.canShowCallout = NO;
        centerAnnoView = annotationView;
        return annotationView;
    }
    
    static NSString *reuseid = @"myId";
    
    MAAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseid];
    if (!annotationView) {
        annotationView = [[MAAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:reuseid];
    }
    if([annotationView.annotation.subtitle isEqualToString:@"离我最近"]){
        annotationView.canShowCallout   = YES;
        UIView *vc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20,80)];
        vc.backgroundColor=[UIColor redColor];
        [annotationView.customCalloutView addSubview:vc];
    }
    annotationView.image =Img(@"bike");
    //annotationView.canShowCallout = YES;
    return annotationView;
    
}
 
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//单击地图
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    if (isShowView) {
        // [self.showView setHidden:YES];
        // [self.btn_local setHidden:NO];
    }
    [self clearLine];
    self.topCheakView.hidden=YES;
    //self.mapView.zoomLevel = 15;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    
    [self.mapView addAnnotations: self.annotations];
    [self.mapView addAnnotation:centerAnnotaion];
    //[self addGeoFencePolygonRegion];
    isMoveView = YES;
}




# pragma mark 点击标注
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    if ([view.annotation isMemberOfClass:[MAUserLocation class]]) {
        
        return ;
    }
    
    if ([view.annotation isMemberOfClass:[JSCenterAnnotation class]]) {
        
        return ;
    }

    Toast(@"路径规划中");
    [self clearLine];
    MAPointAnnotation *Annotation = (MAPointAnnotation*)view.annotation;
    
    
    self.centerCoordinate =[self.mapView convertPoint:self.view.center toCoordinateFromView:self.view];
    self.endAnnotation.coordinate  = self.centerCoordinate;
    
    self.startAnnotation.coordinate =Annotation.coordinate ;
    BOOL isContains = MACircleContainsCoordinate(self.startAnnotation.coordinate, self.endAnnotation.coordinate, 200);
    
    
    [self searchRoutePlanningWalk];
    //1.将两个经纬度点转成投影点
    MAMapPoint point1 = MAMapPointForCoordinate(Annotation .coordinate);
    MAMapPoint point2 = MAMapPointForCoordinate(self.endAnnotation.coordinate);
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    //self.changeAnnotation.lockedToScreen = NO;
    self.topCheakView.distanceLab.text =[NSString stringWithFormat:@"%.0f米",distance];
    
    self.topCheakView.timeLab.text = [NSString stringWithFormat:@"%.0f分钟",distance/70.0];
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location                    = [AMapGeoPoint locationWithLatitude:Annotation.coordinate.latitude longitude:Annotation.coordinate.longitude];
    regeo.requireExtension =YES;
    [self.search AMapReGoecodeSearch:regeo];
    
    //CLLocationCoordinate2D coordinate =  self.endAnnotation.coordinate;
    //ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
    // reGeocode:response.regeocode];
    self.topCheakView.hidden=NO;
    //self.changeAnnotation.lockedToScreen=NO;
    
   // [_mapView  deselectAnnotation:view.annotation animated:YES];

    
}

/* 清空地图上已有的路线. */
- (void)clearLine
{
    [self.naviRoute removeFromMapView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    self.actView.hidden=YES;
    self.topCheakView.hidden=YES;
    [self clearLine];
}
#pragma mark 获取标注
-(void)getLocationManagerAnnotationLat:(NSString*)lat Lng:(NSString *)lng{
    
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action":  @"searchBikes",
                        @"lat"   :  lat ,
                        @"lng"   :  lng
                        }
         successBlock:^(BaseModel *response) {
             if([response.errorno intValue]==0){
                 self.loadStatus=[response.data.islogin intValue];
                 if(self.loadStatus==1){
                     [self cheakMoneyandCertify];
                 }
                 NSMutableArray * arr = [NSMutableArray array];
                 [arr addObjectsFromArray:response.data.bikes];
                 //listInfoModel* model = [listInfoModel yy_modelWithJSON:response];
                 if(arr.count>0){
                     self.paopaoTag=1;
                     [self.mapView removeAnnotations:self.annotations];
                     [self.annotations removeAllObjects ];
                     
                  
                     for(int i=0;i<arr.count;i++){
                         annotionInfoModel * infomodel =  arr[i];
                         
                         MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
                         //double lat = [[NSString stringWithFormat:@"%.12f",[infomodel.lat doubleValue]]doubleValue];
                       
                         //double lng = [[NSString stringWithFormat:@"%.12f",[infomodel.lng doubleValue]]doubleValue];
        CLLocationCoordinate2D amapcoord =AMapCoordinateConvert(CLLocationCoordinate2DMake(infomodel.lat,infomodel.lng), AMapCoordinateTypeGPS);
                         a1.coordinate=amapcoord;
                         
                         

                         [self.annotations addObject:a1];
                     }
                     [self.mapView addAnnotation:centerAnnotaion];
                     [self.mapView addAnnotations:self.annotations];
                     //[self.mapView selectAnnotation:self.annotations[1] animated:YES];
                     
                 }

             }
         } failureBlock:^(NSError *error) {
             
         }];
}
#pragma 底部视图
-(void)setBottomSubview{
    HomeBottomView *bottom = [[HomeBottomView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT-90, SCREEN_WIDTH, 90)];

    __block HomeVC  *selfblock=self;
    bottom.freshBlock=^{
        
    [self clearLine];
        [self.mapView removeAnnotations:self.annotations];
        self.changeAnnotation.lockedScreenPoint = CGPointMake(self.view.frame.size.width/2.0,(self.view.frame.size.height-64)/2.0);
        
        [selfblock  setUpData];
    };
    bottom.cheakBlock=^{
      //[selfblock jumpCheakViewConroller];
        if( self.loadStatus!=1){
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
                    if([[DB getStringById:@"balance" fromTable:tabName] floatValue]>0){
                        [selfblock jumpCheakViewConroller];
                    }else{
                        WalletMoneyVC *vc = [[WalletMoneyVC  alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
  
                    }
                }
            }}
        
    };
    
    bottom.mapBlock = ^{
        self.topCheakView.hidden=YES;
        [self clearLine];
        [selfblock  local];

                    };
    bottom.infoBlock = ^{
        messageVC *message = [[messageVC alloc]init];
        [selfblock absPushViewController:message animated:YES];
    };

    
    bottom.helpBlock = ^{
        
        if( self.loadStatus!=1){
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
        [[UIApplication  sharedApplication] openURL:[NSURL  URLWithString:  [NSString stringWithFormat:@"tel://%@",@"4008888"]]];
//        LockVC    *vc = [[LockVC alloc]init];
//        [selfblock absPushViewController:vc animated:YES];
    };
    
    self.animationView.otherBlock = ^{
        [[UIApplication  sharedApplication] openURL:[NSURL  URLWithString:  [NSString stringWithFormat:@"tel://%@",@"4008888"]]];
//         ServesVC *vc =[[ServesVC alloc]init];
//         [selfblock.navigationController pushViewController:vc animated:YES];
    };
    
    self.animationView.stopBlock = ^{
        [[UIApplication  sharedApplication] openURL:[NSURL  URLWithString:  [NSString stringWithFormat:@"tel://%@",@"4008888"]]];
//        StopVC  *vc =[[StopVC alloc]init];
//        [selfblock absPushViewController:vc animated:YES];
    };
    
    self.animationView.breakdownBlock = ^{
        [[UIApplication  sharedApplication] openURL:[NSURL  URLWithString:  [NSString stringWithFormat:@"tel://%@",@"4008888"]]];
//        breakDownVC *vc  =[[breakDownVC alloc]init];
//        [selfblock absPushViewController:vc animated:YES];
    };
    [self.view addSubview:self.animationView ];
    
}

#pragma 跳转验证页

-(void)jumpCheakViewConroller{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        Toast(@"请允许app访问你的相机和相册");
    } else {
        
        CheakViewController *vic  = [[CheakViewController alloc ]init];
        //vic.lightButton = [[UIButton alloc]init];
        if(self.BlueTooth){
            
            [self.mgr cancelPeripheralConnection:self.peripheral];
            
        }
      
     
        vic.blueToothdelegate   =self;
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
   // __weak HomeVC *weakself =self;
//    self.topCheakView.cheakBlock = ^{
//        LoginVC *loginVC = [[LoginVC alloc]init];
//        [weakself  absPushViewController:loginVC animated:YES];
//    };
    [self.view addSubview:self.topCheakView];
}
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView{
    
}

- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error{
    UIAlertView *ale =[ [UIAlertView alloc]initWithTitle:nil
                                                 message:@"地图加载失败请检查网络后重试"
                                                delegate:self
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"确认", nil];
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
        //NSLog(@"%@==%@",reGeocodeAnnotation.title ,reGeocodeAnnotation.subtitle);
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

#pragma mark token获取
-(void)cheakToken{
    
    if(refressh_access_token){
        
        [self setUpData];
    }else{
        [self getInfo];
    }
}

-(void)getInfo{
    [ZKUDID setDebug:YES];   // default is NO.
    NSString *UDID = [ZKUDID value];
    NSLog(@"%@",UDID);
    NSString *strEnRes = [CusMD5 md5String:UDID];
    NSLog(@"%@",UDID);
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:@"https://api.xybike.top/register.html"
                         parameters:@{@"imei":UDID,@"code":strEnRes}
                       successBlock:^(id response) {
                           //NSLog(@"%@",response);
                           BaseModel  * model = [BaseModel yy_modelWithJSON: response];
                           if([model.errorno isEqualToString:@"0"]){
                               appInfoModel    * appinfomodel = model.data;
                               
                               [DB putString:appinfomodel.app_key       withId:@"app_key"      intoTable:tabName];
                               [DB putString:appinfomodel.app_secret    withId:@"app_secret"   intoTable:tabName];
                               [DB putString:appinfomodel.refresh_url   withId:@"refrsh_url"   intoTable:tabName];
                               [DB putString:appinfomodel.seed_secret   withId:@"seed_secret"  intoTable:tabName];
                               [DB putString:appinfomodel.source_url    withId:@"source_url"   intoTable:tabName];
                               [DB putString:appinfomodel.token_url     withId:@"token_url"    intoTable:tabName];
                               [DB putString:appinfomodel.authorize_url withId:@"authorize_url" intoTable:tabName];
                               [self requestToken];
                           }
                           else{
                               //   [self getInfo];
                               
                           }
                       } failureBlock:^(NSError *error) {
                           
                           // Toast(@"网络请求失败，请退出重试");
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    
}
-(void)requestToken{
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:[DB getStringById:@"authorize_url" fromTable:tabName]
                         parameters:
     @{
       @"response_type" :@"code",
       @"client_id"     :[DB getStringById:@"app_key" fromTable:tabName],
       @"state"         :[DB getStringById:@"seed_secret" fromTable:tabName]
       
       }
                       successBlock:^(id response) {
                           //NSLog(@"%@",response);
                           if([[response objectForKey:@"errno"] isEqualToString:@"0"]){
                               
                               [DB putString:[[response objectForKey:@"data"] objectForKey:@"authorize_code"]withId:@"authorize_code" intoTable:tabName];
                               [self getToken];
                           }else{
                               [self requestToken];
                           }
                       }
                       failureBlock:^(NSError *error) {
                           // Toast(@"网络请求失败，请退出重试");
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    
    
}

-(void)getToken{
    
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
                          // NSLog(@"%@",response);
                           if([[response objectForKey:@"errno"] isEqualToString:@"0"]){
                               
                               BaseModel    * model    = [BaseModel yy_modelWithJSON:response];
                               appInfoModel * appmodel = model.data;
                               [DB putString: appmodel.refresh_token withId:@"refresh_token"   intoTable:tabName];
                               [DB putString: appmodel.access_token  withId: @"access_token"  intoTable:tabName];
                               [self setUpData];
                               
                           }else{
                               [self getToken];
                           }
                           
                           
                           
                           
                       } failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                       }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter   defaultCenter]addObserver:self selector:@selector(numBlueTooth:) name:@"mac" object:nil];
    [super viewWillAppear:animated  ];
    [self cheakToken];
    self.BlueTooth =NO;
    if(refressh_access_token){
        [self requestCheakNOtify];
    }
}
-(void)requestCheakNOtify{
    [self requestType:HttpRequestTypePost url:nil
           parameters:@{
                        @"action":@"latestNotify"
                        }
         successBlock:^(BaseModel *response) {
             if (response.errorno){
            appInfoModel *model = response.data;
            if([model.scene intValue]==1001){
NSLog(@"model.cost=%@model.duration=%@model.display=%@model.scene=%@",model.cost,model.duration,model.display,model.scene);
                     [[ [UIAlertView alloc]initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"费用:%@骑行时间:%@",model.cost,model.duration]  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
            }else if([model.scene intValue]==1000){
                 [[ [UIAlertView alloc]initWithTitle:@"提示信息" message:@"已经可以开始骑行"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
            }
             }
         } failureBlock:^(NSError *error) {
             
         }];
}


-(NSData *)getKey{
    Byte data[19]={};
    data[0]=[self Num16:@"FE"];
    self.num = arc4random() %255;
    
    data[1] = [self Num16: [changeNumTool coverFromIntToHex:self.num+50]];
    for (int i =2;i<6;i++){
     data[i]=[self Num16:[[DB getStringById:@"uid" fromTable:tabName] substringWithRange:NSMakeRange((i-2)*2, 2)] ]^[self Num16: [changeNumTool coverFromIntToHex:self.num]];
    }
    data[6]= [self Num16:@"00"]^[self Num16: [changeNumTool coverFromIntToHex:self.num]];
    data[7]= [self Num16:@"11"]^[self Num16: [changeNumTool coverFromIntToHex:self.num]];
    data[8]= [self Num16:@"08"]^[self Num16: [changeNumTool coverFromIntToHex:self.num]];
    NSString * str = @"H5OzfVM2";
    
    const char * test =[str UTF8String];
    for (int i=0;i<strlen(test);i++){
        data[9+i]=(test[i]&0xff)^[self Num16: [changeNumTool coverFromIntToHex:self.num]];
        
    }
    NSString *mingwen=@"";
    for(int i=0;i<17;i++){
        
        mingwen  =[mingwen   stringByAppendingString:[changeNumTool coverFromIntToHex:  data[i]]];
    }
 
    NSString * one = [[mingwen getCrcString] substringWithRange:NSMakeRange(0, 2)];
    NSString * two = [[mingwen getCrcString] substringWithRange:NSMakeRange(2, 2)];
    data[17] =[self Num16:one];
    data[18] = [self Num16:two];
    
    //Byte * testByte = (Byte *)[testData bytes];
    NSData * result = [NSData dataWithBytes:data length:19];
    [self.peripheral writeValue:result forCharacteristic:self.write type:CBCharacteristicWriteWithResponse];
    return result;
}

-(void)scanBlueTooth:(NSString *)str{
      self.macStr =str;
     [self loadupGprs];
      self.mgr = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}

- (void)numBlueTooth:(NSNotification   *)str{
    self.macStr =str.object;
    [self loadupGprs];
    self.mgr = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}


-(void)openLock{
    [self LockInfoCmd:@"21"];
    
}

-(void)cheakLockStatus{
    [self LockInfoCmd:@"31"];
    
}

-(void)closeLock{
    
    [self LockInfoCmd:@"22"];
}

-(void)getUnloadInfo{
    [self LockInfoCmd:@"51"];
}

-(void)clearInfo{
    [self LockInfoCmd:@"52"];
}
-(void)LockInfoCmd:(NSString *)cmd{
    Byte data[11]={};
    data[0]=[self Num16:@"FE"];
    self.num = arc4random() %255;
    //self.num = 136;
    data[1] = [self Num16: [changeNumTool coverFromIntToHex:self.num+50]];
    for (int i =2;i<6;i++){
        [DB getStringById:@"uid" fromTable:tabName];

        data[i]=[self Num16:[[DB getStringById:@"uid" fromTable:tabName] substringWithRange:NSMakeRange((i-2)*2, 2)] ]^[self Num16: [changeNumTool coverFromIntToHex:self.num]];
    }
    data[6]= [self Num16:self.key]^[self Num16: [changeNumTool coverFromIntToHex:self.num]];
    data[7]= [self Num16:cmd] ^   [self Num16: [changeNumTool coverFromIntToHex:self.num]];
    data[8]= [self Num16:@"00"] ^ [self Num16: [changeNumTool coverFromIntToHex:self.num]];
    NSString *mingwen=@"";
    for(int i=0;i<9;i++){
        
        mingwen  =[mingwen   stringByAppendingString:[changeNumTool coverFromIntToHex:  data[i]]];
    }
    NSString * one = [[mingwen getCrcString] substringWithRange:NSMakeRange(0, 2)];
    NSString * two = [[mingwen getCrcString] substringWithRange:NSMakeRange(2, 2)];
    data[9] =[self Num16:one];
    data[10] = [self Num16:two];
    NSData * result = [NSData dataWithBytes:data length:11];
    [self.peripheral writeValue:result forCharacteristic:self.write type:CBCharacteristicWriteWithResponse];
}
-(Byte)Num16:(NSString *)str{
    const  char * c =[str UTF8String];
    
    Byte byte = (Byte)strtol(c, NULL, 16);
    return byte;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if(central.state==CBManagerStatePoweredOn){
        //扫描外设
        [self.mgr scanForPeripheralsWithServices:nil options:nil];
        self.mgr.delegate=self;
        
    }else{
        Toast(@"蓝牙未打开或其他问题请重新扫码");
        self.BlueTooth =NO;
    }
}
//连接外设
-(void)centralManager:(CBCentralManager *)central
didDiscoverPeripheral:(CBPeripheral *)peripheral
    advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                 RSSI:(NSNumber *)RSSI{
    

    if([peripheral.name hasPrefix:@"OmniBleLock"]){
        
        
        NSData * data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
        NSString * str  = [NSString stringWithFormat:@"%@",data];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
       
      
        str = [str substringWithRange:NSMakeRange(4, 12)];
        NSString * mac = self.macStr;
        mac = [mac  stringByReplacingOccurrencesOfString:@":" withString:@""];
        mac = [mac lowercaseString];
      

        if([str  isEqualToString: mac]){
        self.peripheral=peripheral;
        self.peripheral.delegate=self;
        [self.mgr connectPeripheral:peripheral options:nil];
       
         self.BlueTooth =YES;
        }
        
    }
    
    
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [peripheral discoverServices:nil];
    [self.mgr stopScan];
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    for(CBService * service in peripheral.services){
        
        if([service.UUID.UUIDString isEqualToString:@"0783B03E-8535-B5A0-7140-A304D2495CB7"]){
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for (CBCharacteristic *Characteristic in service.characteristics) {
     
        
        if([Characteristic.UUID.UUIDString isEqualToString:@"0783B03E-8535-B5A0-7140-A304D2495CB8"]){
            
            
            self.read = Characteristic ;
            [peripheral   setNotifyValue:YES forCharacteristic:self.read];
            [peripheral   readValueForCharacteristic:self.read];
            
        }
        if([Characteristic.UUID.UUIDString isEqualToString:@"0783B03E-8535-B5A0-7140-A304D2495CBA"]){
           self.write = Characteristic;
          [self getKey];
            
        }
    }
}


// 获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。更新特征的value的时候会调用 （凡是从蓝牙传过来的数据都要经过这个回调，简单的说这个方法就是你拿数据的唯一方法） 你可以判断是否

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
   
    self.data = characteristic.value;
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0783B03E-8535-B5A0-7140-A304D2495CB8"]]) {
        NSData * data = characteristic.value;
        
        Byte * resultByte = (Byte *)[data bytes];
        
        int keyNum =(resultByte[7]^(resultByte[1]-0x32));
        
        if(keyNum==0x11){
            //获取key
            self.key =[changeNumTool coverFromIntToHex:(resultByte[6]^(resultByte[1]-0x32))];
            if(self.key){
                [self cheakLockStatus];
                
            }
        }else if(keyNum==0x21){
            //开锁返回
            int lockStatus = (resultByte[9]^(resultByte[1]-0x32));
            if(lockStatus==0x00){
                 Toast(@"开锁成功");
            }else if(lockStatus==0x01){
                Toast(@"开锁失败");
            }
            
            
        }else if(keyNum==0x22){
            //关锁返回
            int lockStatus = (resultByte[9]^(resultByte[1]-0x32));
            if(lockStatus==0x00){
                Toast(@"关锁成功");
                [self getUnloadInfo];
                [self closeLock];
            }else if(lockStatus==0x01){
               Toast(@"关锁失败");
            }
        }else if(keyNum==0x31){
            //查询锁的状况
            int lockStatus = (resultByte[9]^(resultByte[1]-0x32));
            if(lockStatus==0x00){
                 Toast(@"处于开锁状态");
            }else if(lockStatus==0x01){
                 Toast(@"处于关锁状态");
                [self openLock];
            }
            int lockeleStatus = (resultByte[10]^(resultByte[1]-0x32));
            NSString * str = [NSString stringWithFormat:@"电量%fV",lockeleStatus/10.0];
            Toast(str);
            int lockinfoStatus = (resultByte[11]^(resultByte[1]-0x32));
            if(lockinfoStatus==0x00){
                NSLog(@"锁有数据未上传");
                [self getUnloadInfo];
            }else if(lockinfoStatus ==0x01){
                NSLog(@"无数据");
            }
            
        }else if(keyNum==0x51){
            //获取未上传的数据
            int a = (resultByte[9] ^(resultByte[1]-0x32));
            int b = (resultByte[10]^(resultByte[1]-0x32));
            int c = (resultByte[11]^(resultByte[1]-0x32));
            int d = (resultByte[12]^(resultByte[1]-0x32));
            int e = (resultByte[13]^(resultByte[1]-0x32));
            int f = (resultByte[14]^(resultByte[1]-0x32));
            int g = (resultByte[15]^(resultByte[1]-0x32));
            int h = (resultByte[16]^(resultByte[1]-0x32));
           
            NSString * time  = [NSString stringWithFormat:@"%x%x%x%x",a,b,c,d];
            NSString * uid = [NSString stringWithFormat:@"%x%x%x%x",e,f,g,h];
            
            [self loadupGprs];
            [self upBlueMac:uid   time:time];
            Toast(@"上传");
            [self clearInfo];
            
        }else if(keyNum==0x52){
            //清除未上传的数据
            int lockStatus = (resultByte[9]^(resultByte[1]-0x32));
            if(lockStatus==0x00){
                NSLog(@"成功清除");
                [self closeLock];
            }else if(lockStatus==0x01){
                NSLog(@"清除失败");
            }
        }
        //        for(int i=0;i<[data length];i++){
        //            NSLog(@"testByteFF02[%d] = %@\n",i, [changeNumTool coverFromIntToHex:resultByte[i]]);
        //        if(i==6){
        //
        //          }
        //       }
    }
    //    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0783B03E-8535-B5A0-7140-A304D2495CBA"]]) {
    //        NSData * data = characteristic.value;
    //        NSLog(@"%@",data);
    //        Byte * resultByte = (Byte *)[data bytes];
    //
    //        for(int i=0;i<[data length];i++)
    //            printf("testByteFF02[%d] = %d\n",i,resultByte[i]);
    //
    //    }
    
}
// 中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    // Notification has started
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    } else { // Notification has stopped
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        //  [self updateLog:[NSString stringWithFormat:@"Notification stopped on %@.  Disconnecting", characteristic]];
        [self.mgr cancelPeripheralConnection:self.peripheral];
    }
}

-(void)upBlueMac:(NSString * )mac time:(NSString *)time{
    [self requestType:HttpRequestTypePost url:nil
           parameters:@{ @"action" : @"loadData",
                         @"mac": self.macStr,//设备MAC
                        @"uid":mac,//设备用户ID
                        @"time":time//骑行时间（分钟）
                          }
         successBlock:
     ^(BaseModel *response) {
        
    } failureBlock:^(NSError *error) {
        
    }];
}

-(void)loadupGprs{
    __block CLLocationCoordinate2D coor;
    __block NSString * mac  =self.macStr;
    coor.latitude =[currentPosition.lat_gaode doubleValue];
    coor.longitude  = [currentPosition.lon_gaode doubleValue];
    WeakSelf(self);
    currentCoordinate = coor;
    
    [[ZXNLocationGaoDeManager sharedManager] getGps:^(NSString *lat, NSString *lon) {
        
        if(lat.length!=0&&lon.length!=0   ){
            coor.longitude = [lon doubleValue];
            coor.latitude =  [lat doubleValue];
            [weakself requestType:HttpRequestTypePost
                              url:nil
                       parameters:@{@"action" : @"gpsUpdate",
                                     @"mac":  mac,//设备MAC
                                     @"lat": lat,//经度
                                     @"lng": lon//纬度
                                     }
                     successBlock:^(BaseModel *response) {
                         if([response.status  isEqualToString:@"1"]){
                             NSLog(@"%@",response.errmsg);
                           [weakself   getLocationManagerAnnotationLat:lat Lng:lon ];
                         }
                
            }        failureBlock:^(NSError *error) {
                
            }];
           
        }
    }];
}
////用于检测中心向外设写数据是否成功
//-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//{
//
//
//    /* When a write occurs, need to set off a re-read of the local CBCharacteristic to update its value */
//    //[peripheral readValueForCharacteristic:characteristic];
//}
//
//
//
//
//
////扫描Descriptors
//-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//{
//    for (CBDescriptor * descriptor in characteristic.descriptors) {
//        NSLog(@"descriptor: %@",descriptor);
//        [peripheral readValueForDescriptor:descriptor];
//    }
//}
////获取Descriptors的值
//-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
//{
//    NSLog(@"Descriptors UUID: %@ value: %@",descriptor.UUID,[NSString stringWithFormat:@"%@",descriptor.value]);
//    //NSLog(@"已经向外设%@的特征值%@写入数据",peripheral.name,_readCharacteristic);
//}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"mac" object:nil];
}
@end
