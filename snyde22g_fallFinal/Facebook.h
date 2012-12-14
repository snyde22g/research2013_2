//
//  Facebook.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/14/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day;

@interface Facebook : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfFriends;
@property (nonatomic, retain) NSNumber * deltaFriends;
@property (nonatomic, retain) Day *forDay;

@end
