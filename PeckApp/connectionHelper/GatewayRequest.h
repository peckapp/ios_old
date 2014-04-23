//
//  GatewayRequest.h
//  WoApp
//
//  Created by pdixit on 12/10/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "HostRechability.h"
#import "AppDelegate.h"

@interface GatewayRequest : NSObject
{
   
}

+(NSMutableURLRequest *) GetRequest : (NSString *) Url : (NSString *) Method;

@end
