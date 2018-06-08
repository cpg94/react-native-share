//
//  FacebookShare.m
//  RNShare
//
//  Created by Diseño Uno BBCL and Chris Golding on 04-06-18.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "MessengerShare.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "FBMessengerShare.h"


@implementation MessengerShare
- (void)shareSingle:(NSDictionary *)options
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback {
    
    
    
    if ([options objectForKey:@"message"] && [options objectForKey:@"message"] != [NSNull null]) {
          dispatch_async(dispatch_get_main_queue(), ^{
              NSString *message = [RCTConvert NSString:options[@"message"]];
              NSString *url = [RCTConvert NSString:options[@"url"]];
              NSString *appId = [RCTConvert NSString:options[@"appId"]];
    FBSDKShareMessengerURLActionButton *urlButton = [[FBSDKShareMessengerURLActionButton alloc] init];
    urlButton.title = message;
    urlButton.url = [NSURL URLWithString:url];
    
    FBSDKShareMessengerGenericTemplateElement *element = [[FBSDKShareMessengerGenericTemplateElement alloc] init];
    element.title = url;
    element.button = urlButton;
    
    FBSDKShareMessengerGenericTemplateContent *content = [[FBSDKShareMessengerGenericTemplateContent alloc] init];
    content.pageID = appId;
    content.element = element;
    
    FBSDKMessageDialog *messageDialog = [[FBSDKMessageDialog alloc] init];
    messageDialog.shareContent = content;
    
    if ([messageDialog canShow]) {
      [messageDialog show];
    }
  });
    }
    
}


@end

