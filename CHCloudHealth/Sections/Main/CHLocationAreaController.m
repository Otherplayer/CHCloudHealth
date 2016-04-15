//
//  CHLocationAreaController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/7.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHLocationAreaController.h"

@interface CHLocationAreaController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    BMKPointAnnotation* pointAnnotation;
    BMKCircle* circle;
}
//@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (nonatomic, strong)BMKMapView* mapView;
@property (nonatomic, strong)BMKLocationService* locService;
@property (nonatomic, strong)BMKGeoCodeSearch* geocodesearch;
@property (strong, nonatomic)UIButton *btnLocation;
@property (strong, nonatomic)UIButton *btnRoad;
@property (assign, nonatomic)BMKCoordinateRegion viewRegion;

@end

@implementation CHLocationAreaController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    
    [self setFullScreenPopGestureDisabled:YES];
    
    [self setTitle:@"位置区域"];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
    //初始化BMKLocationService
    self.locService.delegate = self;
    //启动LocationService
    [self.locService startUserLocationService];
    
    self.view = self.mapView;
    self.mapView.delegate = self;
    [self.view addSubview:self.btnLocation];
    [self.view addSubview:self.btnRoad];
    
    
    [self.mapView setShowMapScaleBar:YES];//设定是否显式比例尺
    [self.mapView setShowsUserLocation:YES];//显示定位图层
    [self.mapView setUserTrackingMode:BMKUserTrackingModeFollow];
    [self.mapView setZoomLevel:16];

    

    //[self getDatas];
    
}


#pragma mark -

- (void)getDatas{
    
    [[NetworkingManager sharedManager] getLocationInfo:[CHUser sharedInstance].deviceUserId date:@"2016-4-11" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
 
        });
    }];
    
}
- (void)startLocationAction:(id)sender {
    BMKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:self.viewRegion];
//    [self.mapView setRegion:adjustedRegion animated:YES];
    [self.mapView setCenterCoordinate:adjustedRegion.center animated:YES];
}
- (void)startRoadAction:(id)sender{
    
}

- (void)shouldStartLocation:(id)sender{
    [self.locService startUserLocationService];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.locService.delegate = self;
    self.geocodesearch.delegate = self;
    self.mapView.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    _mapView.delegate = nil; // 不用时，置nil
}

#pragma mark -
#pragma mark implement BMKMapViewDelegate
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    NSLog(@"%s",__func__);
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    [self.mapView updateLocationData:userLocation];
    [self addPointAnnotationWithCoor:userLocation.location.coordinate];
    self.viewRegion = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.02f,0.02f));
    
    
    
    //[self startTrailRouteWithUserLocation:userLocation];
    
    //[self.locService stopUserLocationService];
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self facha:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
}



//添加标注
- (void)addPointAnnotationWithCoor:(CLLocationCoordinate2D)coor{
    if (pointAnnotation == nil) {
        pointAnnotation = [[BMKPointAnnotation alloc]init];
    }
    pointAnnotation.coordinate = coor;
    [_mapView addAnnotation:pointAnnotation];
}

/**
 *  开始记录轨迹
 *
 *  @param userLocation 实时更新的位置信息
 */
- (void)startTrailRouteWithUserLocation:(BMKUserLocation *)userLocation{
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
}


#pragma mark - BMKGeoCodeSearchDelegate
//根据位置反差
-(void)facha:(float)latitude longitude:(float)longitude{
    
    CLLocationCoordinate2D startPt;
    startPt.latitude=latitude;
    startPt.longitude=longitude;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = startPt;
    
    self.geocodesearch.delegate = self;
    
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"反Geo失败：%@",@(error));
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    
//    NSString *detail = [NSString stringWithFormat:@"%@%@%@",result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
    pointAnnotation.title = result.address;
//    pointAnnotation.subtitle = detail;
    
//    NSLog(@"%@",    result.addressDetail);
//    NSLog(@"%@",    result.address);
//    NSLog(@"%@",    result.businessCircle);
//    NSLog(@"%@",    result.poiList);
//    for (BMKPoiInfo *model in result.poiList) {
//        NSLog(@"%@--%@",model.address,model.name);
//    }
//    
//    NSLog(@"详细信息%@省%@市%@区",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district);
//    NSLog(@"本函数 是 解析地址demo   用什么自己取就好了");
}








#pragma mark - Configure

- (BMKLocationService *)locService{
    if (!_locService) {
        _locService = [[BMKLocationService alloc] init];
    }
    return _locService;
}

- (BMKGeoCodeSearch *)geocodesearch{
    if (!_geocodesearch) {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    }
    return _geocodesearch;
}

- (BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    }
    return _mapView;
}

- (UIButton *)btnLocation{
    if (!_btnLocation) {
        _btnLocation = [[UIButton alloc] initWithFrame:CGRectMake(20, kMainHeight - 120, 40, 40)];
        [_btnLocation setImage:[UIImage imageNamed:@"ios_location2"] forState:UIControlStateNormal];
        [_btnLocation addTarget:self action:@selector(startLocationAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLocation;
}
- (UIButton *)btnRoad{
    if (!_btnRoad) {
        _btnRoad = [[UIButton alloc] initWithFrame:CGRectMake(20, kMainHeight - 120 - 60, 40, 40)];
        [_btnRoad setImage:[UIImage imageNamed:@"ios_location3"] forState:UIControlStateNormal];
        [_btnRoad addTarget:self action:@selector(startRoadAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRoad;
}




@end
