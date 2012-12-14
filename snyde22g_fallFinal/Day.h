//
//  Day.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/14/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FacebookData, TwitterData;

@interface Day : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * facebookFriends;
@property (nonatomic, retain) TwitterData *twitterData;
@property (nonatomic, retain) FacebookData *facebookData;

@end
