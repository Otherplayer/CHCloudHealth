//
//  JRGraphView.h
//  JRPlot
//
//  Created by __无邪_ on 15/1/29.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CorePlot-CocoaTouch.h>
//#import <CorePlot-CocoaTouch.h>

static NSString *const X_AXIS = @"x";
static NSString *const Y_AXIS = @"y";

static NSString *const kDataLine    = @"Data Line";
static NSString *const kDataLineLast = @"Data Line Last";
static NSString *const kDashDataLine = @"Dash Data Line";
static NSString *const kWarningUpLine = @"Warning Up Line";
static NSString *const kWarningLowerLine = @"Warning Lower Line";



@interface JRGraphView : UIView

@property (nonatomic, strong)NSMutableDictionary *plotDatasDictionary;
@property (nonatomic, unsafe_unretained)CGFloat upwarningValue;
@property (nonatomic, unsafe_unretained)CGFloat lowerwarningValue;
- (void)refresh;

@end
