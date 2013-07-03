//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Austin Cherry on 5/7/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "BigLetterView.h"

@implementation BigLetterView

@synthesize bgColor, string;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        bgColor = [NSColor yellowColor];
        string = @"";
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect bounds = [self bounds];
    [bgColor set];
    [NSBezierPath fillRect:bounds];
    
    if(([[self window] firstResponder] == self) && [NSGraphicsContext currentContextDrawingToScreen])
    {
        [NSGraphicsContext saveGraphicsState];
        NSSetFocusRingStyle(NSFocusRingOnly);
        [NSBezierPath strokeRect:bounds];
        [NSGraphicsContext restoreGraphicsState];
    }
}

#pragma mark Responders

-(BOOL)isOpaque
{
    return YES;
}

-(BOOL)acceptsFirstResponder
{
    return YES;
}

-(BOOL)resignFirstResponder
{
    [self setKeyboardFocusRingNeedsDisplayInRect:[self bounds]];
    return YES;
}

-(BOOL)becomeFirstResponder
{
    [self setNeedsDisplay:YES];
    return YES;
}

#pragma mark Keyboard Events

-(void)keyDown:(NSEvent *)theEvent
{
    [self interpretKeyEvents:@[theEvent]];
}

-(void)insertText:(id)insertString
{
    [self setString:insertString];
}

-(void)insertTab:(id)sender
{
    [[self window] selectKeyViewFollowingView:self];
}

-(void)insertBacktab:(id)sender
{
    [[self window] selectKeyViewPrecedingView:self];
}

-(void)deleteBackward:(id)sender
{
    [self setString:@" "];
}

@end
