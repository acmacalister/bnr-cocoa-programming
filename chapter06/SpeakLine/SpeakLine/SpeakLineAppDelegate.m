//
//  SpeakLineAppDelegate.m
//  SpeakLine
//
//  Created by Austin Cherry on 4/13/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "SpeakLineAppDelegate.h"

@implementation SpeakLineAppDelegate

@synthesize window = _window, textField = _textField, startButton = _startButton, stopButton = _stopButton, tableView = _tableView;

-(id)init
{
    self = [super init];
    if(self)
    {
        _speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
        _speechSynth.delegate = self;
        _voices = [NSSpeechSynthesizer availableVoices];
    }
    return self;
}

-(void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [_stopButton setEnabled:NO];
}

-(void)awakeFromNib
{
    NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice];
    NSInteger defaultRow = [_voices indexOfObject:defaultVoice];
    NSIndexSet *indices = [NSIndexSet indexSetWithIndex:defaultRow];
    [_tableView selectRowIndexes:indices byExtendingSelection:NO];
    [_tableView scrollColumnToVisible:defaultRow];
}

- (IBAction)startIt:(id)sender
{
    NSString *string = _textField.stringValue;
    if([string length] == 0)
        return;
    [_speechSynth startSpeakingString:_textField.stringValue];
    [_stopButton setEnabled:YES];
    [_startButton setEnabled:NO];
    [_tableView setEnabled:NO];
}

- (IBAction)stopIt:(id)sender
{
    [_speechSynth stopSpeaking];
}

-(void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking
{
    [_startButton setEnabled:YES];
    [_stopButton setEnabled:NO];
    [_tableView setEnabled:YES];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return (NSInteger)[_voices count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *v = [_voices objectAtIndex:row];
    NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v];
    return [dict objectForKey:NSVoiceName];
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger row = [_tableView selectedRow];
    if(row == -1)
        return;
    NSString *selectedVoice = [_voices objectAtIndex:row];
    [_speechSynth setVoice:selectedVoice];
}
@end
