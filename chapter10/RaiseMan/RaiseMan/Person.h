//
//  Person.h
//  RaiseMan
//
//  Created by Austin Cherry on 4/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
/*{
    NSString *personName;
    float expectedRaise;
} */

@property(copy) NSString *personName;
@property float expectedRaise;
@end
