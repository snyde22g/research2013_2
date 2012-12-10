//
//  FallFinalTwitterDelegate.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/8/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import "FallFinalTwitterDelegate.h"

@implementation FallFinalTwitterDelegate

- (int) numberOfTwitterFollowers {  
  __block int followerCount = -1;
  account = [[ACAccountStore alloc] init];
  accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
//  [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
//    if (granted == YES) {
//      NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
//       if ([arrayOfAccounts count] > 0) {
//         ACAccount *twitterAccount = [arrayOfAccounts lastObject];
//         
//         NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1/users/show.json"];
//         
//         NSMutableDictionary *parameters =
//         [[NSMutableDictionary alloc] init];
//         [parameters setObject:twitterAccount.username forKey:@"screen_name"];
//         [parameters setObject:@"1" forKey:@"include_entities"];
//         
//         SLRequest *getRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:parameters];
//         
//         getRequest.account = twitterAccount;
//         [getRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//            // only log the number of followers
//            NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//            followerCount = (int) [jsonData valueForKey:@"followers_count"];
//            // [twitterData setValue: [jsonData valueForKey:@"followers_count"] forKey:@"numberOfFollowers"];
//          }
//          ];
//       } else {
//         // Handle failure to get account access
//         NSLog(@"Request failed.");
//       }
//   }
//                                   }];
  // error!
  NSLog(@"follower count: %i", followerCount);
  return followerCount;
}

@end
