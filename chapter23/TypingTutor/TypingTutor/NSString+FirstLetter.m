//
//  NSString+FirstLetter.m
//  TypingTutor
//
//  Created by Austin Cherry on 6/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "NSString+FirstLetter.h"

@implementation NSString (FirstLetter)

-(NSString *)bnr_firstLetter
{
    if([self length] < 2)
        return self;
    NSRange r;
    r.location = 0;
    r.length = 1;
    return [self substringWithRange:r];
}

@end
