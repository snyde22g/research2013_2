//
//  LogbookDailyDataRetriever.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/3/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import "FallFinalAppDelegate.h"
#import "LogbookEntry.h"
#import "LogbookDailyDataRetriever.h"

@implementation LogbookDailyDataRetriever

@synthesize fetchedResultsController,managedObjectContext;

#pragma mark initialization stuff

+ (LogbookDailyDataRetriever *)dataSource
{
  return [[[self class] alloc] init];
}

- (id)init
{
  if ((self = [super init])) {
    items = [[NSMutableArray alloc] init];
    entries = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (void)createNewLogbookEntryWithDate:(NSDate *)targetDate {
  // check to see if we already have a date for today.
  FallFinalAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  NSManagedObjectContext *context =[appDelegate managedObjectContext];
  
  NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Day" inManagedObjectContext:context];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDesc];
  
  NSError *error;
  NSArray *lastDateRetreieved = [context executeFetchRequest:request error:&error];
  if ([lastDateRetreieved count] > 0) {
    
    // we want to create a new entry only if it's been at least one day since the user last checked. this means...
    // - it could be the same day
    // - it could be a different day, but 24 hours haven't passed.
    // - it could be a different day and 24 hours have passed.
    // For our purposes, we only want to create a new day if one of the later two are true.
    
    // time interval since last checked.
    NSTimeInterval timeIntervalSinceLastEntry = [[[lastDateRetreieved lastObject] valueForKey:@"date"] timeIntervalSinceNow];
    
    if (timeIntervalSinceLastEntry <= 86400) {
      // we're within that 24 hour window, we should probably do some more math.
      // compare the date now to the date of the last entry in objects.
      NSDateComponents *lastRetrieved = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[[lastDateRetreieved lastObject] valueForKey:@"date"]];
      NSDateComponents *todaysDate = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
      
      if ( ([lastRetrieved day] == [todaysDate day]) ) {
        // we're still on the same day, get out of here.
        return;
      }
    }
  }
  
    // create new date entry
    NSLog(@"new entry");
    NSManagedObject *newLogbookEntry;
    newLogbookEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
    [newLogbookEntry setValue:[NSDate date] forKey:@"date"];
    
    [context save:&error];
    NSLog(@"Contact saved");
}

#pragma mark core data stuff

- (NSArray *)loadEntriesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)delegate
{
  FallFinalAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  NSManagedObjectContext *context =[appDelegate managedObjectContext];
  
  NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Day" inManagedObjectContext:context];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDesc];
  
  // Maybe add in eventually - allows for more specific loading of data.
  //  NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", _name.text];
  //  [request setPredicate:pred];
  
  NSError *error;
  NSArray *objects = [context executeFetchRequest:request error:&error];
  
  NSArray *matches;
  if ([objects count] == 0) {
    NSLog(@"No matches");
  } else {
    // create a new LogbookEntry object for each core data thing found.
    for (NSManagedObject *o in objects) {
      NSLog(@"Date: %@", [o valueForKey:@"date"]);
      [entries addObject:[LogbookEntry entryWithDate:[o valueForKey:@"date"]]];
    }
    
    NSLog(@"entries size: %u", entries.count);
  }
  
  return matches;
}

- (NSArray *)entriesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
  NSMutableArray *matches = [NSMutableArray array];
  for (LogbookEntry *entry in entries) {
    if ([self date:entry.date isBetweenDate:fromDate andDate:toDate]) {
      [matches addObject:entry];
    }
  }
  
  return matches;
}

- (BOOL) date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
  return (([date compare:beginDate] != NSOrderedAscending) && ([date compare:endDate] != NSOrderedDescending));
}

#pragma mark KalDataSource protocol conformance

- (void)presentingDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)delegate
{
  [entries removeAllObjects];
  [self loadEntriesFrom:fromDate to:toDate delegate:delegate];
}

- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
  NSArray *temp = [[self entriesFrom:fromDate to:toDate] valueForKeyPath:@"date"];
  
  NSLog(@"Array size: %i", temp.count);
  
  return [[self entriesFrom:fromDate to:toDate] valueForKeyPath:@"date"];
}

- (void)loadItemsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
   [items addObjectsFromArray:[self entriesFrom:fromDate to:toDate]];
}

- (void)removeAllItems
{
  [items removeAllObjects];
}

#pragma mark UITableViewDataSource protocol conformance

- (LogbookEntry *)entryAtIndexPath:(NSIndexPath *)indexPath
{
  return [items objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"MyCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
  }
  
  LogbookEntry *entry = [self entryAtIndexPath:indexPath];
  cell.textLabel.text = [entry.date description];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [items count];
}

@end
