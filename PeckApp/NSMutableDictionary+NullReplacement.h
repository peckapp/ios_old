//
//  NSMutableDictionary+NullReplacement.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 9/6/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NullReplacement)
- (NSMutableDictionary *)dictionaryByReplacingNullsWithStrings;


@end
