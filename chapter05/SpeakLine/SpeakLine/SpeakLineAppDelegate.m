//
//  SpeakLineAppDelegate.m
//  SpeakLine
//
//  Created by Austin Cherry on 4/13/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "SpeakLineAppDelegate.h"

@implementation SpeakLineAppDelegate

@synthesize window = _window, textField = _textField;

-(id)init
{
    self = [super init];
    if(self)
    {
        _speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
    }
    return self;
}

- (IBAction)sayIt:(id)sender
{
    NSString *string = _textField.stringValue;
    if([string length] == 0)
        return;
    [_speechSynth startSpeakingString:_textField.stringValue];
}

- (IBAction)stopIt:(id)sender
{
    [_speechSynth stopSpeaking];
}
@end
