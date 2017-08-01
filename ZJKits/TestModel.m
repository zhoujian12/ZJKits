//
//  TestModel.m
//  ZJKits
//
//  Created by jianz3 on 2017/7/27.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "TestModel.h"
#import "NSObject+ZJDicModelTransform.h"

@implementation TestModel

+ (instancetype)initManagerWithDic:(NSDictionary *)dic{
    // 属性名称替换方法一
    NSDictionary *optionDic = @{@"_id":@"id",
                                @"_name":@"name",
                                @"_user":@"user",
                                @"_userId":@"userId",
                                @"_userName":@"userName"
                                };
    TestModel *model  = [TestModel zj_initWithDictionary:dic optionalAttributesDic:optionDic];
    return model;
}


+ (NSDictionary *)zj_objectClassInArray{
    return @{@"arrUsers2":@"UserModel2", @"arrUsers":@"UserModel"};
}

// 属性名称替换方法二
//+(NSDictionary *)zj_propertykeyReplacedWithValue{
//    return @{@"_id":@"id",
//             @"_name":@"name",
//             @"_user":@"user",
//             @"_userId":@"userId"
//             };
//}

@end

@implementation UserModel

// 属性名称替换方法二
//+(NSDictionary *)zj_propertykeyReplacedWithValue{
//    return @{
//             @"_userId":@"userId"
//             };
//}

@end

@implementation UserModel2


@end
