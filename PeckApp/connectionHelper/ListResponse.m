//
//  ListResponse.m
//  Wo.iPhone
//
//  Created by Chandan Singh on 21/01/13.
//  Copyright (c) 2013 pdixit. All rights reserved.
//

#import "ListResponse.h"
@interface ListResponse()
{
    NSString *itemClass;
    DictionaryListWrapper *_items;
}
@end

@implementation ListResponse

-(id) initWithItemClass:(NSString *)className itemKey:(NSString *)itemkey dictionary:(NSDictionary *)dict
{
    if (self = [super initWithDictionaryObject:[dict objectForKey:@"woResponse"]])
    {
        itemClass = className;
        keyItem = itemkey;
    }
    return self;
}

-(id) initWithItemClass:(NSString *)className responseKey:(NSString *)responsekey itemKey:(NSString *)itemkey dictionary:(NSDictionary *)dict
{
    if (self = [super initWithDictionaryObject:[dict objectForKey:responsekey]])
    {
        itemClass = className;
        keyItem=itemkey;
    }
    return self;
    
}
-(int) code
{
    return [[self.Dictionary valueForKey:@"code"] integerValue];
}

-(NSString *)message
{
    return [self.Dictionary valueForKey:@"message"];
}

-(DictionaryListWrapper *) items
{
    if (_items == nil)
    {
        _items = [[DictionaryListWrapper alloc] initWithDictionaryArray : [self.Dictionary objectForKey:keyItem] wrapperClassName: itemClass];
    }
    return _items;
}

@end
