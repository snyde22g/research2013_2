//
//  LogbookDetailViewController.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/13/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import "LogbookEntry.h"

@interface LogbookDetailViewController : UIViewController
{
  LogbookEntry *entry;
}

- (id)initWithLogbookEntry:(LogbookEntry *)aEntry;

@end
