//
//  NSString+TokenizeCategory.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 11/8/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "NSString+TokenizeCategory.h"

@implementation NSString (TokenizeCategory)

- (NSArray *) tokenizeByCommas {
    
    NSArray *tokens = [self componentsSeparatedByString:@","];
    NSMutableArray *clean = [NSMutableArray arrayWithCapacity:tokens.count];
    for (NSString *token in tokens) {
        [clean addObject:[token stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]]];
    }
    
    return clean;
}

@end
