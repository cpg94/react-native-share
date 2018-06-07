//
//  FacebookShare.m
//  RNShare
//
//  Created by Diseño Uno BBCL and Chris Golding on 04-06-18.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "MessengerShare.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@implementation MessengerShare
- (void)shareSingle:(NSDictionary *)options
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback {
    
    NSLog(@"Try open view");
    
    if ([options objectForKey:@"message"] && [options objectForKey:@"message"] != [NSNull null]) {
        NSString *text = [RCTConvert NSString:options[@"message"]];
        text = [text stringByAppendingString: [@" " stringByAppendingString: options[@"url"]] ];
        text = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef) text, NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
        
        NSString * urlMessenger = [NSString stringWithFormat:@"fb-messenger://share/?link=%@", text];
        NSURL * messengerURL = [NSURL URLWithString:urlMessenger];
        
        if ([[UIApplication sharedApplication] canOpenURL: messengerURL]) {
            [[UIApplication sharedApplication] openURL: messengerURL];
            successCallback(@[]);
        } else {
            // Cannot open whatsapp
            NSString *stringURL = @"https://itunes.apple.com/app/messenger/id454638411";
            NSURL *url = [NSURL URLWithString:stringURL];
            [[UIApplication sharedApplication] openURL:url];
            
            NSString *errorMessage = @"Not installed";
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
            NSError *error = [NSError errorWithDomain:@"com.rnshare" code:1 userInfo:userInfo];
            
            NSLog(errorMessage);
            failureCallback(error);
        }
    }
    
}


@end

