//
//  RMDocument.h
//  RM
//
//  Created by Austin Cherry on 4/23/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RMDocument : NSDocument<NSTableViewDataSource>
{
    NSMutableArray *employees;
    IBOutlet NSTableView *tableView;
}

- (IBAction)createEmployee:(id)sender;
- (IBAction)deleteSelectedEmployee:(id)sender;
@end
