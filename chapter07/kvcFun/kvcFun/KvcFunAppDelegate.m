//
//  KvcFunAppDelegate.m
//  kvcFun
//
//  Created by Austin Cherry on 4/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "KvcFunAppDelegate.h"

@implementation KvcFunAppDelegate

@synthesize fido;

-(id)init
{
    if(self = [super init])
    {
        [self setValue:[NSNumber numberWithInt:5] forKey:@"fido"];
        NSNumber *n = [self valueForKey:@"fido"];
        NSLog(@"fido = %@",n);
    }
    return self;
}

-(IBAction)incrementFido:(id)sender
{
    [self setFido:[self fido] + 1];
}
@end
