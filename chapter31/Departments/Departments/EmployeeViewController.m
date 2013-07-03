//
//  EmployeeViewController.m
//  Departments
//
//  Created by Austin Cherry on 6/26/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "EmployeeViewController.h"

@interface EmployeeViewController ()

@end

@implementation EmployeeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"EmployeeView" bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Employees";
    }
    
    return self;
}

-(void)keyDown:(NSEvent *)theEvent
{
    [self interpretKeyEvents:@[theEvent]];
}

-(void)deleteBackward:(id)sender
{
    [employeeController remove:nil];
}

@end
