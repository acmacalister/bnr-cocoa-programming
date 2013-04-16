//
//  main.m
//  lottery
//
//  Created by Austin Cherry on 4/12/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LotteryEntry.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool
    {
        NSDate *now = [[NSDate alloc] init];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *weekComponents = [[NSDateComponents alloc] init];
        
        srandom((unsigned)time(NULL));
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(int i = 0; i < 10; i++)
        {
            [weekComponents setWeek:i];
            
            NSDate *iWeeksFromNow;
            iWeeksFromNow = [cal dateByAddingComponents:weekComponents toDate:now options:0];
            
            LotteryEntry *newEntry = [[LotteryEntry alloc] initWithEntryDate:iWeeksFromNow];
            
            [array addObject:newEntry];
            NSLog(@"%@",array[i]);
        }
    }
    return 0;
}

