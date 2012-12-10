//
//  FallFinalAppDelegate.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/3/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kal.h"
#import "FallFinalTwitterDelegate.h"

@interface FallFinalAppDelegate : UIResponder <UIApplicationDelegate>
{
  UINavigationController *navController;
  KalViewController *kal;
  id dataSource;
  
  // twitter object
  FallFinalTwitterDelegate *twitterDelegate;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
