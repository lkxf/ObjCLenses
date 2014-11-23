//
//  DictionaryLens.h
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.22..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "Lens.h"

@interface DictionaryLens : Lens

+ (instancetype)lensToKey:(id<NSCopying>)key;

@end
