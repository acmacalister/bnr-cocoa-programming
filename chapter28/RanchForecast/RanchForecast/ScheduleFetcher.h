//
//  ScheduleFetcher.h
//  RanchForecast
//
//  Created by Austin Cherry on 6/25/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ScheduleFetcherResultBlock)(NSArray *classes, NSError *error);

@interface ScheduleFetcher : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *classes;
    NSMutableString *currentString;
    NSMutableDictionary *currentFields;
    NSDateFormatter *dateFormatter;
    
    ScheduleFetcherResultBlock resultBlock;
    NSMutableData *responseData;
    NSURLConnection *connection;
}

-(void)fetchClassesWithBlock:(ScheduleFetcherResultBlock)theBlock;

@end
