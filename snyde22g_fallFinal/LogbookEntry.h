//
//  LogbookEntry.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/3/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface LogbookEntry : NSObject
{
  NSDate *date;
  NSNumber *twitterFollowers;
}

@property (nonatomic, retain, readonly) NSDate *date;
@property (nonatomic, retain, readonly) NSNumber *twitterFollowers;

+ (LogbookEntry*)entryWithDate:(NSDate*)date;
- (id)initWithDate:(NSDate*)aDate;

// maybe implement something like this later?
// - (NSComparisonResult)compare:(LogbookEntry *)otherEntry;

@end
