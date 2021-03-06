//
//  MyDocument.m
//  CarLot
//
//  Created by Austin Cherry on 4/30/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

-(IBAction)createCar:(id)sender
{
    NSWindow *w = [tableView window];
    BOOL editingEnded = [w makeFirstResponder:w];
    if(!editingEnded)
        return;
    NSUndoManager *undo = [self undoManager];
    if([undo groupingLevel] > 0)
    {
        [undo endUndoGrouping];
        [undo beginUndoGrouping];
    }
    
    id obj = [carController newObject];
    [carController addObject:obj];
    [carController rearrangeObjects];
    NSArray *a = [carController arrangedObjects];
    
    NSUInteger row = [a indexOfObjectIdenticalTo:obj];
    
    [tableView editColumn:0 row:row withEvent:nil select:YES];
}

@end
