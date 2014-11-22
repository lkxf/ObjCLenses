//
//  StructLens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "StructLens.h"

static NSNumber* Numberify(NSValue* value) {
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    
    const char* valueType = [value objCType];
    if (strlen(valueType) > 1) {
        return nil;
    }

    const char numberTypes[] = "cCsSiIlLqQfd";
    char* numType = strchr(numberTypes, valueType[0]);
    if (!numType) {
        return nil;
    }

    NSUInteger size = 0;
    NSGetSizeAndAlignment(valueType, &size, NULL);
    void* buf = malloc(size);
    [value getValue:buf];
    
    SEL constructors[] = {
        @selector(numberWithChar:),
        @selector(numberWithUnsignedChar:),
        @selector(numberWithShort:),
        @selector(numberWithUnsignedShort:),
        @selector(numberWithInt:),
        @selector(numberWithUnsignedInt:),
        @selector(numberWithLong:),
        @selector(numberWithUnsignedLong:),
        @selector(numberWithLongLong:),
        @selector(numberWithUnsignedLongLong:),
        @selector(numberWithFloat:),
        @selector(numberWithDouble:)
    };
    
    char numSig[] = "@@:X";
    numSig[3] = valueType[0];
    
    NSInvocation* inv = [NSInvocation invocationWithMethodSignature:
                         [NSMethodSignature signatureWithObjCTypes:numSig]];
    [inv setTarget:(id)[NSNumber class]];
    [inv setSelector:constructors[numType - numberTypes]];
    [inv setArgument:buf atIndex:2];
    [inv invoke];
    
    CFTypeRef ref;
    [inv getReturnValue:&ref];
    if (ref) {
        CFRetain(ref);
    }
    NSNumber* retval = (__bridge_transfer NSNumber*)ref;
    
    free(buf);

    return retval;
}



@implementation StructLens {
    StructKeyPath _structKeyPath;
}

+ (instancetype)lensToStructKeyPath:(StructKeyPath)structKeyPath {
    return [[self alloc] initWithStructKeyPath:structKeyPath];
}

- (instancetype)initWithStructKeyPath:(StructKeyPath)structKeyPath {
    self = [super init];
    if (self) {
        _structKeyPath = structKeyPath;
    }
    return self;
}

- (NSValue*)view:(NSValue*)subject {
    NSAssert2(!strcmp([subject objCType], _structKeyPath._structType),
              @"expected focused field type to be '%s', got '%s'",
              _structKeyPath._structType,
              [subject objCType]);

    char buf[_structKeyPath._structSize];
    [subject getValue:buf];
    
    id value = [NSValue valueWithBytes:&buf[_structKeyPath._fieldOffset]
                              objCType:_structKeyPath._fieldType];
    
    NSNumber* numValue = Numberify(value);
    
    return numValue? numValue: value;
}

- (id)set:(id)value over:(id)subject {
    char newBuf[_structKeyPath._structSize];
    [subject getValue:newBuf];
    [value getValue:newBuf + _structKeyPath._fieldOffset];
    
    return [NSValue valueWithBytes:newBuf
                          objCType:_structKeyPath._structType];
}

@end

