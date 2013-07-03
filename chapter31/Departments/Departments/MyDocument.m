//
//  MyDocument.m
//  Departments
//
//  Created by Austin Cherry on 6/26/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "MyDocument.h"
#import "DepartmentViewController.h"
#import "EmployeeViewController.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self)
    {
        viewControllers = [[NSMutableArray alloc] init];
        
        ManagingViewController *vc = [[DepartmentViewController alloc] init];
        [vc setManagedObjectContext:[self managedObjectContext]];
        [viewControllers addObject:vc];
        
        vc = [[EmployeeViewController alloc] init];
        [vc setManagedObjectContext:[self managedObjectContext]];
        [viewControllers addObject:vc];
    }
    return self;
}

-(void)displayViewController:(ManagingViewController *)vc
{
    NSWindow *w = [box window];
    BOOL ended = [w makeFirstResponder:w];
    if(!ended)
    {
        NSBeep();
        return;
    }
    [box setContentView:[vc view]];
    [vc.view setNextResponder:vc];
    [vc setNextResponder:box];
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
    NSMenu *menu = [popUp menu];
    NSUInteger i, itemCount;
    itemCount = [viewControllers count];
    
    for(i = 0; i < itemCount; i++)
    {
        NSViewController *vc = viewControllers[i];
        NSMenuItem *mi = [[NSMenuItem alloc] initWithTitle:[vc title] action:@selector(changeViewController:) keyEquivalent:@""];
        mi.tag = i;
        [menu addItem:mi];
    }
    
    [self displayViewController:viewControllers[0]];
    [popUp selectItemAtIndex:0];
}

-(void)changeViewController:(id)sender
{
    NSUInteger i = [sender tag];
    ManagingViewController *vc = viewControllers[i];
    [self displayViewController:vc];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

@end
