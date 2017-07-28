//
//  TestModel.h
//  ZJKits
//
//  Created by jianz3 on 2017/7/27.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *_userId;


@end

@interface TestModel : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *_name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) NSInteger age;

@property (nonatomic, strong) UserModel *_user; ///< 模型中嵌套UserModel模型
@property (nonatomic, strong) NSArray <UserModel *> *arrUsers; ///<模型中嵌套UserModel模型数组


@end

