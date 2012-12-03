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
  // Add today to the database (assume it's here for now)
  FallFinalAppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
  NSManagedObjectContext *context =[appDelegate managedObjectContext];
  
  NSManagedObject *newLogbookEntry;
  newLogbookEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
  [newLogbookEntry setValue:[NSDate date] forKey:@"date"];

  NSError *error;
  [context save:&error];
  NSLog(@"Contact saved");
  
  if ((self = [super init])) {
    items = [[NSMutableArray alloc] init];
  }
  return self;
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
//      NSLog(@"Date: %@", [o valueForKey:@"date"]);
      [entries addObject:[LogbookEntry entryWithDate:[o valueForKey:@"date"]]];
    }
    
//    matches = objects[0];
//    _address.text = [matches valueForKey:@"address"];
//    _phone.text = [matches valueForKey:@"phone"];
//    _status.text = [NSString stringWithFormat:@"%d matches found", [objects count]];
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