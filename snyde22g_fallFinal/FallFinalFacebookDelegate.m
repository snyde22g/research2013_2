//
//  FallFinalFacebookDelegate.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/12/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import "FacebookData.h"
#import "FallFinalFacebookDelegate.h"

@implementation FallFinalFacebookDelegate

-(void) saveNumberOfFacebookFriendsIn:(Day *)newLogbookEntry withContext:(NSManagedObjectContext*)context withPreviousEntry:(Day *)previousEntry {
  // first try to log in:
  FallFinalAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
  [appDelegate openSession];
  
  [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id<FBGraphUser> user, NSError *error) {
    // try to get the list of friends here
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
      NSArray* friends = [result objectForKey:@"data"];

      FacebookData *facebook = (FacebookData *)[NSEntityDescription insertNewObjectForEntityForName:@"FacebookData" inManagedObjectContext:context];
      facebook.numberOfFriends = [NSNumber numberWithInt:friends.count];
      facebook.forDay = newLogbookEntry;
      newLogbookEntry.facebookData = facebook;
      
      // calculate delta. 
      
      [context save:&error];
    }];
  }];
}

@end
