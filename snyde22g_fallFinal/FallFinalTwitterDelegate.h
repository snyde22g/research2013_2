//
//  FallFinalTwitterDelegate.h
//  snyde22g_fallFinal
//
//  Created by Gabby Snyder on 12/8/12.
//  Copyright (c) 2012 Gabby Snyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface FallFinalTwitterDelegate : NSObject {
  ACAccountStore *account;
  ACAccountType *accountType;
}

-(int) numberOfTwitterFollowers;

@end
