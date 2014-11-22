//
//  Lens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "Lens.h"

#import "ArrayItemLens.h"
#import "CompositeLens.h"
#import "KVCLens.h"
#import "StructLens.h"

@implementation Lens

#pragma mark - Factory methods

+ (Lens*)lensToKeyPath:(NSString*)keyPath {
    return [KVCLens lensToKeyPath:keyPath];
}

+ (Lens*)lensToItemAtIndex:(NSInteger)index {
    return [ArrayItemLens lensToItemAtIndex:index];
}

+ (Lens*)lensToFirstItem {
    return [ArrayItemLens lensToFirstItem];
}

+ (Lens*)lensToLastItem {
    return [ArrayItemLens lensToLastItem];
}

+ (Lens*)lensToStructKeyPath:(StructKeyPath)structKeyPath {
    return [StructLens lensToStructKeyPath:structKeyPath];
}

- (Lens*)lensByAppendingLens:(Lens*)lens {
    __weak Lens* weakSelf = self;
    
    CompositeLens* compositeLens = [[CompositeLens alloc] initWithViewBlock:^id(id subject) {
        __strong Lens* self = weakSelf;
        return [lens view:[self view:subject]];
    } setBlock:^id(id value, id subject) {
        __strong Lens* self = weakSelf;
        id intermediateSubject = [lens set:value over:[self view:subject]];
        return [self set:intermediateSubject
                    over:subject];
    }];
    
    return compositeLens;
}

- (id)view:(id)subject {
    return subject;
}

- (id)map:(Mapping)func over:(id)subject {
    return [self set:func([self view:subject]) over:subject];
}

- (id)set:(id)value over:(id)subject {
    return subject;
}

@end
