//
//  LogbookEntry.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/3/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import "LogbookEntry.h"

@implementation LogbookEntry

@synthesize date;

+ (LogbookEntry*)entryWithDate:(NSDate *)aDate;
{
  return [[LogbookEntry alloc] initWithDate:aDate];
}

- (id)initWithDate:(NSDate *)aDate
{
  if ((self = [super init])) {
    date = aDate;
  }
  
  return self;
}

@end
