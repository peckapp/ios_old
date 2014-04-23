//
//  GatewayClient.m
//  WoApp
//
//  Created by pdixit on 06/10/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import "GatewayClient.h"

@implementation GatewayClient

-(id) init
{
    self = [super init];
    if (self) {        
    }
    return self;
}


-(void) DoGet :(NSString * )calller :(NSString *) Url : (void (^)(id result,NSError *error)) handler
{
    NSMutableURLRequest *Request = [GatewayRequest GetRequest:Url :@"GET" ];
    if(Request != nil)
    {
        [LoadingView Start:calller];
        NSLog(@"Request URL : %@",Request.URL);
    
        NSError *err;
        NSURLResponse *response;    
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:Request returningResponse:&response error:&err];
        [LoadingView Stop];
        if( responseData == nil)
        {
            //handler( nil,err);
            
            //UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"server.down"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                
           // [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
          
        }
        else
        {
            NSLog(@"Response : %@",[jsonHelper Deserialize:responseData]);            
            
        
            //if( [NSJSONSerialization isValidJSONObject:[NSJSONSerialization JSONObjectWithData:responseData options:0 error:&err]])
            {
                handler([jsonHelper Deserialize:responseData],err);
                
            }
            //else
            //{
                //handler( [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding],err);
            //}
        }
       // [self release];
    }
}
//-(void) DoGetAsync :(NSString * )calller:(NSString *) Url : (void (^)(id result,NSError *error)) handler

-(void) doGetAsyncWithProgress :(BOOL)progress andCaller:(NSString * )caller andUrl:(NSString *) Url :(void (^)(id result,NSError *error)) handler;
{
    NSMutableURLRequest *Request = [GatewayRequest GetRequest:Url :@"GET" ];
    if(Request != nil)
    {
        NSLog(@"Request URL : %@",Request.URL);
        if (progress)
            [LoadingView Start:caller];
        
        Connection = [[GatewayConnection alloc] init:Request];
        [Connection Start:Connection withCallback: ^(NSURLResponse * response,id result,NSError *error){
            
            if (progress)
            [LoadingView Stop];
            //handler ([jsonHelper Deserialize:result],error);
            /*if(result == nil)
            {
                UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"server.down"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                
                [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
            }
            else*/ if ([result length] > 0 && error == nil)
            {
                //NSError* jsonError;
                NSLog(@"Response : %@",[jsonHelper Deserialize:result]);
                handler ([jsonHelper Deserialize:result],error);
            }
            else if ([result length] == 0 && error == nil)
            {
                //handler (nil,error);
            }
            else if (error != nil && error.code == NSURLErrorTimedOut)
            {
                NSLog(@"Request Timeout: %@", Request.URL);
                /*
                 UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"common.timeout"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                
                [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
                 */
            }
            else if (error != nil)
            {
                NSLog(@"Error : %@",Request.URL);
            }
           // [self release];
        }];
        
        
        /*NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
        [NSURLConnection sendAsynchronousRequest:Request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             [LoadingView Stop];
             if ([data length] > 0 && error == nil)
             { 
                 NSError* jsonError;
                 NSLog(@"Response : %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]);
                 handler ([NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError],error);
             }
             else if ([data length] == 0 && error == nil)
             {
                 handler (nil,error);
             }
             else if (error != nil && error.code == NSURLErrorTimedOut)
             {
                 NSLog(@"Request Timeout: %@", Request.URL);
                 UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"Request Timeout"message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                 
                 [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
             }
             else if (error != nil)
             {
                 NSLog(@"Error : %@",Request.URL);
             }
         }];*/
    }
}



-(void) DoPost :(NSString * )calller :(NSString *) Url :(NSDictionary *) dictionary : (void (^)(id result,NSError *error)) handler

{
    
    NSMutableURLRequest *request = [GatewayRequest GetRequest:Url :@"POST" ];
    if(request != nil)
    {
        NSLog(@"Request URL : %@",request.URL);
    
        //NSData * data = [DictionaryHelper Serialize:dictionary];
        NSData * data = [jsonHelper Serialize:dictionary];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[[NSString alloc] initWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
    
    
        [request  setHTTPBody:data];
    
        NSLog(@"Requested Data: %@",[[NSString alloc] initWithData:data
                                                      encoding:NSUTF8StringEncoding] );
        [LoadingView Start:calller];
        NSError *err;
        NSURLResponse *response;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        [LoadingView Stop];
        if( responseData == nil)
        {
            //handler( nil,err);
            // UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"server.down"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                
            //[iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
            
        }
        else
        {
            NSLog(@"Response : %@",[jsonHelper Deserialize:responseData]);
        
            //if( [NSJSONSerialization isValidJSONObject:[NSJSONSerialization JSONObjectWithData:responseData options:0 error:&err]])
            {
                handler([jsonHelper Deserialize:responseData],err);
            }
            //else
            {
             //   handler( [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding],err);
            }
        }
        //[self release];
    }
}



//-(void) DoPostAsync :(NSString * )calller:(NSString *) Url :(NSDictionary *) dictionary : (void (^)(id result,NSError *error)) handler
-(void) doPostAsyncWithProgress : (BOOL)progress andCaller:(NSString * )caller andUrl:(NSString *) Url  andData:(NSDictionary *) dictionary : (void (^)(id result,NSError *error)) handler
{
    
    NSMutableURLRequest *request = [GatewayRequest GetRequest:Url :@"POST" ];
    
    if(request != nil)
    {
        NSLog(@"Request URL : %@ - data: %@",request.URL, dictionary);
        //NSData * data = [DictionaryHelper Serialize:dictionary];
        NSData * data = [jsonHelper Serialize:dictionary];
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[[NSString alloc] initWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
    
        [request  setHTTPBody:data];
        NSLog(@"Requested Data: %@",[[NSString alloc] initWithData:data
                                                          encoding:NSUTF8StringEncoding] );
        //autorelease]);
        if (progress) 
        [LoadingView Start:caller];
        
        Connection = [[GatewayConnection alloc] init:request];
        [Connection Start:Connection withCallback: ^(NSURLResponse * respponse,id result,NSError *error){
            if(progress)
            [LoadingView Stop];
            //handler ([jsonHelper Deserialize:result],error);
            /*if(result == nil)
            {
                UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"server.down"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                
                [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
            }
            else*/ if ([result length] > 0 && error == nil)
            {
                //NSError* jsonError;
                
                NSLog(@"Response : %@",[jsonHelper Deserialize:result]);
                
                handler ([jsonHelper Deserialize:result],error);
            }
            else if ([result length] == 0 && error == nil)
            {
                //handler (nil,error);
            }
            else if (error != nil && error.code == NSURLErrorTimedOut)
            {
                NSLog(@"Request Timed Out: %@", request.URL);
                
              /*  UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"common.timeout"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                
                [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
               */
            }
            else if (error != nil)
            {
                NSLog(@"Error Url : %@",request.URL);
                NSLog(@"Error : %@",error);                
            }
            //[self release];
        }];
        
        /*NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData * data, NSError *error)
         {
             [LoadingView Stop];
             if ([data length] > 0 && error == nil)
             {
                 NSError* jsonError;             
            
                 NSLog(@"Response : %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]);
             
                 handler ([NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError],error);
             }
             else if ([data length] == 0 && error == nil)
             {
                handler (nil,error);
             }
             else if (error != nil && error.code == NSURLErrorTimedOut)
             {
                 NSLog(@"Request Timeout: %@", request.URL);
                 
                 UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"Request Timeout"message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                 
                 [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
             }
             else if (error != nil)
             {
                 NSLog(@"Error Url : %@",request.URL);
                 NSLog(@"Error : %@",error);
                 
                 

             }
         }];*/
    }
}



//-(void) DoPostAsyncImage :(NSString * )calller:(NSString *) Url :(NSData *) data : (void (^)(id result,NSError *error)) handler
-(void) doPostAsyncImageWithProgress :(BOOL)progress andCaller:(NSString * )calller andUrl:(NSString *) Url :(NSData *) data : (void (^)(id result,NSError *error)) handler

{
    NSMutableURLRequest *request = [GatewayRequest GetRequest:Url :@"POST" ];
    if(request != nil)
    {
        NSLog(@"Request URL : %@",request.URL);
    
        [request setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[[NSString alloc] initWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
           
        [request  setHTTPBody:data];
        NSLog(@"Requested Data length: %d",data.length);
        
        if (progress)
            [LoadingView Start:calller];
    
        Connection = [[GatewayConnection alloc] init:request];
        [Connection Start:Connection withCallback: ^(NSURLResponse * response,id result,NSError *error)
         {
             if (progress)
             [LoadingView Stop];
             //handler ([jsonHelper Deserialize:result],error);
        
             /*if(result == nil)
              {
              UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"server.down"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
            
              [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
              }
              else*/ if ([result length] > 0 && error == nil)
              {
                  //NSError* jsonError;
            
                  //NSLog (@"Response Data Length : %d",result.length);
        
                  NSString* s = [[NSString alloc] initWithData:result
                                                       encoding:NSUTF8StringEncoding] ;
                                 //autorelease];
                  NSLog(@"data:%@",s);
                  NSLog(@"Response : %@",[jsonHelper Deserialize:result]);
            
                  handler ([jsonHelper Deserialize:result],error);
              }
              else if ([result length] == 0 && error == nil)
              {
                  //handler (nil,error);
              }
              else if (error != nil && error.code == NSURLErrorTimedOut)
              {
                  NSLog(@"Request Timed Out: %@", request.URL);
                /*  UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"common.timeout"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
            
                  [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];*/
              }
              else if (error != nil)
              {
                  NSLog(@"Error Url : %@",request.URL);
                  NSLog(@"Error : %@",error);
              }
             //[self release];
         }];
    /*NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         [LoadingView Stop];
         
         if ([data length] > 0 && error == nil)
         {
             NSError* jsonError;
             
             NSLog (@"Response Data Length : %d",data.length);
             
             NSString* s = [[[NSString alloc] initWithData:data
                                                       encoding:NSUTF8StringEncoding] autorelease];
             NSLog(@"data:%@",s);
             NSLog(@"Response : %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]);
             
             handler ([NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError],error);
         }
         else if ([data length] == 0 && error == nil)
         {
             handler (nil,error);
         }
         else if (error != nil && error.code == NSURLErrorTimedOut)
         {
             NSLog(@"Request Timeout: %@", request.URL);
             UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"Request Timeout"message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
             
             [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
         }
         else if (error != nil)
         {
             NSLog(@"Error Url : %@",request.URL);
             NSLog(@"Error : %@",error);
         }
     }];*/
    }
}

//-(void) DoGetImageAsync :(NSString * )calller:(NSString *) Url : (void (^)(id result,NSError *error)) handler
-(void) doGetImageAsyncWithProgress :(BOOL)progress andCaller:(NSString * )calller andUrl:(NSString *) Url : (void (^)(id result,NSError *error)) handler
{
    NSMutableURLRequest *Request = [GatewayRequest GetRequest:Url :@"GET" ];
    if(Request != nil)
    {
        NSLog(@"Request URL : %@",Request.URL);
        if(progress) [LoadingView Start:calller];
        
        Connection = [[GatewayConnection alloc] init:Request];
        [Connection Start:Connection withCallback: ^(NSURLResponse * response,id result,NSError *error)
         {
             if(progress)
             [LoadingView Stop];
             //handler ([jsonHelper Deserialize:result],error);
             
             /*if(result == nil)
             {
                 UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"server.down"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                 
                 [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
             }
             else*/ if ([result length] > 0 && error == nil)
             {
                // NSError* jsonError;
                 //NSLog(@"Response : %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]);
                 handler (result,error);
                 //[self release];
             }
             else if ([result length] == 0 && error == nil)
             {
                 //handler (nil,error);
             }
             else if (error != nil && error.code == NSURLErrorTimedOut)
             {
                 NSLog(@"Request Timed Out: %@", Request.URL);
                /* UIAlertView * a = [[UIAlertView alloc] initWithTitle:[iOSHelper LocalizedString:@"common.timeout"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                 
                 [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];*/
                 //[a release];
             }
             else if (error != nil)
             {
                 NSLog(@"Error : %@",Request.URL);
             }
             //[self release];
         }];

        
        
        /*NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
        [NSURLConnection sendAsynchronousRequest:Request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             [LoadingView Stop];
             if ([data length] > 0 && error == nil)
             {
                 NSError* jsonError;
                 //NSLog(@"Response : %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]);
                 handler (data,error);
             }
             else if ([data length] == 0 && error == nil)
             {
                 //handler (nil,error);
             }
             else if (error != nil && error.code == NSURLErrorTimedOut)
             {
                 NSLog(@"Request Timeout: %@", Request.URL);
                 UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"Request Timeout"message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
                 
                 [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
             }
             else if (error != nil)
             {
                 NSLog(@"Error : %@",Request.URL);
             }
         }];*/
    }
}


/*
-(void) DoPostStream :(NSString *) Url :(NSInputStream *) strm : (void (^)(id result,NSError *error)) handler
{
    NSMutableURLRequest *request = [GatewayRequest GetRequest:Url :@"POST" ];
    
    NSLog(@"Request URL : %@",request.URL);
    
    [request setValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
    
    //[request setValue:[[NSString alloc] initWithFormat:@"%d", [data1 length]] forHTTPHeaderField:@"Content-Length"];
    
    
    NSData * d = [[NSData alloc] initWithContentsOfFile:@"WOTemplate.jpg"];
    NSInputStream *stream = [[NSInputStream alloc] initWithFileAtPath:@"WOTemplate.jpg"];
    
    [request  setHTTPBodyStream:stream];
    
    //NSLog(@"Requested Data length: %d",data1.length);
    
    //NSLog(@"Requested stream length: %d", strm  );
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil)
         {
             NSError* jsonError;
             
             NSLog (@"Response Data Length : %d",data.length);
             
             NSLog(@"Response : %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]);
             
             handler (data ,error);
         }
         else if ([data length] == 0 && error == nil)
         {
             handler (nil,error);
         }
         else if (error != nil && error.code == NSURLErrorTimedOut)
         {
             NSLog(@"Request Timeout: %@", request.URL);
             
             UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"Request Timeout"message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
             
             [iOSHelper showAlertView:a withCallback:^(NSInteger buttonIndex) {}];
         }
         else if (error != nil)
         {
             NSLog(@"Error URL: %@",request.URL);
             NSLog(@"Error : %@",error);
         }
     }];
}*/


@end
