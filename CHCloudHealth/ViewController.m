//
//  ViewController.m
//  HYQBaiduMapTest
//
//  Created by __无邪_ on 4/7/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>{
    BMKPointAnnotation* pointAnnotation;
    BMKCircle* circle;
}
@property (nonatomic, strong)BMKLocationService* locService;
@property (nonatomic, strong)BMKMapView* mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    //注：必须在BMKMapView对象初始化之前设置
    
    //    //个性化地图模板文件路径
    //
    //    NSString* path = [[NSBundle mainBundle] pathForResource:@"custom_config" ofType:@""];
    //
    //    //设置个性化地图样式
    //
    //    [BMKMapView customMapStyle:path];
    
    
    
    self.mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.view = self.mapView;
    
    
    
    
    //普通态
    //以下_mapView为BMKMapView对象
    self.mapView.showsUserLocation = YES;//显示定位图层
    //self.mapView.mapType = BMKMapTypeNone;//设置地图为空白类型
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    //启动LocationService
    [_locService startUserLocationService];
    
    
    
    //BOOL ptInCircle = BMKCircleContainsCoordinate(CLLocationCoordinate2DMake(39.918,116.408), CLLocationCoordinate2DMake(39.915,116.404), 1000);
    
    // 添加圆形覆盖物
    if (circle == nil) {
        CLLocationCoordinate2D coor;
        coor.latitude = 39.982269;
        coor.longitude = 116.500652;
        circle = [BMKCircle circleWithCenterCoordinate:coor radius:5000];
    }
    [self.mapView addOverlay:circle];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
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
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    
    [self.mapView updateLocationData:userLocation];
    
    [self addPointAnnotationWithCoor:userLocation.location.coordinate];
    
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







//添加标注
- (void)addPointAnnotationWithCoor:(CLLocationCoordinate2D)coor{
    if (pointAnnotation == nil) {
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = @"test";
        pointAnnotation.subtitle = @"此Annotation可拖拽!";
    }
    [_mapView addAnnotation:pointAnnotation];
}








@end
