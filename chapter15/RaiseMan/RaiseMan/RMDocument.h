//
//  RMDocument.h
//  RaiseMan
//
//  Created by Austin Cherry on 4/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Person;

@interface RMDocument : NSDocument
{
    NSMutableArray *employees;
    IBOutlet NSTableView *tableView;
    IBOutlet NSArrayController *employeeController;
}

-(IBAction)createEmployee:(id)sender;
-(IBAction)removeEmployee:(id)sender;
-(void)setEmployees:(NSMutableArray *)a;
-(void)insertObject:(Person *)p inEmployeesAtIndex:(NSUInteger)index;
-(void)removeObjectFromEmployeesAtIndex:(NSUInteger)index;

@end
