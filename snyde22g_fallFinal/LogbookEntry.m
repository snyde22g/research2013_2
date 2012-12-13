//
//  LogbookEntry.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/3/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

/* When we create this class, we are creating a logbook entry to be added directly into
 * the Core Data database. Therefore, when we initialize we want to follow the following
 * steps:
 *   - Initialize date with the current date/time
 *   - Fetch the current number of twitter followers
 *   - Fetch the current number of facebook friends
 */

#import "LogbookEntry.h"

@implementation LogbookEntry

@synthesize date, twitterFollowers;

+ (LogbookEntry*)entryWithDate:(NSDate*)date
{
  return [[LogbookEntry alloc] init];
}

- (id)initWithDate:(NSDate*)aDate
{
  if ((self = [super init])) {
    date = aDate;
  }
  
  return self;
}

//- (void) fetchTwitterInformation {
//  ACAccountStore *account = [[ACAccountStore alloc] init];
//  ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
//  [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
//    if (granted == YES) {
//      NSLog(@"Inside twitter block.");
//      NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
//      
//      if ([arrayOfAccounts count] > 0) {
//        ACAccount *twitterAccount = [arrayOfAccounts lastObject];
//        NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1/users/show.json"];
//        
//        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//        [parameters setObject:twitterAccount.username forKey:@"screen_name"];
//        [parameters setObject:@"1" forKey:@"include_entities"];
//        
//        SLRequest *getRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:parameters];
//        
//        getRequest.account = twitterAccount;
//        [getRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//          // only log the number of followers
//          NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//          NSLog(@"follower count: %@", [jsonData valueForKey:@"followers_count"]);
//          twitterFollowers = [NSNumber numberWithInt:[[jsonData valueForKey:@"followers_count"] intValue]];
//          [self twitterAPICallsCompleted];
//        }];
//      } else {
//        // Handle failure to get account access
//        NSLog(@"Request failed.");
//      }
//    }
//  }];
//}
//
//// Saves that we completed our twitter API calls, then if all other calls are complete, calls safeCompletedLogbookEntry
//- (void) twitterAPICallsCompleted {
//  NSLog(@"Twitter calls completed.");
//}
//
//// Only called after both facebook and twitter have completed any necessary data calls, saves this entry to core data.
//- (void) saveCompletedLogbookEntry {
//  
//}

@end
