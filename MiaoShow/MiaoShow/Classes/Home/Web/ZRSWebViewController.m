//
//  ZRSWebViewController.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/4/6.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSWebViewController.h"

@interface ZRSWebViewController ()

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation ZRSWebViewController

- (UIWebView *)webView {
    if (_webView) {
        UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:web];
        _webView = web;
    }
    return _webView;
}

- (instancetype)initWithUrlStr:(NSString *)url {
    if (self = [super init]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
