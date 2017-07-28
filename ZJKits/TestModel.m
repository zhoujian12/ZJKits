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

+ (NSDictionary *)zj_objectClassInArray{
    return @{@"arrUsers":@"UserModel"};
}

+(NSDictionary *)zj_propertykeyReplacedWithValue{
    return @{@"_id":@"id",
             @"_name":@"name",
             @"_user":@"user",
             @"_userId":@"userId"
             };
}

@end

@implementation UserModel

+(NSDictionary *)zj_propertykeyReplacedWithValue{
    return @{
             @"_userId":@"userId"
             };
}

@end
