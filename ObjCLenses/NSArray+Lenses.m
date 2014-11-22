//
//  NSArray+Lenses.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.22..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "NSArray+Lenses.h"
#import "ArrayLens.h"

@implementation NSArray (Lenses)

+ (Lens*)lensToItemAtIndex:(NSInteger)index {
    return [ArrayLens lensToItemAtIndex:index];
}

+ (Lens*)lensToFirstItem {
    return [ArrayLens lensToFirstItem];
}

+ (Lens*)lensToLastItem {
    return [ArrayLens lensToLastItem];
}

@end
