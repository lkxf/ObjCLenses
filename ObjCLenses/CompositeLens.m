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
@property (nonatomic, copy) LensSetBlock setBlock;
@end

@implementation CompositeLens

- (instancetype)initWithViewBlock:(LensViewBlock)viewBlock
                         setBlock:(LensSetBlock)setBlock {
    self = [super init];
    if (self) {
        self.viewBlock = viewBlock;
        self.setBlock = setBlock;
    }
    return self;
}

- (id)view:(id)subject {
    return self.viewBlock(subject);
}

- (id)set:(id)value over:(id)subject {
    return self.setBlock(value, subject);
}

@end
