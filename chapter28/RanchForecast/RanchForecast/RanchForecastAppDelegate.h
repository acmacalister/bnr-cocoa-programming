//
//  RanchForecastAppDelegate.h
//  RanchForecast
//
//  Created by Austin Cherry on 6/25/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RanchForecastAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSTableView *tableView;
    NSArray *classes;
}

@property (assign) IBOutlet NSWindow *window;

@end
