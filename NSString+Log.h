//
//  NSString+Log.h
//  ZJKits
//
//  Created by jianz3 on 2017/7/26.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Log)

- (NSString *)unicodeString;

/** 查找并返回第一个匹配的文本内容 */
- (NSString *)firstMatchWithPattern:(NSString *)pattern;

@end
