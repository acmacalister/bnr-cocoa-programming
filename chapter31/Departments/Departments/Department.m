//
//  Department.m
//  Departments
//
//  Created by Austin Cherry on 6/26/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "Department.h"
#import "Employee.h"


@implementation Department

@dynamic deptName;
@dynamic employees;
@dynamic manager;

-(void)addEmployeesObject:(Employee *)object
{
    NSSet *s = [NSSet setWithObject:object];
    [self willChangeValueForKey:@"employees" withSetMutation:NSKeyValueUnionSetMutation usingObjects:s];
    [[self primitiveValueForKey:@"employees"] addObject:object];
    [self didChangeValueForKey:@"employees" withSetMutation:NSKeyValueUnionSetMutation usingObjects:s];
}

-(void)removeEmployeesObject:(Employee *)object
{
    Employee *manager = [self manager];
    if(manager == object)
        self.manager = nil;
    
    NSSet *s = [NSSet setWithObject:object];
    [self willChangeValueForKey:@"employees" withSetMutation:NSKeyValueMinusSetMutation usingObjects:s];
    [[self primitiveValueForKey:@"employees"] removeObject:object];
    [self didChangeValueForKey:@"employees" withSetMutation:NSKeyValueMinusSetMutation usingObjects:s];
}

@end
