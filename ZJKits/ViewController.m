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
#import "NSObject+ZJDicModelTransform.h"
#import "TestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
}

- (void)setUpView{
    self.view.backgroundColor = kRedColor;
    
    //网络请求
//    [self startNetWork];
    
    //字典转模型
    [self jsonToModelMethod];
}

- (void)startNetWork{
    [self htmlWithUrlString:@"https://www.budejie.com"];
}


- (void)htmlWithUrlString:(NSString *)urlString {
    //http://blog.csdn.net/olive1993/article/details/52036755 [@"!*'();:@&=+ $,/?%#[]" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];  //编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
        return;
    }
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *backStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        /**第一次过滤正则，截取取内容符合 <div id="article_list" class="list">...</div> 格式的字符串*/
        //    NSString *firstPattern = [NSString stringWithFormat:@"<a  href=\"/video/\">(.*?)</a>"];
        NSString *firstPattern = [NSString stringWithFormat:@"<a  href=(.*?)</a>"];
        NSString *content = [backStr firstMatchWithPattern:firstPattern];
        NSLog(@"str : %@",content);

    }];
    
    [sessionTask resume];
}

- (void)jsonToModelMethod{
    self.title = @"字典转模型";
    
    NSDictionary *dicTest = @{
                              @"id":@"121",
                              @"name":@"张三",
                              @"phone":@110,
                              @"age":@"10",
                              @"user":@{@"userId":@"2",@"userName":@"zhoujian"},
                              @"arrUsers":@[@{@"userId":@"2"},@{@"userId":@"3"},@{@"userId":@"4"}],
                              @"arrUsers2":@[@{@"userName":@"zhangSan"},@{@"userName":@"26"},@{@"userName":@"666"}]
                              };
    
    TestModel *model = [TestModel initManagerWithDic:dicTest];
    
    NSLog(@"model-----id:%@,  name:%@, phone:%@, address:%@, age:%@ , userId:%@, userName: %@ ",model._id, model._name, model.phone, model.address, @(model.age),model._user._userId,model._user._userName);
    [model.arrUsers enumerateObjectsUsingBlock:^(UserModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"arrUser----userId:%@", obj._userId);
    }];
    
    [model.arrUsers2 enumerateObjectsUsingBlock:^(UserModel2 *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"arrUser2----userName:%@ %@ %@", obj._userName,obj.userAge,obj.userId);
    }];
    
}
@end
