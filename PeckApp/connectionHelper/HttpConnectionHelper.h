//
//  HttpConnectionHelper.h
//  WoApp
//
//  Created by pdixit on 06/10/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface HttpConnectionHelper : NSObject
{
    NSString * Host;
    NSString * Port;
    NSString * AppName;
}


@property (nonatomic,retain) NSString * Host;
@property (nonatomic,retain) NSString * Port;
@property ( nonatomic,retain) NSString * AppName;
@property ( nonatomic,retain) NSString * SID;
-(NSString *) EncoadingString : (NSString *) string;
-(NSString *) fbLoginUrl :(NSString*) fbSession;
-(NSString *) LoginUrl :(NSString*) username : (NSString*)password;
-(NSString *) Login2Url;
-(NSString *) RegistrationUrl;
-(NSString *) UserVerificationUrl;
-(NSString *) UserDetailUrl :(int) userid;
-(NSString *) ConfidantListUrl :(int) userid;

-(NSString *) ConfermationUrl:(NSString *) regcode :(NSString *) email;

-(NSString *) AddConfidantUrl ;
-(NSString *) InviteConfidantUrl :(int) userid :(NSString*) name : (NSString*) phno :(NSString *) email;

-(NSString *) UpdateUserUrl ;

-(NSString *) SearchConfidantsUrl;

//-(NSString *) ImageUploadUrl  :(NSString *) title;
-(NSString *) ImageUploadUrl ;
//-(NSString *) ImageUploadWithUserUrl  :(NSString *) title : (NSString *) username : (NSString *) password;
-(NSString *) ImageUploadWithUserUrl;
-(NSString *) SaveWostUrl;

-(NSString *) WoteUrl :(int) wostid;

-(NSString *) ShareWostUrl ;

-(NSString *) GetImageById : (NSString *) Id;


-(NSString*)  GetWoteListUrl;

-(NSString *) GetWoteResult : (int) wostid;
-(NSString *) GetWoteResultForCancelNotification :(int) notificationid;

-(NSString *) WostListUrl: (int) startindex : (int) size;
-(NSString*) GetWostById : (int) Id :(NSString *) wotecode;

-(NSString*) WoteCommentUrl ;

-(NSString *) GetNotificationUrl : (NSString*) tokenid;

-(NSString *) GetWoteDetailUrl : (int) woteid;

//-(NSString *) buildWoteUrlForWostId : (int) idd withWoteCode:(NSString *) code;

-(NSString *) buildWoteUrlForText : (NSString *) url;

-(NSString *) getMyWoteListWithStatus:(int) status ;

-(NSString *) GetUserGroup : (int) userID ;

-(NSString *) SendCommentUrl: (NSString *) wotecode : (NSString *)comment :(int)wostID;
-(NSString *) sendCommentFromMyWostWithComment : (NSString *)comment wostID:(int)wostID;

-(NSString *) CreateGroup;

-(NSString *) AddGroupContact;

-(NSString *) GetGroupContact : (int) groupID;

-(NSString *) DeleteGroupContact;
-(NSString *) CloseWost:(int) id :(NSString *)decision;

-(NSString *) woteReport: (int) wostid andWote:(NSString *)wote;

-(NSString *)deleteConfidantUrl;
-(NSString *)forgotPasswordWithUserNameUrl:(NSString *) userName;
-(NSString *)preferredConfidants :(NSString *)type :(NSString *)value :(int) cid;
-(NSString *)changePasswordURL;
-(NSString *)deleteConfidantUrlWithWostId :(int) wostId;
-(NSString *) logoutURL;
@end
