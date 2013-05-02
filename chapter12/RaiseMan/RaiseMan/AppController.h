//
//  AppController.h
//  RaiseMan
//
//  Created by Austin Cherry on 5/2/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PreferencesController;

@interface AppController : NSObject
{
    PreferencesController *preferenceController;
    NSPanel *aboutPanel;
}

-(IBAction)showPreferencePanel:(id)sender;
-(IBAction)showAboutPanel:(id)sender;

@end
