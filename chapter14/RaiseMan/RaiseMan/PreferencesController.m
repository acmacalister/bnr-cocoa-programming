//
//  PreferencesController.m
//  RaiseMan
//
//  Created by Austin Cherry on 5/2/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "PreferencesController.h"

NSString * const BNRTableBgColorKey = @"BNRTableBackgroundColor";
NSString * const BNREmptyDocKey = @"BNREmptyDocumentFlag";
NSString * const BNRColorChangedNotification = @"BNRColorChanged";

@interface PreferencesController ()

@end

@implementation PreferencesController

-(id)init
{
    self = [super initWithWindowNibName:@"Preferences"];
    return self;
}

- (void)reloadFromPreferences
{
	[colorWell setColor:[PreferencesController preferenceTableBgColor]];
	[checkbox setState:[PreferencesController preferenceEmptyDoc]];
}

-(void)windowDidLoad
{
    [super windowDidLoad];
    [self reloadFromPreferences];
}

-(IBAction)changeBackgroundColor:(id)sender
{
    NSColor *color = [colorWell color];
    [PreferencesController setPreferenceTableBgColor:color];
    [[NSNotificationCenter defaultCenter] postNotificationName:BNRColorChangedNotification object:self userInfo:@{@"color":color}];
}

-(IBAction)changeNewEmptyDoc:(id)sender
{
    NSInteger state = [checkbox state];
    [PreferencesController setPreferenceEmptyDoc:state];
}

-(IBAction)resetDefaults:(id)sender
{
    NSArray *allDefaultKeys = [NSArray arrayWithObjects:BNRTableBgColorKey, BNREmptyDocKey, nil];
	for (NSString *key in allDefaultKeys)
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
	[self reloadFromPreferences];
}

+(NSColor *)preferenceTableBgColor
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *colorAsData = [defaults objectForKey:BNRTableBgColorKey];
    return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

+(void)setPreferenceTableBgColor:(NSColor *)color
{
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
    [[NSUserDefaults standardUserDefaults] setObject:colorAsData forKey:BNRTableBgColorKey];
}

+(BOOL)preferenceEmptyDoc
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:BNREmptyDocKey];
}

+(void)setPreferenceEmptyDoc:(BOOL)emptyDoc
{
    [[NSUserDefaults standardUserDefaults] setBool:emptyDoc forKey:BNREmptyDocKey];
}

@end
