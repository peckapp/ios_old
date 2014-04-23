//
//  GatewayClient.h
//  WoApp
//
//  Created by pdixit on 06/10/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "DictionaryHelper.h"
#import "GatewayRequest.h"
#import "LoadingView.h"
#import "iOSHelper.h"
#import "jsonHelper.h"
#import "GatewayConnection.h"

@interface GatewayClient : NSObject
{
    GatewayConnection * Connection;
}
//-(void) DoGetAsync :(NSString * )calller:(NSString *) Url :(void (^)(id result,NSError *error)) handler;

-(void) DoGet :(NSString * )calller :(NSString *) Url :(void (^)(id result,NSError *error)) handler;

//-(void) DoPostAsync :(NSString * )calller:(NSString *) Url  :(NSDictionary *) data : (void (^)(id result,NSError *error)) handler;

-(void) DoPost :(NSString * )calller :(NSString *) Url  :(NSDictionary *) data : (void (^)(id result,NSError *error)) handler;

//-(void) DoPostAsyncImage :(NSString * )calller :(NSString *) Url :(NSData *) data : (void (^)(id result,NSError *error)) handler;

//-(void) DoGetImageAsync :(NSString * )calller:(NSString *) Url : (void (^)(id result,NSError *error)) handler;

//-(void) DoPostStream :(NSString *) Url :(NSInputStream *) strm : (void (^)(id result,NSError *error)) handler;
-(void) doPostAsyncWithProgress : (BOOL)progress andCaller:(NSString * )caller andUrl:(NSString *) Url  andData:(NSDictionary *) dictionary : (void (^)(id result,NSError *error)) handler;

-(void) doGetAsyncWithProgress :(BOOL)progress andCaller:(NSString * )caller andUrl:(NSString *) Url :(void (^)(id result,NSError *error)) handler;


-(void) doPostAsyncImageWithProgress :(BOOL)progress andCaller:(NSString * )calller andUrl:(NSString *) Url :(NSData *) data : (void (^)(id result,NSError *error)) handler;

-(void) doGetImageAsyncWithProgress :(BOOL)progress andCaller:(NSString * )calller andUrl:(NSString *) Url : (void (^)(id result,NSError *error)) handler;
@end
