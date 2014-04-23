//
//  ActionSheet.h
//  Wo.iPhone
//
//  Created by pdixit on 04/12/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionSheet : NSObject <UIActionSheetDelegate>


typedef void (^ActionSheetCompletionBlock)(NSInteger buttonIndex);

+(void)showActionSheet:(NSString*)title :(NSArray *)buttons :(UIView*) view :(ActionSheetCompletionBlock) callback;

@end
