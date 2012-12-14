//
//  Twitter.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/14/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day;

@interface Twitter : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfFollowers;
@property (nonatomic, retain) NSNumber * deltaFollowers;
@property (nonatomic, retain) Day *forDay;

@end
