//
//  HttpConnectionHelper.m
//  WoApp
//
//  Created by pdixit on 06/10/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import "HttpConnectionHelper.h"
#import "AppDelegate.h"
@interface HttpConnectionHelper ()

@property (assign, readonly)AppDelegate *appDelegate;

@end
@implementation HttpConnectionHelper
@synthesize Host,Port,AppName, SID;

-(AppDelegate *) appDelegate
{
    //return the global singleton instance...
    return [AppDelegate current];
}
- (id)init
{
    self = [super init];
    if (self) {        
        //Host = @"pankanis.dyndns.org";
        //Host = @"192.168.10.254";
        //Port = @"8081";
        //AppName = @"WO";
        //AppDelegate * app = (AppDelegate*)
        //Host = app.wo;
        //Port = @"8081";
        //AppName = @"WO";
    }
    return self;
}

-(NSString *) EncoadingString : (NSString *) string
{
    return [string stringByAddingPercentEscapesUsingEncoding:
            NSASCIIStringEncoding];
    /*
    return (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                         NULL,
                                                                         (CFStringRef)string,
                                                                         NULL,
                                                                         (CFStringRef)@"!*'();:@&=+$,/?%#[] ",
                                                                         kCFStringEncodingUTF8 );
*/
     }

-(NSString *) fbLoginUrl :(NSString*) fbSession
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/authenticate?token=%@",self.Host,self.Port,self.AppName,fbSession];
}
   
-(NSString *) LoginUrl :(NSString*) username : (NSString*)password
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/login?username=%@&password=%@",self.Host,self.Port,self.AppName,username,password];
}

-(NSString *) Login2Url 
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/login2",self.Host,self.Port,self.AppName];
}
-(NSString *) RegistrationUrl
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/register",self.Host,self.Port,self.AppName];
}

-(NSString *) UserVerificationUrl
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/requestverification?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}

-(NSString *) UserDetailUrl :(int) userid;
{
  
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/details?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}

-(NSString *) ConfidantListUrl :(int) userid
{
               
    
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/confidant/list?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
    
}


-(NSString *) ConfermationUrl :(NSString *) regcode :(NSString *) email
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/admin/confirm?reg=%@&email=%@&sid=%@",self.Host,self.Port,self.AppName,regcode,email,self.appDelegate.sId];
}

-(NSString *) AddConfidantUrl
{
      return [NSString stringWithFormat:@"http://%@:%@/%@/user/confidant/add?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}

-(NSString *) InviteConfidantUrl :(int) userid :(NSString*) name : (NSString*) phno :(NSString *) email
{
   
    return [NSString stringWithFormat:@"http://%@:%@/%@/confidant/invitecontact?userid=%@&name=%@&phno=%@&email=%@&sid=%@",self.Host,self.Port,self.AppName,[NSString stringWithFormat:@"%d", userid],name,phno,email,self.appDelegate.sId];
}

-(NSString *) UpdateUserUrl
{
    
        return [NSString stringWithFormat:@"http://%@:%@/%@/user/update?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}

-(NSString *) SearchConfidantsUrl
{

    return [NSString stringWithFormat:@"http://%@:%@/%@/user/confidant/search?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}


/*-(NSString *) ImageUploadUrl  :(NSString *) title
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/attachment/imageupload?title=%@",self.Host,self.Port,self.AppName,title];
 
}*/
//k
-(NSString *) ImageUploadUrl 
{

    return [NSString stringWithFormat:@"http://%@:%@/%@/attachment/imageupload?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];

}


/*-(NSString *) ImageUploadWithUserUrl  :(NSString *) title : (NSString *) username : (NSString *) password
{
    
    NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL,
                                                                                  (CFStringRef)title,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[] ",
                                                                                  kCFStringEncodingUTF8 );
    

    return [NSString stringWithFormat:@"http://%@:%@/%@/attachment/imageupload?title=%@&username=%@&password=%@",self.Host,self.Port,self.AppName,encodedString,username,password];
}*/
//k
-(NSString *) ImageUploadWithUserUrl 
{
       return [NSString stringWithFormat:@"http://%@:%@/%@/attachment/imageupload2?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];

}
-(NSString *) SaveWostUrl
{
   return [NSString stringWithFormat:@"http://%@:%@/%@/wost/create?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}

-(NSString *) WoteUrl :(int) wostid
{
  

    return [NSString stringWithFormat:@"http://%@:%@/%@/Wote/html/Wote.html?id=%d&sid=%@",self.Host,self.Port,self.AppName,wostid,self.appDelegate.sId];
}

-(NSString *) ShareWostUrl
{
     
     return [NSString stringWithFormat:@"http://%@:%@/%@/wost/share?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}




-(NSString*) GetWostById : (int) Id :(NSString *) wotecode
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/wost/details?id=%d&sid=%@&code=%@",self.Host,self.Port,self.AppName,Id,self.appDelegate.sId,wotecode];

}


-(NSString *) GetImageById : (NSString *) Id
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/attachment/getimage?id=%@&sid=%@",self.Host,self.Port,self.AppName,Id,self.appDelegate.sId];
}



-(NSString*)  GetWoteListUrl 
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/wost/wotelist?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}

-(NSString *) WostListUrl: (int) startindex : (int) size
{

    return [NSString stringWithFormat:@"http://%@:%@/%@/wost/list?sid=%@&from=%d&size=%d",self.Host,self.Port,self.AppName,self.appDelegate.sId, startindex, size];
}


-(NSString *) GetWoteResult :(int) wostid
{

    return [NSString stringWithFormat:@"http://%@:%@/%@/wostcomment/list?id=%d&sid=%@",self.Host,self.Port,self.AppName,wostid,self.appDelegate.sId];
   
}



-(NSString *) GetWoteResultForCancelNotification :(int) notificationid
{
    
    return [NSString stringWithFormat:@"http://%@:%@/%@/notification/cancel?id=%d&sid=%@",self.Host,self.Port,self.AppName,notificationid,self.appDelegate.sId];
    
}

-(NSString*) WoteCommentUrl
{
 

    return [NSString stringWithFormat:@"http://%@:%@/%@/wost/wote?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}


-(NSString *) GetNotificationUrl : (NSString*) tokenid
{

//    return [NSString stringWithFormat:@"http://%@:%@/%@/user/registertoken?tokenid=%@&sid=%@",self.Host,self.Port,self.AppName,tokenid,self.appDelegate.sId];
    
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/registertoken?sid=%@&tokenid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId,tokenid];
}

-(NSString *) GetWoteDetailUrl : (int) woteid
{

    return [NSString stringWithFormat:@"http://%@:%@/%@/wote/wotedetail?id=%d&sid=%@",self.Host,self.Port,self.AppName,woteid,self.appDelegate.sId];
}


//-(NSString *) buildWoteUrlForWostId:(int)idd withWoteCode:(NSString *)code
//{
//    //old
//     //return [NSString stringWithFormat:@"http://%@:%@/woportal/html/wote.html?id=%d&code=%@&sid=%@",self.Host,self.Port,idd,code,self.appDelegate.sId];
//    
//    //old comment and new added by csingh
//    return [NSString stringWithFormat:@"http://%@:%@/woportal/html/wote.html?id=%d&code=%@",self.Host,self.Port,idd,code];
//}

-(NSString *) buildWoteUrlForText:(NSString *)url
{    
    return [NSString stringWithFormat:@"http://%@:%@/%@/%@",self.Host,self.Port,self.AppName,url];
}

-(NSString *) getMyWoteListWithStatus:(int) status
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/wost/activityfeed?status=%d&sid=%@",self.Host,self.Port,self.AppName,status,self.appDelegate.sId];

}

-(NSString *) GetUserGroup : (int) userID
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/group/list?userid=%d&sid=%@",self.Host,self.Port,self.AppName,userID,self.appDelegate.sId];
}
-(NSString *) SendCommentUrl: (NSString *) wotecode : (NSString *)comment :(int)wostID
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/wostcomment/comment?wotecode=%@&comment=%@&id=%d&sid=%@",self.Host,self.Port,self.AppName,wotecode,[iOSHelper urlEncode:comment],wostID,self.appDelegate.sId];
}



-(NSString *) sendCommentFromMyWostWithComment : (NSString *)comment wostID:(int)wostID
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/wostcomment/reply?comment=%@&id=%d&sid=%@",self.Host,self.Port,self.AppName,[iOSHelper urlEncode:comment],wostID,self.appDelegate.sId];
}
-(NSString *) CreateGroup
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/group/save?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}

-(NSString *) AddGroupContact
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/group/confidant/add?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}

-(NSString *) GetGroupContact:(int) groupID
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/group/confidant/list?grpid=%d&sid=%@",self.Host,self.Port,self.AppName,groupID,self.appDelegate.sId];
}

-(NSString *) DeleteGroupContact
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/group/confidant/delete?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}
-(NSString *)deleteConfidantUrl
{
     return [NSString stringWithFormat:@"http://%@:%@/%@/user/confidant/delete?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}
-(NSString *) CloseWost :(int) id :(NSString *)decision
{
   return [NSString stringWithFormat:@"http://%@:%@/%@/wost/close?id=%d&decision=%@&sid=%@",self.Host,self.Port,self.AppName,id,decision,self.appDelegate.sId];
}
-(NSString *)preferredConfidants :(NSString *)type :(NSString *)value :(int) cid 
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/confidant/preferredcontact?type=%@&value=%@&cid=%d&sid=%@",self.Host,self.Port,self.AppName,type,value,cid,self.appDelegate.sId];

}
-(NSString *) woteReport: (int) wostid andWote:(NSString *)wote
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/wost/woters?id=%d&sid=%@&wote=%@",self.Host,self.Port,self.AppName,wostid,self.appDelegate.sId,wote];
}
-(NSString *)forgotPasswordWithUserNameUrl:(NSString *) userName
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/forgotpassword?username=%@",self.Host,self.Port,self.AppName,userName];
}
-(NSString *)changePasswordURL
{
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/changepassword?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}
-(NSString *)deleteConfidantUrlWithWostId :(int) wostId
{
    ///wost/delete?sid=1e8058562662253342126899a&id=548
    
    return [NSString stringWithFormat:@"http://%@:%@/%@/wost/delete?sid=%@&id=%d",self.Host,self.Port,self.AppName,self.appDelegate.sId,wostId];
}

-(NSString *)logoutURL
{
    //"/user/logout?sid=001fe2ejld3f2dlf455b1a7"
    return [NSString stringWithFormat:@"http://%@:%@/%@/user/logout?sid=%@",self.Host,self.Port,self.AppName,self.appDelegate.sId];
}
@end
