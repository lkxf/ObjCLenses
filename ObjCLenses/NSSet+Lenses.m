//
//  NSSet+Lenses.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.22..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "NSSet+Lenses.h"
#import "SetLens.h"

@implementation NSSet (Lenses)

+ (Lens*)lensToObject:(id)object {
    return [SetLens lensToObject:object];
}

@end
