//
//  AppController.m
//  RaiseMan
//
//  Created by Austin Cherry on 5/2/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "AppController.h"
#import "PreferencesController.h"

@implementation AppController

-(IBAction)showPreferencePanel:(id)sender
{
    if(!preferenceController)
        preferenceController = [[PreferencesController alloc] init];
    [preferenceController showWindow:self];
}

-(IBAction)showAboutPanel:(id)sender
{
    [NSBundle loadNibNamed:@"About" owner:self];
	[aboutPanel makeKeyAndOrderFront:nil];
}

@end
