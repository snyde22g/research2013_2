//
//  LogbookDailyDataRetriever.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/3/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Kal.h>

@interface LogbookDailyDataRetriever : NSObject <KalDataSource>
{
  NSMutableArray *items;
  NSMutableArray *entries;
}

+ (LogbookDailyDataRetriever *)dataSource;

- (LogbookEntry *)entryAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
