//
//  Person.m
//  RaiseMan
//
//  Created by Austin Cherry on 4/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize personName, expectedRaise;

-(id)init
{
    if(self = [super init])
    {
        self.expectedRaise = 0.05;
        self.personName = @"New Person";
    }
    return self;
}

-(void)setNilValueForKey:(NSString *)key
{
    if([key isEqual:@"expectedRaise"])
        self.expectedRaise = 0.0;
    else
        [super setNilValueForKey:key];
            
}

@end
