//
//  TwitterView.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 8/19/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "PeckView.h"

@interface PeckView ()

@end

@implementation PeckView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)closepeckwebview
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void) viewWillAppear:(BOOL)animated
{
   
    self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    [self.peckwebivew loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.peckapp.com"]]];
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView

{
    
    // starting the load, show the activity indicator in the status bar
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView

{
    
    // finished loading, hide the activity indicator in the status bar
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [appDel removeLoader];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    
    // load error, hide the activity indicator in the status bar
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [appDel removeLoader];
    
    // report the error inside the webview
    
    NSString* errorString = [NSString stringWithFormat:
                             
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             
                             error.localizedDescription];
    
    [self.peckwebivew loadHTMLString:errorString baseURL:nil];
    
}


- (void)viewDidUnload {
    [self setPeckwebivew:nil];
    [self setHeaderTitle:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
