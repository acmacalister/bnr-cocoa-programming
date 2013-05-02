//
//  MyDocument.h
//  CarLot
//
//  Created by Austin Cherry on 4/30/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CarArrayController.h"

@interface MyDocument : NSPersistentDocument
{
    IBOutlet NSTableView *tableView;
    IBOutlet CarArrayController *carController;
}

-(IBAction)createCar:(id)sender;

@end
