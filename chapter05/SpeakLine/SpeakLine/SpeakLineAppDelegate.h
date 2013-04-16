//
//  SpeakLineAppDelegate.h
//  SpeakLine
//
//  Created by Austin Cherry on 4/13/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpeakLineAppDelegate : NSObject <NSApplicationDelegate>
{
    NSSpeechSynthesizer *_speechSynth;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;

- (IBAction)sayIt:(id)sender;
- (IBAction)stopIt:(id)sender;

@end
