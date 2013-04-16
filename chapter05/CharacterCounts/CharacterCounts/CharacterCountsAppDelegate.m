//
//  CharacterCountsAppDelegate.m
//  CharacterCounts
//
//  Created by Austin Cherry on 4/13/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "CharacterCountsAppDelegate.h"

@implementation CharacterCountsAppDelegate

@synthesize textField, charLabel;

- (IBAction)countChars:(id)sender
{
    charLabel.stringValue = [NSString stringWithFormat:@"%@ has %ld characters.",textField.stringValue,(unsigned long)textField.stringValue.length];
}
@end
