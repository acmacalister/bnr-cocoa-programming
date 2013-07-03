//
//  TutorController.h
//  TypingTutor
//
//  Created by Austin Cherry on 6/24/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BigLetterView;

@interface TutorController : NSObject
{
    IBOutlet BigLetterView *inLetterView;
    IBOutlet BigLetterView *outLetterView;
    
    NSArray *letters;
    int lastIndex;
    
    NSTimeInterval startTime;
    NSTimeInterval elapsedTime;
    NSTimeInterval timeLimit;
    NSTimer *timer;
}

-(IBAction)stopGo:(id)sender;
-(void)updateElapsedTime;
-(void)resetElapsedTime;
-(void)showAnotherLetter;

@end
