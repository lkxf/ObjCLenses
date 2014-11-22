//
//  KVCLens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "KVCLens.h"

@implementation KVCLens {
    NSString* _keyPath;
}

+ (KVCLens*)lensToKeyPath:(NSString*)keyPath {
    NSAssert([keyPath length] > 0, nil);
    return [[self alloc] initWithKeyPath:keyPath];
}

- (instancetype)initWithKeyPath:(NSString*)keyPath {
    NSAssert([keyPath length] > 0, nil);
    self = [super init];
    if (self) {
        _keyPath = [keyPath copy];
    }
    return self;
}

- (id)view:(id)subject {
    return [subject valueForKeyPath:_keyPath];
}

- (id)set:(id)value over:(id)subject {
    NSAssert([subject conformsToProtocol:@protocol(NSCopying)],
             @"keypath lens subjects must conform to NSCopying when mapped over");
    
    id copiedSubject = [subject copy];
    NSAssert(copiedSubject != subject, @"copy must create an independent object");
    
    [copiedSubject setValue:value forKeyPath:_keyPath];
    return copiedSubject;
}

@end
