//
//  GatewayConnection.m
//  Wo.iPhone
//
//  Created by pdixit on 05/12/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import "GatewayConnection.h"

@implementation GatewayConnection
@synthesize callback;

-(id) init : (NSMutableURLRequest * )request
{
    self = [super init];
    if(self)
    {
        Request =[[NSMutableURLRequest alloc]init];
        Request =  request;
        //TODO check this
        self.callback = ^(NSURLResponse *response,id result,NSError *error){
            callback(response,result,error);
        };
    }
    return self;
}

-(void) Start:(GatewayConnection *)conn withCallback:(NSUrlConnectionCompleteBlock)callback
{
    Delegate = [[GatewayConnectionDelegate alloc] init];
    Conn = [[NSURLConnection alloc] initWithRequest:Request delegate:Delegate startImmediately:true];
    
    [Delegate GetResponse:Conn withCallback:callback];
     /*
     ^(NSURLResponse *response,id result,NSError *error){
        callback (response,result,error);
    }];*/
}



@end
