//
//  Employee.m
//  Departments
//
//  Created by Austin Cherry on 6/26/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "Employee.h"
#import "Department.h"


@implementation Employee

@dynamic firstName;
@dynamic lastName;
@dynamic department;

-(NSString *)fullName
{
    if(!self.firstName)
        return self.lastName;
    if(!self.lastName)
        return self.firstName;
    
    return [NSString stringWithFormat:@"%@ %@",self.firstName, self.lastName];
}

+(NSSet *)keyPathsForValuesAffectingFullName
{
    return [NSSet setWithObjects:@"firstName",@"lastName", nil];
}

@end
