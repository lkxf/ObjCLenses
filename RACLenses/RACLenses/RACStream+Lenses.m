//
//  RACStream+Lenses.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.23..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "RACStream+Lenses.h"
#import <ObjCLenses/ObjCLenses.h>

@implementation RACStream (Lenses)

- (instancetype)focus:(Lens*)lens {
    return [self map:^id(id value) {
        return [lens view:value];
    }];
}

- (instancetype)focus:(Lens*)lens map:(id(^)(id))block {
    return [self map:^id(id value) {
        return [lens map:block over:value];
    }];
}

- (instancetype)focus:(Lens*)lens mapReplace:(id)object {
    return [self map:^id(id value) {
        return [lens set:value over:object];
    }];
}

- (instancetype)focus:(Lens*)lens filter:(BOOL(^)(id))block {
    return [self filter:^BOOL(id value) {
        return block([lens view:value]);
    }];
}

- (instancetype)focus:(Lens*)lens ignore:(id)value {
    return [self focus:lens filter:^BOOL(id x) {
        return x != value && ![x isEqual:value];
    }];
}

- (instancetype)focus:(Lens*)lens flattenMap:(RACStream*(^)(id))block {
    return [self flattenMap:^RACStream*(id value) {
        return [block([lens view:value]) map:^id(id x) {
            return [lens set:x over:value];
        }];
    }];
}

@end

