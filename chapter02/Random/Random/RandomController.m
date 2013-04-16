//
//  RandomController.m
//  Random
//
//  Created by Austin Cherry on 4/12/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "RandomController.h"

@implementation RandomController

-(IBAction)generate:(id)sender
{
    int generated = (int)(random() % 100) + 1;
    NSLog(@"generated = %d",generated);
    [textField setIntValue:generated];
}

-(IBAction)seed:(id)sender
{
    srandom((unsigned)time(NULL));
    [textField setStringValue:@"Generated seeded"];
}

-(void)awakeFromNib
{
    NSDate *now = [NSDate date];
    [textField setObjectValue:now];
}

@end
