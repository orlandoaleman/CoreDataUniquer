//
//  TTCoreDataUniquer.m
//
//  Created by Orlando Aleman Ortiz
//  Copyright (c) 2012 orlandoaleman.com. All rights reserved.
//

#import "TTCoreDataUniquer.h"


@interface TTCoreDataUniquer() {
    NSMutableDictionary *_objectList;
}

@property (strong, nonatomic) NSString *entityName;
@property (strong, nonatomic) NSString *idProperty;
@property (strong, nonatomic) NSManagedObjectContext *context;
@end


@implementation TTCoreDataUniquer


- (id)initWithEntityName:(NSString*)newEntityName identifyingProperty:(NSString *)newIdProp andContext:(NSManagedObjectContext *)newContext
{
    self = [super init];
    if (self != nil) {
        self.entityName = newEntityName;
        self.idProperty = newIdProp;
        self.context = newContext;
    }
    return self;
}


- (NSManagedObject *)findObjectForID:(id)identifier
{
    if (!_objectList) {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:_entityName
                                                             inManagedObjectContext:_context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        NSError *error;
        NSArray *array = [_context executeFetchRequest:request error:&error];

        _objectList = [NSMutableDictionary dictionary];

        for (NSManagedObject *p in array) {
            NSString *itemId = [p valueForKey:_idProperty];
            _objectList[itemId] = p;
        }
    }
    return _objectList[identifier];
}


- (NSManagedObject *)createObjectForID:(id)identifier
{
    NSManagedObject *returnedObject = [NSEntityDescription insertNewObjectForEntityForName:_entityName
                                                                    inManagedObjectContext:_context];
    [returnedObject setValue:identifier forKey:_idProperty];
    _objectList[identifier] = returnedObject;

    return returnedObject;
}


@end
