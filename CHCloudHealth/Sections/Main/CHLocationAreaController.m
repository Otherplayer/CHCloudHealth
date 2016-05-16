//
//  CHLocationAreaController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/7.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHLocationAreaController.h"
#import "HYQDatePickerView.h"

@interface CHLocationAreaController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    BMKPointAnnotation* pointAnnotation;
    BMKCircle* circle;
    BMKPolyline* colorfulPolyline;
}
//@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (nonatomic, strong)BMKMapView* mapView;
@property (nonatomic, strong)BMKLocationService* locService;
@property (nonatomic, strong)BMKGeoCodeSearch* geocodesearch;
@property (strong, nonatomic)UIButton *btnLocation;
@property (strong, nonatomic)UIButton *btnRoad;
@property (assign, nonatomic)BMKCoordinateRegion viewRegion;

@property (strong, nonatomic)NSString *selectedDate;
@property (nonatomic, strong)NSMutableArray *dataArr;


/** 位置数组 */
@property (nonatomic, strong) NSMutableArray *locationArrayM;

/** 轨迹线 */
@property (nonatomic, strong) BMKPolyline *polyLine;




@end

@implementation CHLocationAreaController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    
    [self setFullScreenPopGestureDisabled:YES];
    
    [self setTitle:@"位置区域"];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.mapView.backgroundColor = [UIColor whiteColor];
    self.dataArr = [[NSMutableArray alloc] init];
    
    //初始化BMKLocationService
    self.locService.delegate = self;
    //启动LocationService
    [self.locService setDistanceFilter:10];
    [self.locService setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locService startUserLocationService];
    
    self.view = self.mapView;
    self.mapView.delegate = self;
    [self.view addSubview:self.btnLocation];
    [self.view addSubview:self.btnRoad];
    
    
    [self.mapView setShowMapScaleBar:YES];//设定是否显式比例尺
    [self.mapView setShowsUserLocation:YES];//显示定位图层
    [self.mapView setUserTrackingMode:BMKUserTrackingModeFollow];
    [self.mapView setZoomLevel:16];
    
    
    
    self.selectedDate = [NSString stringWithFormat:@"%@",[[NSDate date] descriptionWithFormatter:@"yyyy-MM-dd"]];
    
    
    
    [self getDatas];
    
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)refreshLine{
    //添加折线(分段颜色绘制)覆盖物
//    [self.mapView removeOverlays:_mapView.overlays];
    [self.mapView removeOverlay:colorfulPolyline];
    if (self.dataArr.count == 0) {
        return;
    }
    
    
    CLLocationCoordinate2D coords[self.dataArr.count];
    for (int i = 0; i < self.dataArr.count; i++) {
        
        NSDictionary *info = self.dataArr[i];
        double latitude = [info[@"latitude"] floatValue];
        double longitude = [info[@"longitude"] floatValue];
        
        coords[i].latitude = latitude;
        coords[i].longitude = longitude;
    }
    
//    coords[0].latitude = 39.965;
//    coords[0].longitude = 116.404;
//    coords[1].latitude = 39.925;
//    coords[1].longitude = 116.454;
//    coords[2].latitude = 39.955;
//    coords[2].longitude = 116.494;
//    coords[3].latitude = 39.905;
//    coords[3].longitude = 116.554;
//    coords[4].latitude = 39.965;
//    coords[4].longitude = 116.604;
    //构建分段颜色索引数组
    NSArray *colorIndexs = [NSArray arrayWithObjects:@0, nil];
    
    //构建BMKPolyline,使用分段颜色索引，其对应的BMKPolylineView必须设置colors属性
    colorfulPolyline = [BMKPolyline polylineWithCoordinates:coords count:self.dataArr.count textureIndex:colorIndexs];
    //    if (colorfulPolyline == nil) {
    //    }
    [self.mapView addOverlay:colorfulPolyline];
    [self.mapView setCenterCoordinate:coords[0] animated:YES];
    
}


- (void)refresCircle:(NSDictionary *)info{
    [self.mapView removeOverlay:circle];
    double latitude = [info[@"lat"] floatValue];
    double longitude = [info[@"lng"] floatValue];
    double radius = [info[@"radius"] floatValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    circle = [BMKCircle circleWithCenterCoordinate:coordinate radius:radius];
    [self.mapView addOverlay:circle];
}


#pragma mark -

- (void)getDatas{
//    
//    [[NetworkingManager sharedManager] setSafeArea:[CHUser sharedInstance].deviceId lng:@"39" lat:@"119" radius:@"100" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
//        
//    }];
    
    [[NetworkingManager sharedManager] getSafeArea:[CHUser sharedInstance].deviceId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                NSDictionary *info = responseData[@"data"];
                [self refresCircle:info];
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
            
        });
    }];
    
    
    [[NetworkingManager sharedManager] getLocationInfo:[CHUser sharedInstance].deviceUserId date:self.selectedDate completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self.dataArr removeAllObjects];
                [self.dataArr addObjectsFromArray:responseData[@"data"]];
                if (self.dataArr.count == 0) {
                    [HYQShowTip showTipTextOnly:[NSString stringWithFormat:@"%@无轨迹记录",self.selectedDate] dealy:2];
                }else{
                    [HYQShowTip hideImmediately];
                }
                [self refreshLine];
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
 
        });
    }];
    
}





- (void)startLocationAction:(id)sender {
    
    [HYQShowTip showProgressWithText:@"位置更新中，请稍后..." dealy:60];
    [[NetworkingManager sharedManager] sendCurrentLocation:[CHUser sharedInstance].deviceId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        if (success) {
            [HYQShowTip showTipTextOnly:@"发送实时位置检测成功" dealy:2];
            
            
            [[NetworkingManager sharedManager] getCurrentLocation:[CHUser sharedInstance].deviceUserId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
                if (success) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSDictionary *info = responseData[@"data"];
                        
                        double latitude = [info[@"latitude"] floatValue];
                        double longitude = [info[@"longitude"] floatValue];
                        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
                        
                        [self.mapView setCenterCoordinate:coordinate animated:YES];
                       
                        [self addPointAnnotationWithCoor:coordinate];
                        
                    });
                    
                }
            }];
            
        }else{
            [HYQShowTip showTipTextOnly:errDesc dealy:2];
        }
    }];
    
    
//    BMKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:self.viewRegion];
////    [self.mapView setRegion:adjustedRegion animated:YES];
//    [self.mapView setCenterCoordinate:adjustedRegion.center animated:YES];
}
- (void)startRoadAction:(id)sender{
    [self showDateAction:nil];
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
    [HYQShowTip hideImmediately];
}

#pragma mark -
#pragma mark implement BMKMapViewDelegate
//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    
    
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.lineWidth = 5;
        /// 使用分段颜色绘制时，必须设置（内容必须为UIColor）
        polylineView.colors = [NSArray arrayWithObjects:
                               [UIColor defaultColor],
                               [UIColor defaultColor],
                               [UIColor defaultColor], nil];
        return polylineView;
    }else if ([overlay isKindOfClass:[BMKCircle class]]){
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor alloc] initWithRed:0.400 green:1.000 blue:0.400 alpha:0.247];
        circleView.strokeColor = [[UIColor alloc] initWithRed:0.400 green:1.000 blue:0.400 alpha:1.000];
        circleView.lineWidth = 1.0;
        
        return circleView;
    }
    
    
    return nil;
}
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
// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}
// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    NSString *AnnotationViewID = @"renameMark";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        // 设置可拖拽
        annotationView.draggable = YES;
    }
    return annotationView;
}

#pragma mark - 

- (IBAction)showDateAction:(id)sender {
    WS(weakSelf);
    HYQDatePickerView *datePicker = [[HYQDatePickerView alloc] init];
    [datePicker setDidClickedOkAction:^(NSString *result) {
        weakSelf.selectedDate = result;
        [weakSelf getDatas];
    }];
    [datePicker showInView:self.view withSelectDate:self.selectedDate timeOnly:YES];
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
