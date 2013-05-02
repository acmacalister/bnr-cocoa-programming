//
//  PreferencesController.h
//  RaiseMan
//
//  Created by Austin Cherry on 5/2/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const BNRTableBgColorKey;
extern NSString * const BNREmptyDocKey;
extern NSString * const BNRColorChangedNotification;

@interface PreferencesController : NSWindowController
{
    IBOutlet NSColorWell *colorWell;
    IBOutlet NSButton *checkbox;
}

-(IBAction)changeBackgroundColor:(id)sender;
-(IBAction)changeNewEmptyDoc:(id)sender;
-(IBAction)resetDefaults:(id)sender;

+(NSColor *)preferenceTableBgColor;
+(void)setPreferenceTableBgColor:(NSColor *)color;
+(BOOL)preferenceEmptyDoc;
+(void)setPreferenceEmptyDoc:(BOOL)emptyDoc;

@end
