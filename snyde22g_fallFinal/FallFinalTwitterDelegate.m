//
//  FallFinalTwitterDelegate.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/8/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import "TwitterData.h"
#import "FallFinalTwitterDelegate.h"

@implementation FallFinalTwitterDelegate

- (void) saveNumberOfTwitterFollowersIn:(Day *)newLogbookEntry withContext:(NSManagedObjectContext*)context withPreviousEntry:(Day *)previousEntry {
  account = [[ACAccountStore alloc] init];
  accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
  [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
    if (granted == YES) {
      NSLog(@"Inside twitter block.");
      NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
      
      if ([arrayOfAccounts count] > 0) {
        ACAccount *twitterAccount = [arrayOfAccounts lastObject];
        NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1/users/show.json"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setObject:twitterAccount.username forKey:@"screen_name"];
        [parameters setObject:@"1" forKey:@"include_entities"];
         
        SLRequest *getRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:parameters];
         
        getRequest.account = twitterAccount;
        [getRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
          // create the new twitter object
          TwitterData *twitter = (TwitterData *)[NSEntityDescription insertNewObjectForEntityForName:@"TwitterData" inManagedObjectContext:context];
          
          // only log the number of followers
          NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
          twitter.numberOfFollowers = [NSNumber numberWithInt:[[jsonData valueForKey:@"followers_count"] intValue]];
          twitter.forDay = newLogbookEntry;
          newLogbookEntry.twitterData = twitter;
          
          // calculate delta
          
          [context save:&error];
        }];
      } else {
        // Handle failure to get account access
        NSLog(@"Request failed.");
      }
    }
  }];
}

@end
