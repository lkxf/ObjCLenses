//
//  DictionaryLens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.22..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "DictionaryLens.h"

@interface DictionaryLens ()
@property (nonatomic, copy) id<NSCopying> key;
@end

@implementation DictionaryLens

+ (instancetype)lensWithKey:(id<NSCopying>)key {
    NSAssert(key, @"key must not be nil");
    DictionaryLens* lens = [DictionaryLens new];
    lens.key = key;
    return lens;
}

- (id)view:(NSDictionary*)subject {
    return subject[self.key];
}

- (NSDictionary*)set:(id)value over:(NSDictionary*)subject {
    NSMutableDictionary* newSubject = [subject mutableCopy];
    if (value) {
        newSubject[self.key] = value;
    } else {
        [newSubject removeObjectForKey:self.key];
    }
    return [newSubject copy];
}

@end
