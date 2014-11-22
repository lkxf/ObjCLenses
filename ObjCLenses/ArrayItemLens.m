//
//  ArrayItemLens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "ArrayItemLens.h"

@interface ArrayItemLens ()
@property (nonatomic, assign) NSInteger index;
@end

@implementation ArrayItemLens

+ (instancetype)lensToItemAtIndex:(NSInteger)index {
    ArrayItemLens* lens = [ArrayItemLens new];
    lens.index = index;
    return lens;
}

+ (instancetype)lensToFirstItem {
    return [self lensToItemAtIndex:0];
}

+ (instancetype)lensToLastItem {
    return [self lensToItemAtIndex:-1];
}

- (id)view:(NSArray*)subject {
    return [subject objectAtIndex:((self.index + subject.count) % subject.count)];
}

- (id)set:(id)value over:(NSArray*)subject {
    NSAssert(value, @"cannot set nil as array element");
    NSInteger idx = (self.index + subject.count) % subject.count;
    
    NSMutableArray* mutableCopy = [NSMutableArray arrayWithArray:[subject subarrayWithRange:NSMakeRange(0, idx)]];
    [mutableCopy addObject:value];
    if (idx < subject.count - 1) {
        [mutableCopy addObjectsFromArray:[subject subarrayWithRange:NSMakeRange(idx + 1, subject.count - idx - 1)]];
    }
    return [mutableCopy copy];
}

@end