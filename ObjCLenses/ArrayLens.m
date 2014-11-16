//
//  ArrayLens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "ArrayLens.h"

@interface ArrayLens ()
@property (nonatomic, assign) NSInteger index;
@end

@implementation ArrayLens

+ (instancetype)lensToItemAtIndex:(NSInteger)index {
    ArrayLens* lens = [ArrayLens new];
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

- (id)map:(id(^)(id))func over:(NSArray*)subject {
    NSInteger idx = (self.index + subject.count) % subject.count;
    id oldValue = [subject objectAtIndex:idx];
    
    NSMutableArray* mutableCopy = [NSMutableArray arrayWithArray:[subject subarrayWithRange:NSMakeRange(0, idx)]];
    [mutableCopy addObject:func(oldValue)];
    if (idx < subject.count - 1) {
        [mutableCopy addObjectsFromArray:[subject subarrayWithRange:NSMakeRange(idx + 1, subject.count - idx - 1)]];
    }
    return [mutableCopy copy];
}

@end
