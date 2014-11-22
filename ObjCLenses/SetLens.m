//
//  SetLens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.22..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "SetLens.h"


@interface SetLens ()
@property (nonatomic, weak) id object;
@end

@implementation SetLens

+ (instancetype)lensToObject:(id)object {
    NSAssert(object, @"object must not be nil");
    SetLens* lens = [SetLens new];
    lens.object = object;
    return lens;
}

- (id)view:(NSSet*)subject {
    return @([subject containsObject:self.object]);
}

- (NSSet*)set:(NSNumber*)value over:(NSSet*)subject {
    if (!subject) {
        return nil;
    }
    
    NSAssert([value isKindOfClass:[NSNumber class]], @"set lens setters take a boolean");
    NSMutableSet* newSubject = [subject mutableCopy];
    
    if ([value boolValue] && ![subject containsObject:self.object]) {
        [newSubject addObject:self.object];
    } else if (![value boolValue] && [subject containsObject:self.object]) {
        [newSubject removeObject:self.object];
    }
    
    return [newSubject copy];
}

@end
