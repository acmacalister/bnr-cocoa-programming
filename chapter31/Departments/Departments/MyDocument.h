//
//  MyDocument.h
//  Departments
//
//  Created by Austin Cherry on 6/26/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ManagingViewController;

@interface MyDocument : NSPersistentDocument
{
    IBOutlet NSBox *box;
    IBOutlet NSPopUpButton *popUp;
    NSMutableArray *viewControllers;
}

-(void)displayViewController:(ManagingViewController *)vc;
-(IBAction)changeViewController:(id)sender;

@end
