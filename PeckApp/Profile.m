//
//  Profile.m
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/9/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//


#import "Profile.h"
#import <QuartzCore/QuartzCore.h>
@implementation Profile
@synthesize profileImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma Tweet

 - (IBAction)tweetTapped:(id)sender
{
    if (![self.twittername.text isEqual:@""])
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
             NSString *newstring =  [self.twittername.text
                stringByReplacingOccurrencesOfString:@" " withString:@""];
           
           
            if  (![newstring hasPrefix:@"@"])
            {
           newstring = [NSString stringWithFormat:@"@%@",newstring];
            }
            
           [tweetSheet setInitialText:[NSString stringWithFormat:@"%@ \n",newstring]];
            //[tweetSheet setTitle:self.twittername.text];
        
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:alertTitle
                                      message:@"You can't send a tweet right now, make sure your device has an internet connection and you have atleast one Twitter account setup."
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
        }
        
    }
    
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:alertTitle
                                  message:@"Twitter name is not Available."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark Open Email

-(IBAction) openmail:(id)sender
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        MFMailComposeViewController *mailComposeViewController=[[MFMailComposeViewController alloc] init];
        mailComposeViewController.mailComposeDelegate=self;
        //[mailComposeViewController setMessageBody:newShareText isHTML:YES];
        [mailComposeViewController setToRecipients:[NSArray arrayWithObjects:self.emailid.text,nil]];
        if([mailClass canSendMail]) {
            [self presentViewController:mailComposeViewController animated:YES completion:nil];
           // [self presentModalViewController:mailComposeViewController animated:YES];
        }
        
    }
    
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self dismissModalViewControllerAnimated:YES];
    
}

# pragma Phone Call
- (IBAction) phonecall:(id)sender
{
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] )
    {
        if (![self.phoneno.text isEqual:@""])
        {
            NSString *phoneno  = [self.phoneno.text stringByReplacingOccurrencesOfString:@"(" withString:@""];
            phoneno  = [phoneno stringByReplacingOccurrencesOfString:@")" withString:@""];
            phoneno  = [phoneno stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
           // DLog(@"ph=%@",phoneno);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneno]]];
            
        }
        
        else
        {
            
            [[[UIAlertView alloc] initWithTitle:alertTitle message:@"Phone No. is not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            
        }
 
        
        
        
    }
    else
    {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:alertTitle message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
        
    }
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
      AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
   self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    if (appDel.enterscreen)
    {
        AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
        
       
        [appDel addLoaderForViewController:self];
        fbuserprofile =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:fbuserprofile_details]] ;
        [fbuserprofile setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *uid = [defaults valueForKey:@"userid"];
        //DLog(@"userid=%@",uid);
        [fbuserprofile setPostValue:uid forKey:@"userid"];
        [fbuserprofile  startAsynchronous];

    }
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterscreen =FALSE;

}


#pragma Taking Photos

- (IBAction)btnProfileImageClicked:(id)sender
{
        
    [ActionSheet showActionSheet:@"":[[NSArray alloc] initWithObjects:@"Camera",@"Photo Roll",@"Remove Picture",@"Cancel",nil]  :self.view : ^(NSInteger buttonIndex)
    {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate=self;
    
        bool isPickImage = false;
        if( buttonIndex == 0)
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
            {
                
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                 imagePicker.cameraDevice= UIImagePickerControllerCameraDeviceRear;
                isPickImage = true;
            
            }
            else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==false)
            {
                [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Camera not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
            }
        }
       
        else if(buttonIndex == 1)
        {

            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing=YES;
            isPickImage = true;
            
        }
        else if(buttonIndex == 2)
        {
            
            self.profileImage.image=[UIImage imageNamed:@"camera.png"];
        }
        
        if(isPickImage)
        {
            [imagePicker setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            [self presentViewController:imagePicker animated:YES completion:nil];
            [imagePicker viewWillAppear:YES];
            
        }
    }];
}

# pragma mark Image Picker Methods

-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
     const NSInteger imgResolution=500;
     image = [ImageHelper scaleAndRotateImage:image toResolution:imgResolution];
    UIImage  *i = [ImageHelper imageByScalingProportionallyToSize:CGSizeMake(image.size.width, image.size.height):image];
    [self imageresize:i];
    self.profileImage.image=i;
    picker.delegate=nil;
    picker=nil;
    [CATransaction setDisableActions:YES];
    [self  dismissViewControllerAnimated:YES completion:nil];
   
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   
    picker.delegate=nil;
    picker=nil;
   [CATransaction setDisableActions:YES];
  [self  dismissViewControllerAnimated:YES completion:nil];
}




-(UIImage *) imageresize:(UIImage *) image
{
    if (image!=nil)
    {
        CGSize newSize = CGSizeMake(60, 60);  //whaterver size
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    return image;
}


- (IBAction)submitProfile:(id)sender
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [self.username resignFirstResponder];
    [appDel addLoaderForViewController:self];
    fbuserprofileupdate =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:fbuserprofile_submit_details]] ;
    [fbuserprofileupdate setDelegate:self];
    //DLog(@"userid=%@",appDel.userid);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [fbuserprofileupdate setPostValue:uid forKey:@"userid"];
    [fbuserprofileupdate setPostValue:self.username.text forKey:@"username"];
    
    if (![self.aboutDescription.text isEqual:@"Write Something about yourself. Keep it short though 140 character max."])
    {
         [fbuserprofileupdate setPostValue:self.aboutDescription.text forKey:@"about_me"];
    }
    
   
    [fbuserprofileupdate setPostValue:self.twittername.text forKey:@"tname"];
     NSString *phoneno  = [self.phoneno.text stringByReplacingOccurrencesOfString:@"(" withString:@""];
      phoneno  = [phoneno stringByReplacingOccurrencesOfString:@")" withString:@""];
      phoneno  = [phoneno stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [fbuserprofileupdate setPostValue:phoneno forKey:@"phoneno"];
   //  [fbuserprofileupdate setPostValue:self.emailid.text forKey:@"emailid"];
    if (profileImage.image!=[UIImage imageNamed:@"camera.png"])
    {
        NSData *imageData = UIImageJPEGRepresentation(self.profileImage.image, 0.1);
        
        NSString *image = [imageData base64EncodedString];
         [fbuserprofileupdate setPostValue:image forKey:@"user_picture"];
    }
   
    [fbuserprofileupdate  startAsynchronous];
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
   

    if (request==fbuserprofile)
    {
         [CATransaction setDisableActions:YES];
        NSString *response  =  [request responseString];
       // DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        
        //  NSString *status=[dict valueForKey:@"status"];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
        self.username.text=[dict valueForKey:@"username"];
        self.emailid.text=[dict valueForKey:@"email"];
        self.phoneno.text=[dict valueForKey:@"phoneno"];
        self.twittername.text=[dict valueForKey:@"tname"];
        //   if ([dict valueForKey:@"about_me"]!=nil) {
        self.aboutDescription.text=[dict valueForKey:@"about_me"];
        // }
            if ([self.aboutDescription.text isEqual:@""])
            {
              self.aboutDescription.text=@"Write Something about yourself. Keep it short though 140 character max.";
            }
               [appDel removeLoader];
        
        NSString *imageurl= [dict valueForKey:@"profile_image"];
        imageurl = [imageurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        if (![imageurl isEqual:@""])
        {
        UIImage *cachedImage = [self.imageCache objectForKey:imageurl];
        
        if (cachedImage)
        {
            self.profileImage.image = cachedImage;
        }
        else
        {
            // you'll want to initialize the image with some blank image as a placeholder
            UIActivityIndicatorView *eventimageloading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            eventimageloading.center = CGPointMake(self.profileImage.frame.size.width/2, self.profileImage.frame.size.height/2);
            eventimageloading.alpha = 1.0;
            eventimageloading.hidesWhenStopped = YES;
            [eventimageloading startAnimating];
            [self.profileImage addSubview:eventimageloading];
            self.buttonProfileImage.userInteractionEnabled=NO;
            
            // now download in the image in the background
            
            [self.imageDownloadingQueue addOperationWithBlock:^{
                
                NSURL *imageUrl   = [NSURL URLWithString:imageurl];
                NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
                UIImage *image    = nil;
                if (imageData)
                    image = [UIImage imageWithData:imageData];
                
                if (image)
                {
                    // add the image to your cache
                    
                    [self.imageCache setObject:image forKey:imageurl];
                    
                    // finally, update the user interface in the main queue
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        // make sure the cell is still visible
                        
                    
                    UIImage  *i = [ImageHelper imageByScalingProportionallyToSize:CGSizeMake(image.size.width, image.size.height):image];
                        profileImage.image = i;
                        self.buttonProfileImage.userInteractionEnabled=YES;
                    }];
                }
                [eventimageloading removeFromSuperview];
                [eventimageloading stopAnimating];
               
            }];
            
        
        }
       
        }
        
        }
        
     else   if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
          [appDel removeLoader];
        }

        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [appDel removeLoader];
            
        }
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString: imageurl]];
//        if (imageData!=nil)
//        {
//            UIImage *image=[UIImage imageWithData:imageData];
//            image = [ImageHelper scaleAndRotateImage:image toResolution:500];
//            UIImage  *i = [ImageHelper imageByScalingProportionallyToSize:CGSizeMake(image.size.width, image.size.height):image];
//            profileImage.image =i;
//        }
//        

        
    }
    
    if (request==fbuserprofileupdate)
    {
        NSString *response  =  [request responseString];
       // DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        NSString *status=[dict valueForKey:@"status"];
        if([status isEqualToString:@"s"])
        {
        
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        else if([status isEqualToString:@"e"])
        {
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
        [appDel removeLoader];
        
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    [CATransaction setDisableActions:YES];
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    //NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
}

-(void) movefromtextfields
{

    
    if ([self.username.text isEqual:@""])
    {
        self.username.placeholder=@"Name";
        
        
    }
    if ([self.emailid.text isEqual:@""])
    {
        self.emailid.placeholder=@"Email Id";
        
        
    }
    
    if ([self.aboutDescription.text isEqual:@""])
    {
        self.aboutDescription.text=@"Write Something about yourself. Keep it short though 140 character max.";
        
        
    }
    
    if ([self.twittername.text isEqual:@""])
    {
        self.twittername.placeholder=@"@username";
        
        
    }
    if ([self.phoneno.text isEqual:@""])
    {
        self.phoneno.placeholder=@"(XXX) - XXX - XXXX";
        
    }


}


#pragma mark TextField Delegate

- (IBAction)singleTapGesture:(UITextField *) textField{
        
    
    
    [self.username resignFirstResponder];
    [self.emailid resignFirstResponder];
    [self.twittername resignFirstResponder];
    [self.phoneno resignFirstResponder];
    [self.aboutDescription resignFirstResponder];
    
    // self.Backgroundscroller.contentOffset=CGPointMake(0, 0);
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([self.username isFirstResponder])
    {
        
        if ([self.username.text isEqual:@""])
        {
            self.username.placeholder=@"Name";
            
            
        }
        [self.aboutDescription becomeFirstResponder];
    }

    
    if ([self.emailid isFirstResponder])
    {
        
        if ([self.emailid.text isEqual:@""])
        {
            self.emailid.placeholder=@"Email Id";
            
            
        }
        [self.twittername becomeFirstResponder];
    }
    
    else
    {
        if ([self.twittername.text isEqual:@""])
        {
            self.twittername.placeholder=@"@username";
            
            
        }
        [self.twittername resignFirstResponder];
        
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [self.view addGestureRecognizer:singleTap];
    
        textField.placeholder=@"";
        

        UIApplication *application= [UIApplication sharedApplication];
    if (textField==self.username) {
        
    }
    else{
        application.statusBarHidden=YES;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-215.0,
                                     self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UIApplication *application= [UIApplication sharedApplication];
    
    [self movefromtextfields];
    
    
    if (textField!=self.username)
    {
    application.statusBarHidden=NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+215.0,
                                 self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    }
    
}

#pragma mark TextView Delegate


-(void)textViewDidBeginEditing:(UITextView *)textView
{
   
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
        [self.view addGestureRecognizer:singleTap];
    if ([self.aboutDescription.text isEqual:@"Write Something about yourself. Keep it short though 140 character max."])
    {
        self.aboutDescription.text=@"";
        
        
    }
    UIApplication *application= [UIApplication sharedApplication];
    application.statusBarHidden=YES;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-180.0,self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
       [self.view removeGestureRecognizer:singleTap];
    UIApplication *application= [UIApplication sharedApplication];
    [self movefromtextfields];
    application.statusBarHidden=NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view .frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+180.0,self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        if ([self.aboutDescription.text isEqual:@"\n"])
        {
            self.aboutDescription.text=@"Write Something about yourself. Keep it short though 140 character max.";
        
        }

            [self.twittername becomeFirstResponder];
            

        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

- (IBAction)closeProfile:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.profileImage.layer.cornerRadius=30.0;
    self.profileImage.layer.masksToBounds = YES;
    self.profileImage.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.profileImage.layer.borderWidth=1.0;
    
}

- (void)viewDidUnload
{
    [self setProfileImage:nil];
    [self setEmailid:nil];
    [self setUsername:nil];
    [self setPhoneno:nil];
    [self setAboutDescription:nil];
    [self setEmailid:nil];
    [self setUsername:nil];
    [self setHeaderTitle:nil];
    [self setButtonProfileImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)username:(id)sender {
}
@end
