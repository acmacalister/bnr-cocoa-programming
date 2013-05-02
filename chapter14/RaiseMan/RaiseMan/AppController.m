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

+(void)initialize
{
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
    [defaultValues setObject:colorAsData forKey:BNRTableBgColorKey];
    [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:BNREmptyDocKey];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

-(BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
    return [PreferencesController preferenceEmptyDoc];
}

-(void)applicationDidResignActive:(NSNotification *)note
{
    NSLog(@"Got note: %@",note);
    NSBeep();
}

@end
