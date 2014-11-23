//
//  Lens.h
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    NSUInteger _structSize;
    const char* _structType;
    NSUInteger _fieldOffset;
    const char* _fieldType;
} StructKeyPath;

#define SKP(__struct__, __keyPath__) \
    ({ StructKeyPath skp = { \
        ._structSize = ({NSUInteger size = 0; NSGetSizeAndAlignment(@encode(__struct__), &size, NULL); size;}), \
        ._structType = @encode(__struct__), \
        ._fieldOffset = ({__struct__ s; void* sp = &s; void* kp = &(s.__keyPath__); kp-sp; }), \
        ._fieldType = ({__struct__ s; @encode(typeof(s.__keyPath__)); }) \
       }; skp; })


@interface Lens : NSObject

+ (Lens*)lensToKeyPath:(NSString*)keyPath;

+ (Lens*)lensToItemAtIndex:(NSInteger)index;
+ (Lens*)lensToFirstItem;
+ (Lens*)lensToLastItem;

+ (Lens*)lensToKey:(id<NSCopying>)key;

+ (Lens*)lensToObject:(id)object;

+ (Lens*)lensToStructKeyPath:(StructKeyPath)structKeyPath;

- (Lens*)lensByAppendingLens:(Lens*)lens;

- (id)view:(id)subject;
- (id)map:(id(^)(id))func over:(id)subject;
- (id)set:(id)value over:(id)subject;

@end

