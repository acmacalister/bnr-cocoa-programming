//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Austin Cherry on 5/7/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "BigLetterView.h"
#import "NSString+FirstLetter.h"

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
        [self registerForDraggedTypes:@[NSPasteboardTypeString]];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect bounds = [self bounds];
    if(highlighted)
    {
        NSGradient *gr;
        gr = [[NSGradient alloc] initWithStartingColor:[NSColor whiteColor] endingColor:bgColor];
        [gr drawInRect:bounds relativeCenterPosition:NSZeroPoint];
    }
    else
    {
        [bgColor set];
        [NSBezierPath fillRect:bounds];
    }
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

-(void)mouseDown:(NSEvent *)theEvent
{
    mouseDownEvent = theEvent;
}

-(void)mouseDragged:(NSEvent *)theEvent
{
    NSPoint down = [mouseDownEvent locationInWindow];
    NSPoint drag = [theEvent locationInWindow];
    float distance = hypot(down.x - drag.x, down.y - drag.y);
    if(distance < 3)
        return;
    
    if([string length] == 0)
        return;
    
    NSSize s = [string sizeWithAttributes:self.attributes];
    
    NSImage *anImage = [[NSImage alloc] initWithSize:s];
    
    NSRect imageBounds;
    imageBounds.origin = NSZeroPoint;
    imageBounds.size = s;
    [anImage lockFocus];
    [self drawStringCenteredIn:imageBounds];
    [anImage unlockFocus];
    
    NSPoint p = [self convertPoint:down fromView:nil];
    
    p.x = p.x - s.width/2;
    p.y = p.y - s.height/2;
    
    NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSDragPboard];
    [self writeToPasteboard:pb];
    
    [self dragImage:anImage at:p offset:NSZeroSize event:mouseDownEvent pasteboard:pb source:self slideBack:YES];
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

#pragma mark Pasteboard

-(void)writeToPasteboard:(NSPasteboard *)pb
{
    [pb clearContents];
    [pb writeObjects:@[string]];
}

-(BOOL)readFromPasteboard:(NSPasteboard *)pb
{
    NSArray *objects = [pb readObjectsForClasses:@[[NSString class]] options:nil];
    
    if(objects.count > 0)
    {
        NSString *value = objects[0];
        [self setString:[value bnr_firstLetter]];
        return YES;
    }
    return NO;
}

-(IBAction)cut:(id)sender
{
    [self copy:sender];
    [self setString:@""];
}

-(IBAction)copy:(id)sender
{
    NSPasteboard *pb = [NSPasteboard generalPasteboard];
    [self writeToPasteboard:pb];
}

-(IBAction)paste:(id)sender
{
    NSPasteboard *pb = [NSPasteboard generalPasteboard];
    if(![self readFromPasteboard:pb])
        NSBeep();
}

#pragma mark Drag and Drop

-(NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)flag
{
    return NSDragOperationCopy | NSDragOperationDelete;
}

-(void)draggedImage:(NSImage *)image endedAt:(NSPoint)screenPoint operation:(NSDragOperation)operation
{
    if(operation == NSDragOperationDelete)
        [self setString:@""];
}

#pragma mark Dragging Destination

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    if([sender draggingSource] == self)
        return NSDragOperationNone;
    highlighted = YES;
    [self setNeedsDisplay:YES];
    return NSDragOperationCopy;
}

-(void)draggingExited:(id<NSDraggingInfo>)sender
{
    highlighted = NO;
    [self setNeedsDisplay:YES];
}

-(BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender
{
    return YES;
}

-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    NSPasteboard *pb = [sender draggingPasteboard];
    if(![self readFromPasteboard:pb])
        return NO;
    return YES;
}

-(void)concludeDragOperation:(id<NSDraggingInfo>)sender
{
    highlighted = NO;
    [self setNeedsDisplay:YES];
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
