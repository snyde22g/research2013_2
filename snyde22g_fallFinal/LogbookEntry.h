//
//  LogbookEntry.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/3/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogbookEntry : NSObject
{
  NSDate *date;
}

@property (nonatomic, retain, readonly) NSDate *date;

+ (LogbookEntry*)entryWithDate:(NSDate *)date;
- (id)initWithDate:(NSDate *)date;

// maybe implement something like this later?
// - (NSComparisonResult)compare:(LogbookEntry *)otherEntry;

@end
