//
//  LotteryEntry.h
//  lottery
//
//  Created by Austin Cherry on 4/13/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryEntry : NSObject

@property(nonatomic,strong)NSDate *entryDate;
@property(nonatomic)int firstNumber;
@property(nonatomic)int secondNumber;

-(id)initWithEntryDate:(NSDate *)theDate;

@end
