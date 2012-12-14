//
//  FallFinalTwitterDelegate.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/8/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

#import "Day.h"
#import "LogbookEntry.h"

@interface FallFinalTwitterDelegate : NSObject {
  ACAccountStore *account;
  ACAccountType *accountType;
}

- (void) saveNumberOfTwitterFollowersIn:(Day *)newLogbookEntry withContext:(NSManagedObjectContext*)context withPreviousEntry:(Day *)previousEntry;

@end
