//
//  Lens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "Lens.h"

#import "ArrayLens.h"
#import "CompositeLens.h"
#import "KVCLens.h"
#import "StructLens.h"

@implementation Lens

#pragma mark - Factory methods

+ (Lens*)lensToKeyPath:(NSString*)keyPath {
    return [KVCLens lensToKeyPath:keyPath];
}

+ (Lens*)lensToItemAtIndex:(NSInteger)index {
    return [ArrayLens lensToItemAtIndex:index];
}

+ (Lens*)lensToFirstItem {
    return [ArrayLens lensToFirstItem];
}

+ (Lens*)lensToLastItem {
    return [ArrayLens lensToLastItem];
}

+ (Lens*)lensToStructKeyPath:(StructKeyPath)structKeyPath {
    return [StructLens lensToStructKeyPath:structKeyPath];
}

- (Lens*)lensByAppendingLens:(Lens*)lens {
    __weak Lens* weakSelf = self;
    
    CompositeLens* compositeLens = [[CompositeLens alloc] initWithViewBlock:^id(id subject) {
        __strong Lens* self = weakSelf;
        return [lens view:[self view:subject]];
    } overBlock:^id(Mapping mapping, id subject) {
        __strong Lens* self = weakSelf;
        id innerSubject = [self view:subject];
        id changedInnerSubject = [lens map:mapping over:innerSubject];
        
        return [self map:^id(id x) { return changedInnerSubject; }
                    over:subject];
    }];
    
    return compositeLens;
}

- (id)view:(id)subject {
    return subject;
}

- (id)map:(Mapping)func over:(id)subject {
    return func(subject);
}

- (id)set:(id)value over:(id)subject {
    return [self map:^id(id x) { return value; }
                over:subject];
}

@end
