//
//  FallFinalAppDelegate.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/3/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import "Kal.h"
#import "FallFinalAppDelegate.h"
#import "LogbookDailyDataRetriever.h"
#import "FallFinalTwitterDelegate.h"

@implementation FallFinalAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // Add new entry to the database
  [self createNewLogbookEntryWithDate:[NSDate date]];
  
  // Initialize Kal
  kal = [[KalViewController alloc] init];
  kal.title = @"Logbook";
  kal.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(showAndSelectToday)];
  dataSource = [[LogbookDailyDataRetriever alloc] init];
  kal.dataSource = dataSource;
  
  // Setup the navigation stack and display it.
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  navController = [[UINavigationController alloc] initWithRootViewController:kal];
  [self.window addSubview:navController.view];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)createNewLogbookEntryWithDate:(NSDate *)targetDate {
  dispatch_async(dispatch_get_main_queue(), ^{
    // check to see if we already have a date for today.
    FallFinalAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =[appDelegate managedObjectContext];
  
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Day" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
  
    NSError *error;
    NSArray *lastDateRetreieved = [context executeFetchRequest:request error:&error];
//  if ([lastDateRetreieved count] > 0) {
//    
//    // we want to create a new entry only if it's been at least one day since the user last checked. this means...
//    // - it could be the same day
//    // - it could be a different day, but 24 hours haven't passed.
//    // - it could be a different day and 24 hours have passed.
//    // For our purposes, we only want to create a new day if one of the later two are true.
//    
//    // time interval since last checked.
//    NSTimeInterval timeIntervalSinceLastEntry = [[[lastDateRetreieved lastObject] valueForKey:@"date"] timeIntervalSinceNow];
//    
//    if (timeIntervalSinceLastEntry <= 86400) {
//      // we're within that 24 hour window, we should probably do some more math.
//      // compare the date now to the date of the last entry in objects.
//      NSDateComponents *lastRetrieved = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[[lastDateRetreieved lastObject] valueForKey:@"date"]];
//      NSDateComponents *todaysDate = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
//      
//      if ( ([lastRetrieved day] == [todaysDate day]) ) {
//        // we're still on the same day, get out of here.
//        return;
//      }
//    }
//  }
  
  // create new date entry, new thread because stuff is freezing D:
    NSLog(@"new entry");
    NSManagedObject *newLogbookEntry;
    newLogbookEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
    [newLogbookEntry setValue:[NSDate date] forKey:@"date"];
    
    // add number of twitter followers
    twitterDelegate = [[FallFinalTwitterDelegate alloc] init];
    [twitterDelegate saveNumberOfTwitterFollowersIn:newLogbookEntry withContext:context];
    
    [context save:&error];
    NSLog(@"Contact saved");
  });
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Saves changes in the application's managed object context before the application terminates.
  [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"snyde22g_fallFinal" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"snyde22g_fallFinal.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
