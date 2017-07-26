//
//  ViewController.m
//  ZJKits
//
//  Created by jianz3 on 2017/5/13.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "ViewController.h"
#import "ZJCocoa.h"
#import "NSArray+Log.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRedColor;
    NSMutableArray *dataArr = nil;
    
    NSLog(@"dataArr : %@",dataArr);
    
    NSString *str = [self htmlWithUrlString:@"https://www.budejie.com"];
    NSLog(@"str : %@",str);

}


- (NSString *)htmlWithUrlString:(NSString *)urlString {
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSError *error = nil;
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
        return nil;
    }
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
//    NSURLSessionDataTask *sessionTask = [NSURLSession dataTaskWithRequest: completionHandler:];
    NSString *backStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    /**
                                   第一次过滤正则
                                   
                                   截取取内容符合 <div id="article_list" class="list">...</div> 格式的字符串
                                   */
//    NSString *firstPattern = [NSString stringWithFormat:@"<a  href=\"/video/\">(.*?)</a>"];
    NSString *firstPattern = [NSString stringWithFormat:@"<a  href=(.*?)</a>"];

    
    NSString *content = [backStr firstMatchWithPattern:firstPattern];
    
    return content;
}



@end
