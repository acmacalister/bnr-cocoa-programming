//
//  StretchView.m
//  DrawingFun
//
//  Created by Austin Cherry on 5/2/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "StretchView.h"

@implementation StretchView

@synthesize image,opacity;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        srandom((unsigned)time(NULL));
        
        path = [NSBezierPath bezierPath];
        [path setLineWidth:3.0];
        NSPoint p = [self randomPoint];
        [path moveToPoint:p];
        for(int i = 0; i < 15; i++)
        {
            p = [self randomPoint];
            [path lineToPoint:p];
        }
        [path closePath];
        opacity = 1.0;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect bounds = [self bounds];
    [[NSColor greenColor] set];
    [NSBezierPath fillRect:bounds];
    
    [[NSColor whiteColor] set];
    [path fill];
    if(image)
    {
        NSRect imageRect;
        imageRect.origin = NSZeroPoint;
        imageRect.size = [image size];
        NSRect drawingRect = [self currentRect];
        [image drawInRect:drawingRect fromRect:imageRect operation:NSCompositeSourceOver fraction:opacity];
    }
}

-(NSPoint)randomPoint
{
    NSPoint result;
    NSRect r = [self bounds];
    result.x = r.origin.x + random() % (int)r.size.width;
    result.y = r.origin.y + random() % (int)r.size.height;
    return result;
}

-(NSRect)currentRect
{
    float minX = MIN(downPoint.x,currentPoint.x);
    float maxX = MAX(downPoint.x,currentPoint.x);
    float minY = MIN(downPoint.y,currentPoint.y);
    float maxY = MAX(downPoint.y,currentPoint.y);
    return NSMakeRect(minX, minY, maxX-minX, maxY-minY);
}

#pragma mark Events

-(void)mouseDown:(NSEvent *)theEvent
{
    NSPoint p = [theEvent locationInWindow];
    downPoint = [self convertPoint:p fromView:nil];
    currentPoint = downPoint;
    [self setNeedsDisplay:YES];
}

-(void)mouseDragged:(NSEvent *)theEvent
{
    NSPoint p = [theEvent locationInWindow];
    currentPoint = [self convertPoint:p fromView:nil];
    [self autoscroll:theEvent];
    [self setNeedsDisplay:YES];
}

-(void)mouseUp:(NSEvent *)theEvent
{
    NSPoint p = [theEvent locationInWindow];
    currentPoint = [self convertPoint:p fromView:nil];
    [self setNeedsDisplay:YES];
}

#pragma mark Properties

-(void)setImage:(NSImage *)i
{
    image = i;
    NSSize imageSize = [i size];
    downPoint = NSZeroPoint;
    currentPoint.x = downPoint.x + imageSize.width;
    currentPoint.y = downPoint.y + imageSize.height;
    [self setNeedsDisplay:YES];
}

-(void)setOpacity:(float)o
{
    opacity = o;
    [self setNeedsDisplay:YES];
}

@end
