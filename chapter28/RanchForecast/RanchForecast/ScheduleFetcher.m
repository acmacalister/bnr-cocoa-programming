//
//  ScheduleFetcher.m
//  RanchForecast
//
//  Created by Austin Cherry on 6/25/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "ScheduleFetcher.h"
#import "ScheduledClass.h"

@implementation ScheduleFetcher

#pragma mark init/drawing

-(id)init
{
    self = [super init];
    if(self)
    {
        classes = [[NSMutableArray alloc] init];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzzz"];
    }
    return self;
}

-(void)fetchClassesWithBlock:(ScheduleFetcherResultBlock)theBlock
{
    resultBlock = [theBlock copy];
    
    NSURL *xmlURL = [NSURL URLWithString:@"http://bignerdranch.com/xml/schedule"];
    NSURLRequest *req = [NSURLRequest requestWithURL:xmlURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    
    connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if(connection)
        responseData = [[NSMutableData alloc] init];
}

#pragma mark -
#pragma mark NSXMLParserDelegate Methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"class"])
        currentFields = [[NSMutableDictionary alloc] init];
    else if([elementName isEqualToString:@"offering"])
        [currentFields setObject:attributeDict[@"href"] forKey:@"href"];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"class"])
    {
        ScheduledClass *currentClass = [[ScheduledClass alloc] init];
        currentClass.name = currentFields[@"offering"];
        currentClass.location = currentFields[@"location"];
        currentClass.href = currentFields[@"href"];
        
        NSDate *beginDate = [dateFormatter dateFromString:currentFields[@"begin"]];
        currentClass.begin = beginDate;
        
        [classes addObject:currentClass];
        currentClass = nil;
        currentFields = nil;
    }
    else if(currentFields && currentString)
    {
        NSString *trimmed = [currentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        currentFields[elementName] = trimmed;
    }
    currentString = nil;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!currentString)
        currentString = [[NSMutableString alloc] init];
    [currentString appendString:string];
}

-(void)cleanup
{
    responseData = nil;
    connection = nil;
    resultBlock = nil;
}

#pragma mark -
#pragma mark NSURLConnection delegate

-(void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    [classes removeAllObjects];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseData];
    parser.delegate = self;
    
    BOOL success = [parser parse];
    if(!success)
        resultBlock(nil,[parser parserError]);
    else
    {
        NSArray *output = [classes copy];
        resultBlock(output,nil);
    }
    [self cleanup];
}

@end
