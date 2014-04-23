//
//  GatewayRequest.m
//  WoApp
//
//  Created by pdixit on 12/10/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import "GatewayRequest.h"


@implementation GatewayRequest


-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

+(NSMutableURLRequest *) GetRequest : (NSString *) Url : (NSString *) Method
{
    AppDelegate *app = [AppDelegate current];
    
   if(![iOSHelper isHostReachable:app.connectionHelper.Host])
    {
       UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Communication error !!" message:[iOSHelper LocalizedString:@"common.host.notrechable"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
       
       [alert show];       
       //if(app.currentUser)[app doLogin];
       return nil;
   }
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:Url]];
       
    [request setHTTPMethod:Method];

    return request;
}


@end
