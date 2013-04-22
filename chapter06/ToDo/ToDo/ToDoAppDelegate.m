//
//  ToDoAppDelegate.m
//  ToDo
//
//  Created by Austin Cherry on 4/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "ToDoAppDelegate.h"

@interface ToDoAppDelegate()

@property(nonatomic,strong)NSMutableArray *tableItems;

@end

@implementation ToDoAppDelegate

@synthesize window = _window, addTextField = _addTextField, addButton = _addButton, tableView = _tableView;

-(id)init
{
    if(self = [super init])
    {
        self.tableItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (IBAction)addItem:(id)sender
{
    [self.tableItems addObject:_addTextField.stringValue];
    _addTextField.stringValue = @"";
    [_tableView reloadData];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return (NSInteger)[self.tableItems count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [self.tableItems objectAtIndex:row];
}

-(void)tableView:(NSTableView*)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    [self.tableItems replaceObjectAtIndex:[_tableView selectedRow] withObject:object];
}
@end
