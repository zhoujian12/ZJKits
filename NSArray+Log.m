//
//  NSArray+Log.m
//  ZJKits
//
//  Created by jianz3 on 2017/7/26.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "NSArray+Log.h"
#import <objc/runtime.h>
#import "NSString+Log.h"

@implementation NSArray (Log)

//- (NSString *)descriptionWithLocale:(id)locale
//{
//    // 开头有个[
//    NSMutableString *strM = [NSMutableString stringWithString:@"[\n"];
//    
//    // 遍历所有的元素
//    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [strM appendFormat:@"\t%@,\n", obj];
//    }];
//    
//    // 结尾有个}
//    [strM appendString:@"]"];
//    
//    // 查找最后一个逗号
//    NSRange range = [strM rangeOfString:@"," options:NSBackwardsSearch];
//    if (range.location != NSNotFound)
//        [strM deleteCharactersInRange:range];
//    
//    return strM;
//}

#ifdef DEBUG
- (NSString *)descriptionWithLocale:(id)locale{
    return self.debugDescription;
}

- (NSString *)xy_debugDescription{
    return self.xy_debugDescription.unicodeString;
}

+ (void)load{
    [self swapMethod];
}

+ (void)swapMethod{
    Method method1 = class_getInstanceMethod(self, @selector(debugDescription));
    Method method2 = class_getInstanceMethod(self, @selector(xy_debugDescription));
    
    method_exchangeImplementations(method1, method2);
}
#endif

@end
