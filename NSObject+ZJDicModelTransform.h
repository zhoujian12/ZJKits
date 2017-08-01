//
//  NSObject+ZJDicModelTransform.h
//  ZJKits
//
//  Created by jianz3 on 2017/7/27.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol ZJDicModelTransformProtocol <NSObject>

@optional
/**
 *  数组中存储的类型
 *
 *  @return key --- 属性名,  value --- 数组中存储的类型
 */
+ (NSDictionary *_Nullable)zj_objectClassInArray;

/**
 *  替换一些字段
 *
 *  @return key -- 模型中的字段， value --- 字典中的字段
 */
+ (NSDictionary *_Nullable)zj_propertykeyReplacedWithValue;

@end

@interface NSObject (ZJDicModelTransform)<ZJDicModelTransformProtocol>

/* 字典转模型 */
+ (instancetype)zj_initWithDictionary:(NSDictionary *)dic  optionalAttributesDic:(NSDictionary<NSString *, NSString *> *)optionalAttributes;
@end
NS_ASSUME_NONNULL_END
