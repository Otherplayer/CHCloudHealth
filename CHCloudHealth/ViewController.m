//
//  ViewController.m
//  HYQBaiduMapTest
//
//  Created by __无邪_ on 4/7/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    BMKPointAnnotation* pointAnnotation;
    BMKCircle* circle;
}
@property (nonatomic, strong)BMKLocationService* locService;
@property (nonatomic, strong)BMKMapView* mapView;
@property (nonatomic, strong)BMKGeoCodeSearch* geocodesearch;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    //初始化BMKLocationService
    self.locService.delegate = self;
    //启动LocationService
    [self.locService startUserLocationService];
    
    
    
    
    
    self.mapView.delegate = self;
    self.view = self.mapView;
    
    
    [self.mapView setShowMapScaleBar:YES];//设定是否显式比例尺
    [self.mapView setShowsUserLocation:YES];//显示定位图层
    [self.mapView setUserTrackingMode:BMKUserTrackingModeFollow];
    [self.mapView setZoomLevel:16];
    
    
    UIButton *btnLocationSelf = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    [btnLocationSelf setTitle:@"定位" forState:UIControlStateNormal];
    [btnLocationSelf setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:btnLocationSelf];
    [btnLocationSelf addTarget:self action:@selector(shouldStartLocation:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)shouldStartLocation:(id)sender{
    [self.locService startUserLocationService];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    _mapView.delegate = nil; // 不用时，置nil
}

#pragma mark -
#pragma mark implement BMKMapViewDelegate
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    NSLog(@"%s",__func__);
}
//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor alloc] initWithRed:0.400 green:1.000 blue:0.400 alpha:0.247];
        circleView.strokeColor = [[UIColor alloc] initWithRed:0.400 green:1.000 blue:0.400 alpha:1.000];
        circleView.lineWidth = 1.0;
        
        return circleView;
    }
    
    return nil;
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
    
    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.02f,0.02f));
    BMKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    [self facha:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    
    [self startTrailRouteWithUserLocation:userLocation];
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self facha:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
}



//添加标注
- (void)addPointAnnotationWithCoor:(CLLocationCoordinate2D)coor{
    if (pointAnnotation == nil) {
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        pointAnnotation.title = @"test";
        pointAnnotation.subtitle = @"此Annotation可拖拽!";
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
    
    NSLog(@"%@",    result.addressDetail);
    NSLog(@"%@",    result.address);
    NSLog(@"%@",    result.businessCircle);
    NSLog(@"%@",    result.poiList);
    for (BMKPoiInfo *model in result.poiList) {
        NSLog(@"%@--%@",model.address,model.name);
    }
    
    NSLog(@"详细信息%@省%@市%@区",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district);
    NSLog(@"本函数 是 解析地址demo   用什么自己取就好了");
}








#pragma mark - Configure

- (BMKLocationService *)locService{
    if (!_locService) {
        _locService = [[BMKLocationService alloc] init];
    }
    return _locService;
}


- (BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    }
    return _mapView;
}


- (BMKGeoCodeSearch *)geocodesearch{
    if (!_geocodesearch) {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    }
    return _geocodesearch;
}




@end
