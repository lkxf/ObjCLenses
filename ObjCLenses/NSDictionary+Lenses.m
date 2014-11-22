//
//  NSDictionary+Lenses.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.22..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "NSDictionary+Lenses.h"
#import "DictionaryLens.h"

@implementation NSDictionary (Lenses)

+ (Lens*)lensToKey:(id<NSCopying>)key {
    return [DictionaryLens lensToKey:key];
}

@end
