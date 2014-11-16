//
//  CompositeLens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "CompositeLens.h"

@interface CompositeLens ()
@property (nonatomic, copy) LensViewBlock viewBlock;
@property (nonatomic, copy) LensOverBlock overBlock;
@end

@implementation CompositeLens

- (instancetype)initWithViewBlock:(LensViewBlock)viewBlock
                        overBlock:(LensOverBlock)overBlock {
    self = [super init];
    if (self) {
        self.viewBlock = viewBlock;
        self.overBlock = overBlock;
    }
    return self;
}

- (id)view:(id)subject {
    return self.viewBlock(subject);
}

- (id)map:(id(^)(id))func over:(id)subject {
    return self.overBlock(func, subject);
}

@end
