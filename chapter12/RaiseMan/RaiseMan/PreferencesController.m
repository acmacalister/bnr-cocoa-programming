//
//  PreferencesController.m
//  RaiseMan
//
//  Created by Austin Cherry on 5/2/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "PreferencesController.h"

@interface PreferencesController ()

@end

@implementation PreferencesController

-(id)init
{
    self = [super initWithWindowNibName:@"Preferences"];
    return self;
}

-(void)windowDidLoad
{
    [super windowDidLoad];
}

-(IBAction)changeBackgroundColor:(id)sender
{
    NSColor *color = [colorWell color];
}

-(IBAction)changeNewEmptyDoc:(id)sender
{
    NSInteger state = [checkbox state];
}

@end
