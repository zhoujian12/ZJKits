//
//  NSObject+ZJDicModelTransform.m
//  ZJKits
//
//  Created by jianz3 on 2017/7/27.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "NSObject+ZJDicModelTransform.h"
#import <objc/runtime.h>
static NSString *const ZJClassType_object  =   @"对象类型";
static NSString *const ZJClassType_basic   =   @"基础数据类型";
static NSString *const ZJClassType_other   =   @"其它";


@implementation NSObject (ZJDicModelTransform)

#pragma mark - 字典转模型
+ (instancetype)zj_initWithDictionary:(NSDictionary *)dic  optionalAttributesDic:(NSDictionary<NSString *, NSString *> *)optionalAttributes{
    id myObj = [[self alloc]init];
    
    unsigned int propertyCount;
    
    //获取类中的所有成员属性
    objc_property_t *arrPropertys = class_copyPropertyList([self class], &propertyCount);
    
    for (NSInteger i = 0; i < propertyCount; i++) {
        //objc_property_t是表示Objective-C声明的属性的类型，其实际是指向objc_property结构体的指针
        objc_property_t property = arrPropertys[i];
        
        //获取属性名字字符串
        //model中的属性名
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        //字典中的属性名
        /* 1.使用zj_propertykeyReplacedWithValue类方法进行替换
           2.optionalAttributes 字典属性进行替换
         */
        NSString *newPropertyName = propertyName;;
        
        if ([self respondsToSelector:@selector(zj_propertykeyReplacedWithValue)] || [optionalAttributes count]) {
            
            NSDictionary  *newPropertyNameDic = [optionalAttributes count] ? optionalAttributes : [self zj_propertykeyReplacedWithValue];
                
            newPropertyName = [newPropertyNameDic objectForKey:propertyName];
            
            if (!newPropertyName)
                newPropertyName = propertyName;
            
            NSLog(@"属性名:%@", newPropertyName);
        }
        
        id propertyValue = dic[newPropertyName];
        
        if (propertyValue == nil) {
            continue;
        }
        
        //获取属性是什么类型的
        NSDictionary *dicPropertyType = [self propertyTypeFromProperty:property];
        NSString *propertyClassType = [dicPropertyType objectForKey:@"classType"];
        NSString *propertyType = [dicPropertyType objectForKey:@"type"];
        
        if ([propertyType isEqualToString:ZJClassType_object]) {
            if ([propertyClassType isEqualToString:@"NSArray"] || [propertyClassType isEqualToString:@"NSMutableArray"]) {
                //数组类型，现在还用不了，因为还没有方法知道数组中保存的是什么类型，后面会处理
                
                //数组类型
                if ([self respondsToSelector:@selector(zj_objectClassInArray)]) {
                    id propertyValueType = [[self zj_objectClassInArray] objectForKey:propertyName];
                    
                    if ([propertyValueType isKindOfClass:[NSString class]]) {
                        propertyValue = [NSClassFromString(propertyValueType) zj_initWithArray:propertyValue optionalAttributesDic:optionalAttributes];
                    }else{
                        propertyValue = [propertyValueType zj_initWithArray:propertyValue optionalAttributesDic:optionalAttributes];
                    }
                    
                    if (propertyValue != nil) {
                        [myObj setValue:propertyValue forKey:propertyName];
                    }
                    
                }
                
            }
            else if ([propertyClassType isEqualToString:@"NSDictionary"] || [propertyClassType isEqualToString:@"NSMutableDictionary"]) {
                //字典类型   不考虑，一般不会用字典，用自定义model
                
            }
            else if ([propertyClassType isEqualToString:@"NSString"]) {
                //字符串类型
                if (propertyValue != nil) {
                    [myObj setValue:propertyValue forKey:propertyName];
                }
            }
            else {
                //自定义类型,循环调用，一直到不是自定义类型
                propertyValue = [NSClassFromString(propertyClassType) zj_initWithDictionary:propertyValue optionalAttributesDic:optionalAttributes];
                if (propertyValue != nil) {
                    [myObj setValue:propertyValue forKey:propertyName];
                }
            }
        }
        else if ([propertyType isEqualToString:ZJClassType_basic]) {
            //基本数据类型
            if ([propertyClassType isEqualToString:@"c"]) {
                //bool类型
                NSString *lowerValue = [propertyValue lowercaseString];
                if ([lowerValue isEqualToString:@"yes"] || [lowerValue isEqualToString:@"true"]) {
                    propertyValue = @(YES);
                } else if ([lowerValue isEqualToString:@"no"] || [lowerValue isEqualToString:@"false"]) {
                    propertyValue = @(NO);
                }
            }
            else {
                propertyValue = [[[NSNumberFormatter alloc] init] numberFromString:propertyValue];
            }
            
            if (propertyValue != nil) {
                [myObj setValue:propertyValue forKey:propertyName];
            }
        }
        else {
            //其他类型
            NSLog(@"--------propertyType 为其他类型 ,请联系 周健 QQ：931234635");
        }
    }
    
    free(arrPropertys);
    
    return myObj;
}

#pragma mark - 处理数组
+ (instancetype)zj_initWithArray:(NSArray *)arr optionalAttributesDic:(NSDictionary<NSString *, NSString *> *)optionalAttributes{
    NSAssert([arr isKindOfClass:[NSArray class]], @"不是数组");
    
    NSMutableArray *arrmodels = [NSMutableArray array];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [arrmodels addObject:[self zj_initWithArray:obj optionalAttributesDic:optionalAttributes]];
        }else{
            id model = [self zj_initWithDictionary:obj optionalAttributesDic:optionalAttributes];
            [arrmodels addObject:model];
        }
    }];
    
    return arrmodels;
}

#pragma mark - 获取属性的类型
- (NSDictionary *)propertyTypeFromProperty:(objc_property_t )property{
    NSString *propertyAttrs = @(property_getAttributes(property));
    
    NSMutableDictionary *dicPropertyType = [NSMutableDictionary dictionary];
    
    NSRange commaRage = [propertyAttrs rangeOfString:@","];
    NSString *propertyType =  [propertyAttrs substringWithRange:NSMakeRange(1, commaRage.location - 1)];
    NSLog(@"属性类型:%@, %@", propertyAttrs, propertyType);
    
    if ([propertyType hasPrefix:@"@"] && propertyType.length > 2) {
        NSString *propertyClassType = [propertyType substringWithRange:NSMakeRange(2, propertyType.length - 3)];
        [dicPropertyType setObject:propertyClassType forKey:@"classType"];
        [dicPropertyType setObject:ZJClassType_object forKey:@"type"];

    }
    else if ([propertyType isEqualToString:@"q"]) {
        //NSInteger类型
        [dicPropertyType setObject:@"NSInteger" forKey:@"classType"];
        [dicPropertyType setObject:ZJClassType_basic forKey:@"type"];
    }
    else if ([propertyType isEqualToString:@"d"]) {
        //CGFloat类型
        [dicPropertyType setObject:@"CGFloat" forKey:@"classType"];
        [dicPropertyType setObject:ZJClassType_basic forKey:@"type"];
    }

    else if ([propertyType isEqualToString:@"c"]) {
        //BOOL类型
        [dicPropertyType setObject:@"BOOL" forKey:@"classType"];
        [dicPropertyType setObject:ZJClassType_basic forKey:@"type"];
    }
    else {
        [dicPropertyType setObject:ZJClassType_other forKey:@"type"];
    }
    return dicPropertyType;
}
@end
