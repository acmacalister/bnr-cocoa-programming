//
//  DrawingFunAppDelegate.h
//  DrawingFun
//
//  Created by Austin Cherry on 5/2/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class StretchView;

@interface DrawingFunAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet StretchView *stretchView;
}

-(IBAction)showOpenPanel:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
