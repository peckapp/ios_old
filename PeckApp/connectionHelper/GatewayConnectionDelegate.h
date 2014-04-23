//
//  GatewayConnectionDelegate.h
//  Wo.iPhone
//
//  Created by pdixit on 05/12/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iOSHelper.h"
@interface GatewayConnectionDelegate : NSObject <NSURLConnectionDelegate>
{
    NSMutableData * currentData;
}
typedef void (^NSUrlConnectionCompleteBlock)(NSURLResponse *response,id result,NSError *error);
@property (strong,nonatomic) NSUrlConnectionCompleteBlock callback;

-(id) init;
-(void) GetResponse:(NSURLConnection *)conn withCallback:(NSUrlConnectionCompleteBlock)callback;

@end
