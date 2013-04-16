//
//  SpeakLineAppDelegate.h
//  SpeakLine
//
//  Created by Austin Cherry on 4/13/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpeakLineAppDelegate : NSObject <NSApplicationDelegate,NSSpeechSynthesizerDelegate,NSTableViewDataSource,NSTableViewDelegate>
{
    NSSpeechSynthesizer *_speechSynth;
    NSArray *_voices;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSButton *stopButton;
@property (weak) IBOutlet NSButton *startButton;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)startIt:(id)sender;
- (IBAction)stopIt:(id)sender;
@end
