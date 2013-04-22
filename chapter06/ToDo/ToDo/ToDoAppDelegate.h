//
//  ToDoAppDelegate.h
//  ToDo
//
//  Created by Austin Cherry on 4/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ToDoAppDelegate : NSObject <NSApplicationDelegate,NSTableViewDataSource,NSTableViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *addTextField;
@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)addItem:(id)sender;
@end
