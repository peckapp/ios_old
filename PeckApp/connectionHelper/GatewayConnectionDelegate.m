//
//  GatewayConnectionDelegate.m
//  Wo.iPhone
//
//  Created by pdixit on 05/12/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import "GatewayConnectionDelegate.h"

@implementation GatewayConnectionDelegate
@synthesize callback= _callback;

-(id) init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

-(void) GetResponse:(NSURLConnection *)conn withCallback:(NSUrlConnectionCompleteBlock)cb
{
    self.callback = [cb copy];// autorelease];
    
    /*
    ^(NSURLResponse *response,id result,NSError *error){
        cb(response,result,error);
    };*/
}


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse..");
    _callback(response,nil,nil);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   // NSLog(@"didReceiveData..");
   
    if(currentData == nil)
        currentData = [[NSMutableData alloc] init];
    [currentData appendData:data];
    //_callback (nil,data,nil);
}

- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request
{
    //NSLog(@"needNewBodyStream..");
    return [[NSInputStream alloc] init];
}

- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
   // NSLog(@"didSendBodyData..");
}


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    //[connection release];
    _callback(nil,nil,error);
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    
    UIAlertView * a = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Connection failed! Error - %@ ",
                                                          [error localizedDescription]] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
    
    [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"connectionDidFinishLoading..");
    //[connection release];
    // [Data release];
    
    // NSString *txt = [[[NSString alloc] initWithData:Data encoding: NSASCIIStringEncoding] autorelease];
    
    _callback (nil,currentData,nil);
    
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection
                 willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    
    NSLog(@"willCacheResponse..");
    
    NSCachedURLResponse *newCachedResponse = cachedResponse;
    
    /* if ([[[[cachedResponse response] URL] scheme] isEqual:@"https"]) {
     newCachedResponse = nil;
     } else {
     NSDictionary *newUserInfo;
     newUserInfo = [NSDictionary dictionaryWithObject:[NSCalendar date]
     forKey:@"Cached Date"];
     newCachedResponse = [[[NSCachedURLResponse alloc]
     initWithResponse:[cachedResponse response]
     data:[cachedResponse data]
     userInfo:newUserInfo
     storagePolicy:[cachedResponse storagePolicy]]
     autorelease];
     }*/
    return newCachedResponse;
}



@end
