//
//  HYQHealthReportController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/6.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHHealthReportController.h"
#import "CMMessageCell.h"
#import "FQAHPublicParameter.h"
#import "HYQWebViewController.h"

@interface CHHealthReportController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation CHHealthReportController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    
    self.datas = [[NSMutableArray alloc] init];
    
    [self.tableView blankTableFooterView];
    self.tableView.descriptionText = @"还没有健康报告哦";
    self.tableView.loadedImageName = @"ios_icon_17";
    
    self.tableView.loading = YES;
    [self getDatas];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    
}


#pragma mark -

- (void)getDatas{
    
    if ([self canGo]) {
        
        [HYQShowTip showProgressWithText:@"" dealy:30];
        [[NetworkingManager sharedManager] getHealthRecordInfo:[CHUser sharedInstance].deviceUserId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    self.tableView.loading = NO;
                    [self.datas removeAllObjects];
                    NSArray *results = responseData[@"data"];
                    [self.datas addObjectsFromArray:results];
                    [self.tableView reloadData];
                    [HYQShowTip hideImmediately];
                }else{
                    self.tableView.loading = NO;
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
                
            });
        }];
        
    }
    
}


#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.datas[indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@",info[@"name"]];
//    NSString *detail = [NSString stringWithFormat:@"%@",info[@"content"]];
//    NSString *name = [NSString stringWithFormat:@"%@",info[@"name"]];
    static NSString *identifierHealthReportCell = @"IdentifierHealthReportCell";
    CMMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierHealthReportCell forIndexPath:indexPath];
    [cell configureTitle:title detail:@"" name:@""];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.datas[indexPath.row];
    NSString *healthDetailId = info[@"healthRecordId"];
    
    HYQWebViewController *controller = [[HYQWebViewController alloc] init];
    controller.urlStr = HOTYQ_JAVA_API @"deviceUser/getHealthRecordDetail";
    controller.params = @{@"healthRecordId":healthDetailId};
    [self.navigationController pushViewController:controller animated:YES];
    
////    [[NetworkingManager sharedManager] getHealthRecordDetailInfo:healthDetailId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
////        if (success) {
////            
////        }else{
////            [HYQShowTip showTipTextOnly:errDesc dealy:2];
////        }
////    }];
//    
//    
//
////    
////    NSString *body = [NSString stringWithFormat:@"data=%@",[allparameters jsonString]];
////    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//////    request.HTTPMethod = request.HTTPMethod;
//////    request.HTTPBody = request.HTTPBody;
////    [request setHTTPMethod: @"POST"];
////    [request setHTTPBody: [body dataUsingEncoding:NSUTF8StringEncoding]];
////    webView.delegate = self;
////    [webView loadRequest: request];
//    
//    
//    NSMutableArray *webViewParams = [NSMutableArray arrayWithObjects:
//                                     @"data", [allparameters jsonString],
//                                    
//                                     nil];
//    
//    [self UIWebViewWithPost:webView url:[NSString stringWithFormat:@"%@",url] params:webViewParams];
    
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    
//    return YES;
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
//    NSLog(@"Error%@",error);
//}
//- (void)UIWebViewWithPost:(UIWebView *)uiWebView url:(NSString *)url params:(NSMutableArray *)params
//{
//    NSMutableString *s = [NSMutableString stringWithCapacity:0];
//    [s appendString: [NSString stringWithFormat:@"<html><body onload=\"document.forms[0].submit()\">"
//                      "<form method=\"post\" action=\"%@\">", url]];
//    if([params count] % 2 == 1) { NSLog(@"UIWebViewWithPost error: params don't seem right"); return; }
//    for (int i=0; i < [params count] / 2; i++) {
//        [s appendString: [NSString stringWithFormat:@"<input type=\"hidden\" name=\"%@\" value=\"%@\" >\n", [params objectAtIndex:i*2], [params objectAtIndex:(i*2)+1]]];
//    }
//    [s appendString: @"</input></form></body></html>"];
//    //NSLog(@"%@", s);
//    [uiWebView loadHTMLString:s baseURL:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
