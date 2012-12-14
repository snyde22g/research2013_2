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
  NSString *identifier;
  NSNumber *number;
}

@property (nonatomic, retain, readonly) NSDate *date;
@property (nonatomic, retain, readonly) NSString *identifier;
@property (nonatomic, retain, readonly) NSNumber *number;

+ (LogbookEntry*)entryWithDate:(NSDate*)date withIdentifier:(NSString*)identifier andNumber:(NSNumber*)number;
- (id)initWithDate:(NSDate*)aDate withIdentifier:(NSString*)aIdentifier andNumber:(NSNumber*)aNumber;

// maybe implement something like this later?
// - (NSComparisonResult)compare:(LogbookEntry *)otherEntry;

@end
