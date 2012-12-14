//
//  FallFinalFacebookDelegate.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/12/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

#import "Day.h"
#import "FallFinalAppDelegate.h"

@interface FallFinalFacebookDelegate : NSObject

-(void) saveNumberOfFacebookFriendsIn:(Day *)newLogbookEntry withContext:(NSManagedObjectContext*)context withPreviousEntry:(Day *)previousEntry;

@end
