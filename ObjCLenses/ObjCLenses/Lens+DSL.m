//
//  Lens+DSL.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.23..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "Lens+DSL.h"


Lens* Focus() {
    return [Lens new];
}


@implementation Lens (DSL_Composite)

- (Lens*(^)(Lens*))thru {
    __weak Lens* weakSelf = self;
    return ^Lens*(Lens* lens) {
        __strong Lens* self = weakSelf;
        return [self lensByAppendingLens:lens];
    };
}

@end


@implementation Lens (DSL_Array)

- (Lens*(^)())onFirst {
    __weak Lens* weakSelf = self;
    return ^Lens*() {
        __strong Lens* self = weakSelf;
        return [self lensByAppendingLens:[Lens lensToFirstItem]];
    };
}

- (Lens*(^)())onLast {
    __weak Lens* weakSelf = self;
    return ^Lens*() {
        __strong Lens* self = weakSelf;
        return [self lensByAppendingLens:[Lens lensToLastItem]];
    };
}

- (Lens*(^)(NSInteger))onIndex {
    __weak Lens* weakSelf = self;
    return ^Lens*(NSInteger idx) {
        __strong Lens* self = weakSelf;
        return [self lensByAppendingLens:[Lens lensToItemAtIndex:idx]];
    };
}

@end


@implementation Lens (DSL_Dictionary)

- (Lens*(^)(id<NSCopying>))onKey {
    __weak Lens* weakSelf = self;
    return ^Lens*(id<NSCopying> key) {
        __strong Lens* self = weakSelf;
        return [self lensByAppendingLens:[Lens lensToKey:key]];
    };
}

@end


@implementation Lens (DSL_KVC)

- (Lens*(^)(NSString*))onKeyPath {
    __weak Lens* weakSelf = self;
    return ^Lens*(NSString* keyPath) {
        __strong Lens* self = weakSelf;
        return [self lensByAppendingLens:[Lens lensToKeyPath:keyPath]];
    };
}

@end


@implementation Lens (DSL_Struct)

- (Lens*(^)(StructKeyPath))onStructKeyPath {
    __weak Lens* weakSelf = self;
    return ^Lens*(StructKeyPath skp) {
        __strong Lens* self = weakSelf;
        return [self lensByAppendingLens:[Lens lensToStructKeyPath:skp]];
    };
}

@end

