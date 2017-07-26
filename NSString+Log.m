//
//  NSString+Log.m
//  ZJKits
//
//  Created by jianz3 on 2017/7/26.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "NSString+Log.h"

@implementation NSString (Log)


- (NSString *)unicodeString{
    
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSPropertyListFormat format = NSPropertyListOpenStepFormat;
    
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:&format error:nil];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

/** 查找并返回第一个匹配的文本内容 */
- (NSString *)firstMatchWithPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                                                             error:&error];
    
    if (error) {
        NSLog(@"匹配方案错误:%@", error.localizedDescription);
        return nil;
    }
    
    NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    NSArray <NSTextCheckingResult *> *arr = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult *result1 in arr) {
        NSRange range = [result1 rangeAtIndex:0];
        NSString *str1 =  [self substringWithRange:range];
        NSLog(@"str1  : %@",str1);
    }
    
    if (result) {
        NSRange range = [result rangeAtIndex:0];
        return [self substringWithRange:range];
    } else {
        NSLog(@"没有找到匹配内容 %@", pattern);
        return nil;
    }
}

@end
