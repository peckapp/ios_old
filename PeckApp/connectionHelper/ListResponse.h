//
//  ListResponse.h
//  Wo.iPhone
//
//  Created by Chandan Singh on 21/01/13.
//  Copyright (c) 2013 pdixit. All rights reserved.
//

#import "DictionaryWrapper.h"
#import "DictionaryListWrapper.h"


/*
@interface GroupListWrapper: DictionaryListWrapper

-(id) initWithDictionaryArray:(NSArray *)dictionaryArray;
-(Group *) groupAtIndex: (int) index;

@end
*/
@interface ListResponse : DictionaryWrapper
{
    NSString *keyItem;

}
-(id) initWithItemClass: (NSString *)className itemKey:(NSString *)itemkey dictionary: (NSDictionary *) dict;
-(id) initWithItemClass:(NSString *)className responseKey:(NSString *)responsekey itemKey:(NSString *)itemkey dictionary:(NSDictionary *)dict;
@property (assign, nonatomic, readonly) int code;
@property (copy, nonatomic, readonly) NSString *message;
@property (strong, nonatomic, readonly) DictionaryListWrapper *items;

@end
