//
//  RMDocument.m
//  RaiseMan
//
//  Created by Austin Cherry on 4/22/13.
//  Copyright (c) 2013 Basement Krew. All rights reserved.
//

#import "RMDocument.h"
#import "Person.h"

@implementation RMDocument

static void *RMDocumentKVOContext;

- (id)init
{
    self = [super init];
    if (self)
    {
        employees = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setEmployees:(NSMutableArray *)a
{
    for(Person * person in employees)
        [self stopObservingPerson:person];
    
    employees = a;
    
    for(Person *person in employees)
        [self startObservingPerson:person];
}

-(void)insertObject:(Person *)p inEmployeesAtIndex:(NSUInteger)index
{
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] removeObjectFromEmployeesAtIndex:index];
    if(![undo isUndoing])
        [undo setActionName:@"Add Person"];
    [self startObservingPerson:p];
    [employees insertObject:p atIndex:index];
}

-(void)removeObjectFromEmployeesAtIndex:(NSUInteger)index
{
    Person *p = [employees objectAtIndex:index];
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] insertObject:p inEmployeesAtIndex:index];
    if(![undo isUndoing])
        [undo setActionName:@"Remove Person"];
    [self stopObservingPerson:p];
    [employees removeObjectAtIndex:index];
}

-(void)startObservingPerson:(Person *)person
{
    [person addObserver:self forKeyPath:@"personName" options:NSKeyValueObservingOptionOld context:&RMDocumentKVOContext];
    [person addObserver:self forKeyPath:@"expectedRaise" options:NSKeyValueObservingOptionOld context:&RMDocumentKVOContext];
}

-(void)stopObservingPerson:(Person *)person
{
    [person removeObserver:self forKeyPath:@"personName" context:&RMDocumentKVOContext];
    [person removeObserver:self forKeyPath:@"expectedRaise" context:&RMDocumentKVOContext];
}

-(void)changeKeyPath:(NSString*)keyPath ofObject:(id)obj toValue:(id)newValue
{
    [obj setValue:newValue forKeyPath:keyPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context != &RMDocumentKVOContext)
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    NSUndoManager *undo = [self undoManager];
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    if(oldValue == [NSNull null])
        oldValue = nil;
    [[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath ofObject:object toValue:oldValue];
    [undo setActionName:@"Edit"];
}

-(IBAction)createEmployee:(id)sender
{
    NSWindow *w = [tableView window];
    BOOL editingEnded = [w makeFirstResponder:w];
    if(!editingEnded)
        return;
    NSUndoManager *undo = [self undoManager];
    if([undo groupingLevel] > 0)
    {
        [undo endUndoGrouping];
        [undo beginUndoGrouping];
    }
    
    Person *p = [employeeController newObject];
    [employeeController addObject:p];
    [employeeController rearrangeObjects];
    NSArray *a = [employeeController arrangedObjects];
    
    NSUInteger row = [a indexOfObjectIdenticalTo:p];
    
    [tableView editColumn:0 row:row withEvent:nil select:YES];
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"RMDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

@end
