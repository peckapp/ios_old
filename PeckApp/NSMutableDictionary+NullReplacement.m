//
//  NSMutableDictionary+NullReplacement.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 9/6/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "NSMutableDictionary+NullReplacement.h"

@implementation NSMutableDictionary (NullReplacement)


- (NSMutableDictionary *)dictionaryByReplacingNullsWithStrings {
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for(NSString *key in self) {
        const id object = [self objectForKey:key];
        if(object == nul)
        {
            
            [replaced setObject:blank forKey:key];
         
        }
    }
    
    return [replaced copy];
}

@end
