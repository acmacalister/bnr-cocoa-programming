//
//  BigLetterView.h
//  TypingTutor
//
//  Created by Austin Cherry on 5/7/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BigLetterView : NSView

@property (strong,nonatomic)NSColor *bgColor;
@property (copy,nonatomic)NSString *string;

-(void)prepareAttributes;
-(IBAction)savePDF:(id)sender;

@end
