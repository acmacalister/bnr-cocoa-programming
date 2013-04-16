//
//  RandomController.h
//  Random
//
//  Created by Austin Cherry on 4/12/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomController : NSObject {
    IBOutlet NSTextField *textField;
}

-(IBAction)seed:(id)sender;
-(IBAction)generate:(id)sender;

@end
