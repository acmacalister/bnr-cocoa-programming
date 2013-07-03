//
//  ColorFormatter.m
//  TypingTutor
//
//  Created by Austin Cherry on 6/24/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "ColorFormatter.h"

@interface ColorFormatter()
-(NSString *)firstColorKeyForPartialString:(NSString *)string;
@end

@implementation ColorFormatter

-(id)init
{
    self = [super init];
    if(self)
    {
        colorList = [NSColorList colorListNamed:@"Apple"];
    }
    return self;
}

-(NSString *)firstColorKeyForPartialString:(NSString *)string
{
    if([string length] == 0)
        return nil;
    for(NSString *key in [colorList allKeys])
    {
        NSRange whereFound = [key rangeOfString:string options:NSCaseInsensitiveSearch];
        if((whereFound.location == 0) && (whereFound.length > 0))
            return key;
    }
    return nil;
}

-(NSString *)stringForObjectValue:(id)obj
{
    if(![obj isKindOfClass:[NSColor class]])
        return nil;
    NSColor *color = [obj colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    CGFloat red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:NULL];
    
    float minDistance = 3.0;
    NSString *closetKey = nil;
    
    for(NSString *key in [colorList allKeys])
    {
        NSColor *c = [colorList colorWithKey:key];
        CGFloat r, g, b;
        [c getRed:&r green:&g blue:&b alpha:NULL];
        
        float dist;
        dist = pow(red -r,2) + pow(green - g, 2) + pow(blue - b,2);
        if(dist < minDistance)
        {
            minDistance = dist;
            closetKey = key;
        }
    }
    return closetKey;
}

-(NSAttributedString *)attributedStringForObjectValue:(id)obj withDefaultAttributes:(NSDictionary *)attrs
{
    NSString *match = [self stringForObjectValue:obj];
    if(!match)
        return nil;
    
    NSMutableDictionary *attDict = [attrs mutableCopy];
    [attDict setObject:obj forKey:NSForegroundColorAttributeName];
    NSAttributedString *atString = [[NSAttributedString alloc] initWithString:match attributes:attDict];
    return atString;
}

-(BOOL)getObjectValue:(out __autoreleasing id *)obj forString:(NSString *)string errorDescription:(out NSString *__autoreleasing *)error
{
    NSString *matchingKey = [self firstColorKeyForPartialString:string];
    if(matchingKey)
    {
        *obj = [colorList colorWithKey:matchingKey];
        return YES;
    }
    else
    {
        if(error != NULL)
            *error = [NSString stringWithFormat:@"%@ is not a color.", string];
        return NO;
    }
}

/*-(BOOL)isPartialStringValid:(NSString *)partialString newEditingString:(NSString *__autoreleasing *)newString errorDescription:(NSString *__autoreleasing *)error
{
    if([partialString length] == 0)
        return YES;
    NSString *match = [self firstColorKeyForPartialString:partialString];
    if(match)
        return YES;
    else
    {
        if(error)
            *error = @"No such color";
        return NO;
    }
} */

-(BOOL)isPartialStringValid:(NSString *__autoreleasing *)partialStringPtr proposedSelectedRange:(NSRangePointer)proposedSelRangePtr originalString:(NSString *)origString originalSelectedRange:(NSRange)origSelRange errorDescription:(NSString *__autoreleasing *)error
{
    if([*partialStringPtr length] == 0)
        return YES;
    NSString *match = [self firstColorKeyForPartialString:*partialStringPtr];
    if(!match)
        return NO;
    
    if(origSelRange.location == proposedSelRangePtr->location)
        return YES;
    
    if([match length] != [*partialStringPtr length])
    {
        proposedSelRangePtr->location = [*partialStringPtr length];
        proposedSelRangePtr->length = [match length] - proposedSelRangePtr->location;
        *partialStringPtr = match;
        return NO;
    }
    return YES;
}

@end
