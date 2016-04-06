//
//  CHStatisticsController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/5.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHStatisticsController.h"
#import "JRGraphView.h"

@interface CHStatisticsController ()

@property (nonatomic, strong)NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet JRGraphView *graphView;



@end

@implementation CHStatisticsController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addBackButton];
    [self setFullScreenPopGestureDisabled:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.dataArr = [[NSMutableArray alloc] init];
    
    for ( NSUInteger i = 0; i < 60; i++ ) {
        NSNumber *x = @(i);
        i = i + 1;
        NSNumber *y = @((arc4random() % 120) + 41);
        [self.dataArr addObject:@{ X_AXIS: x, Y_AXIS: y }];
    }
    
    [self.graphView.plotDatasDictionary setObject:self.dataArr forKey:kDataLine];
    [self.graphView setLowerwarningValue:86];
    [self.graphView setUpwarningValue:110];
    
    [self.graphView refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
