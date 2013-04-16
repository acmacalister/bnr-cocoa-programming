//
//  LotteryEntry.m
//  lottery
//
//  Created by Austin Cherry on 4/13/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "LotteryEntry.h"

@implementation LotteryEntry

@synthesize entryDate,firstNumber,secondNumber;

-(id)init
{
    return [self initWithEntryDate:[NSDate date]];
}

-(id)initWithEntryDate:(NSDate *)theDate
{
    self = [super init];
    if(self)
    {
        entryDate = theDate;
        firstNumber = ((int)random() % 100) + 1;
        secondNumber = ((int)random() % 100) + 1;
    }
    return self;
}

-(NSString *)description
{
    static NSDateFormatter *df = nil;
    if(!df)
    {
        df = [[NSDateFormatter alloc] init];
        [df setTimeStyle:NSDateFormatterNoStyle];
        //[df setDateStyle:NSDateFormatterMediumStyle];
        [df setDateFormat:@"MMM EEE h:mm a"];
    }
    return [NSString stringWithFormat:@"%@ = %d and %d",[df stringFromDate:entryDate],firstNumber,secondNumber];
}

@end
