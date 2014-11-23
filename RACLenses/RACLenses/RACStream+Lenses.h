//
//  RACStream+Lenses.h
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.23..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
@class Lens;

@interface RACStream (Lenses)
- (instancetype)focus:(Lens*)lens;
- (instancetype)focus:(Lens*)lens map:(id(^)(id))block;
- (instancetype)focus:(Lens*)lens mapReplace:(id)value;
- (instancetype)focus:(Lens*)lens filter:(BOOL(^)(id))block;
- (instancetype)focus:(Lens*)lens ignore:(id)value;
@end
