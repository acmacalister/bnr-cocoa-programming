//
//  RMDocument.h
//  RaiseMan
//
//  Created by Austin Cherry on 4/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RMDocument : NSDocument
{
    NSMutableArray *employees;
}

-(void)setEmployees:(NSMutableArray *)a;

@end
