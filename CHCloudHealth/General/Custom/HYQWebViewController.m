//
//  HYQWebViewController.m
//  HYQuan
//
//  Created by fqah on 12/11/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import "HYQWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "FQAHPublicParameter.h"

@interface HYQWebViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation HYQWebViewController

#pragma mark - LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isNewNavigation == 1) {
        [self addLeftButton2NavWithImageName:@"cancel"];
    }else{
        [self addBackButton];
    }
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self loadGoogle];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action

- (void)backBarButtonPressed:(id)backBarButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)leftBarButtonPressed:(id)leftBarButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadButtonPushed:(id)sender{
    [self.webView reload];
}

-(void)loadGoogle{
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    self.urlStr = [self checkUrl:self.urlStr];
//    
//    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlStr]];
//    [self.webView loadRequest:req];
//    
    
    
    NSMutableDictionary *allparameters = [[NSMutableDictionary alloc] initWithDictionary:[FQAHPublicParameter publicParameter]];
    //在这里统一添加公共参数进来
    if (self.params) {
        for (NSString *key in [self.params allKeys]) {
            id value = [self.params objectForKey:key];
            [allparameters setObject:value forKey:key];
        }
    }
    NSDictionary *targetParameters;
    if (allparameters) {
        targetParameters = @{@"data":[allparameters jsonString]};
    }
    
    
    NSMutableArray *webViewParams = [NSMutableArray arrayWithObjects:
                                     @"data", [allparameters jsonString],
                                     
                                     nil];
    
    [self UIWebViewWithPost:self.webView url:self.urlStr params:webViewParams];
}


- (void)UIWebViewWithPost:(UIWebView *)uiWebView url:(NSString *)url params:(NSMutableArray *)params
{
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    [s appendString: [NSString stringWithFormat:@"<html><body onload=\"document.forms[0].submit()\">"
                      "<form method=\"post\" action=\"%@\">", url]];
    if([params count] % 2 == 1) { NSLog(@"UIWebViewWithPost error: params don't seem right"); return; }
    for (int i=0; i < [params count] / 2; i++) {
        [s appendString: [NSString stringWithFormat:@"<input type=\"hidden\" name=\"%@\" value=\"%@\" >\n", [params objectAtIndex:i*2], [params objectAtIndex:(i*2)+1]]];
    }
    [s appendString: @"</input></form></body></html>"];
    //NSLog(@"%@", s);
    [uiWebView loadHTMLString:s baseURL:nil];
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [_progressView setProgress:progress animated:YES];
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
}

#pragma mark - Private

- (NSString *)checkUrl:(NSString *)url{
    if ([url hasPrefix:@"www"]) {
        url = [NSString stringWithFormat:@"http://%@",self.urlStr];
    }
    return url;
}

#pragma mark - Configure

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}


@end
