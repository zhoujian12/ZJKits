//
//  TestModel.h
//  ZJKits
//
//  Created by jianz3 on 2017/7/27.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *_userName;
@property (nonatomic, copy) NSString *_userId;

@end


@interface UserModel2 : NSObject

@property (nonatomic, copy) NSString *_userName;
@property (nonatomic, copy) NSString *userAge;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) BOOL isShowView;
@property (nonatomic, assign) CGFloat viewHeight;

@end

@interface TestModel : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *_name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL isShowView;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) NSTimeInterval  updateTime;


@property (nonatomic, strong) UserModel *_user; ///< 模型中嵌套UserModel模型
@property (nonatomic, strong) UserModel2 *_user2;
@property (nonatomic, strong) NSArray <UserModel *> *arrUsers; ///<模型中嵌套UserModel模型数组
@property (nonatomic, strong) NSArray <UserModel2 *> *arrUsers2; ///<模型中嵌套UserModel模型数组

/*
 dic 为需要解析的json字典
 */
+ (instancetype)initManagerWithDic:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
