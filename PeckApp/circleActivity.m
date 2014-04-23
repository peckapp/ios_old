//
//  circleActivity.m
//  Sharing Example
//
//  Created by Viresh Kumar Sharma on 6/20/13.
//  Copyright (c) 2013 CapTech. All rights reserved.
//

#import "circleActivity.h"

@interface circleActivity ()

@end

@implementation circleActivity


- (NSString *)activityType
{
    return @"ShareCircle";
}

- (NSString *)activityTitle
{
    return @"Circles";
}

- (UIImage *)activityImage
{
  
    return [UIImage imageNamed:@"circles.png"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    for (id obj in activityItems) {
        if ([obj isKindOfClass: [NSString class]])
            return YES;
    }
    return NO;
}



- (UIViewController *)activityViewController
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromCircle=true;
    ShareCircles *sharecircles=[[ShareCircles alloc] initWithNibName:@"ShareCircles" bundle:nil];
     sharecircles.activity = self;
    return sharecircles;

}

-(void)performActivity
{
    [self activityDidFinish:YES];
}


@end







