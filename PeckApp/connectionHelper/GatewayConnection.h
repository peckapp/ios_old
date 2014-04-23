//
//  GatewayConnection.h
//  Wo.iPhone
//
//  Created by pdixit on 05/12/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GatewayConnectionDelegate.h"

@interface GatewayConnection : NSObject
{
    NSMutableURLRequest * Request;
    NSURLConnection * Conn;
    GatewayConnectionDelegate * Delegate;
    
}

-(id) init : (NSMutableURLRequest * )request;

typedef void (^NSUrlConnectionDelegateResponseBlock)(NSURLResponse *response,id result,NSError *error);
@property (strong,nonatomic) NSUrlConnectionDelegateResponseBlock callback;


-(void) Start:(GatewayConnection *)conn withCallback:(NSUrlConnectionDelegateResponseBlock)callback;


@end
