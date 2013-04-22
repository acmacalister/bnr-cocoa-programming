//
//  KvcFunAppDelegate.h
//  kvcFun
//
//  Created by Austin Cherry on 4/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KvcFunAppDelegate : NSObject <NSApplicationDelegate>
{
    int fido;
}

@property (assign) IBOutlet NSWindow *window;
@property (readwrite, assign)int fido;

-(IBAction)incrementFido:(id)sender;

@end
