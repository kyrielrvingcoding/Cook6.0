//
//  HomeWebViewController.m
//  Cook
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeWebViewController.h"

@interface HomeWebViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *contentString;

@end

@implementation HomeWebViewController

- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
  
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_URL]];
        [_webView loadRequest:request];
        
        _webView.scalesPageToFit = YES;
        [LoadingDataAnimation stopAnimation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [LoadingDataAnimation startAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
