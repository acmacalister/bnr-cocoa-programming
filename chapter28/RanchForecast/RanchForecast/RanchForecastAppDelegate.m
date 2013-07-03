//
//  RanchForecastAppDelegate.m
//  RanchForecast
//
//  Created by Austin Cherry on 6/25/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "RanchForecastAppDelegate.h"
#import "ScheduleFetcher.h"
#import "ScheduledClass.h"

@implementation RanchForecastAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    tableView.target = self;
    [tableView setDoubleAction:@selector(openClass:)];
    
    ScheduleFetcher *fetcher = [[ScheduleFetcher alloc] init];
    [fetcher fetchClassesWithBlock:^(NSArray *theClasses, NSError *error){
        if(theClasses)
        {
            classes = theClasses;
            [tableView reloadData];
        }
        else
        {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setAlertStyle:NSCriticalAlertStyle];
            [alert setMessageText:@"error loading schedule."];
            [alert setInformativeText:[error localizedDescription]];
            [alert addButtonWithTitle:@"OK"];
            [alert beginSheetModalForWindow:self.window modalDelegate:nil didEndSelector:nil contextInfo:nil];
        }
    }];
}

-(void)openClass:(id)sender
{
    ScheduledClass *c = [classes objectAtIndex:[tableView clickedRow]];
    
    NSURL *baseURL = [NSURL URLWithString:@"http://www.bignerdranch.com/"];
    NSURL *url = [NSURL URLWithString:[c href] relativeToURL:baseURL];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

#pragma mark -
#pragma mark tableview data source

-(NSInteger)numberOfRowsInTableView:(NSTableView *)theTableView
{
    return [classes count];
}

-(id)tableView:(NSTableView *)theTableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ScheduledClass *c = classes[row];
    return [c valueForKey:[tableColumn identifier]];
}

@end
