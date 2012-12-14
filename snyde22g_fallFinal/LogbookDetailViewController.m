//
//  LogbookDetailViewController.m
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/13/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import "LogbookDetailViewController.h"
#import "LogbookEntry.h"

@implementation LogbookDetailViewController

- (id)initWithLogbookEntry:(LogbookEntry *)aEntry
{
  if ((self = [super init])) {
    entry = aEntry;
  }
  return self;
}

- (void)loadView
{
  UILabel *label = [[UILabel alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  label.text = [NSString stringWithFormat:@"%@ %@", entry.identifier, [entry.number description]];
//  label.textAlignment = UITextAlignmentCenter;
  self.view = label;
}

@end
