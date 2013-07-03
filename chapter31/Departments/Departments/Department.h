//
//  Department.h
//  Departments
//
//  Created by Austin Cherry on 6/26/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * deptName;
@property (nonatomic, retain) NSManagedObject *employees;
@property (nonatomic, retain) NSManagedObject *manager;

@end
