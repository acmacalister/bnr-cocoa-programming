//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Austin Cherry on 5/7/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "BigLetterView.h"

@interface BigLetterView()
@property (strong,nonatomic)NSMutableDictionary *attributes;
@end

@implementation BigLetterView

@synthesize bgColor, string;

#pragma mark drawing/init code

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self prepareAttributes];
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
    [self drawStringCenteredIn:bounds];
    
    if(([[self window] firstResponder] == self) && [NSGraphicsContext currentContextDrawingToScreen])
    {
        [NSGraphicsContext saveGraphicsState];
        NSSetFocusRingStyle(NSFocusRingOnly);
        [NSBezierPath strokeRect:bounds];
        [NSGraphicsContext restoreGraphicsState];
    }
}

-(void)drawStringCenteredIn:(NSRect)r
{
    NSSize strSize = [string sizeWithAttributes:self.attributes];
    NSPoint strOrigin;
    strOrigin.x = r.origin.x + (r.size.width - strSize.width)/2;
    strOrigin.y = r.origin.y + (r.size.height - strSize.height)/2;
    [string drawAtPoint:strOrigin withAttributes:self.attributes];
}

#pragma mark Overridden properties

-(void)setString:(NSString *)s
{
    string = s;
    [self setNeedsDisplay:YES];
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

#pragma mark Other stuff

-(void)prepareAttributes
{
    self.attributes = [NSMutableDictionary dictionary];
    [self.attributes setObject:[NSFont userFontOfSize:75] forKey:NSFontAttributeName];
    [self.attributes setObject:[NSColor redColor] forKey:NSForegroundColorAttributeName];
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:NSMakeSize(2, 2)];
    [shadow setShadowColor:[NSColor blackColor]];
    [shadow setShadowBlurRadius:-1.0];
    [self.attributes setObject:shadow forKey:NSShadowAttributeName];
}

-(IBAction)savePDF:(id)sender
{
    __block NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setAllowedFileTypes:@[@"pdf"]];
    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
        if(result == NSOKButton)
        {
            NSData *data = [self dataWithPDFInsideRect:self.bounds];
            NSError *e;
            BOOL successful = [data writeToURL:[panel URL] options:0 error:&e];
            
            if(!successful)
            {
                NSAlert *a = [NSAlert alertWithError:e];
                [a runModal];
            }
        }
        panel = nil; // avoid strong ref cycle
    }];
}

@end
