//
//  ScatteredAppDelegate.h
//  Scattered
//
//  Created by Austin Cherry on 7/2/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface ScatteredAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSView *view;
    CATextLayer *textLayer;
}

@property (assign) IBOutlet NSWindow *window;

@end
