//
//  LogbookEntry.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/3/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

/* This class is somewhat bizarre due to how entries are stored in the table below the calendar.
 * Every date has two entries, technically - one for facebook and one for Twitter. Each entry is
 * displayed in its own row in the table below. That's why, when initializing, we collect three
 * parameters:
 *   - The date that this logbook entry is associated with.
 *   - The string we want displayed to the left of this entry, identifying what this number means.
 *   - The number itself.
 *
 * There may be a better way of doing this.
 */

#import "LogbookEntry.h"

@implementation LogbookEntry

@synthesize date, identifier, number;

+ (LogbookEntry*)entryWithDate:(NSDate*)date withIdentifier:(NSString*)identifier andNumber:(NSNumber*)number
{
  return [[LogbookEntry alloc] initWithDate:date withIdentifier:identifier andNumber:number];
}

- (id)initWithDate:(NSDate*)aDate withIdentifier:(NSString*)aIdentifier andNumber:(NSNumber*)aNumber
{
  if ((self = [super init])) {
    date = aDate;
    identifier = aIdentifier;
    number = aNumber;
  }
  
  return self;
}

@end
