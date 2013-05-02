//
//  CarArrayController.m
//  CarLot
//
//  Created by Austin Cherry on 5/1/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "CarArrayController.h"

@implementation CarArrayController

-(id)newObject
{
    id newObject = [super newObject];
    NSDate *now = [NSDate date];
    [newObject setValue:now forKey:@"datePurchased"];
    return newObject;
}

@end
