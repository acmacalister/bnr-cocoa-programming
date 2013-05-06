//
//  DrawingFunAppDelegate.m
//  DrawingFun
//
//  Created by Austin Cherry on 5/2/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "DrawingFunAppDelegate.h"
#import "StretchView.h"

@implementation DrawingFunAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(IBAction)showOpenPanel:(id)sender
{
    __block NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setAllowedFileTypes:[NSImage imageFileTypes]];
    [panel beginSheetModalForWindow:[stretchView window] completionHandler:^ (NSInteger result){
      if(result == NSOKButton)
      {
          NSImage *image = [[NSImage alloc] initWithContentsOfURL:[panel URL]];
          [stretchView setImage:image];
      }
        panel = nil;
    }];
}
@end
