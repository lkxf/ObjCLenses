//
//  CompositeLens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "CompositeLens.h"

@interface CompositeLens ()
@property (nonatomic, strong) Lens* foregroundLens;
@property (nonatomic, strong) Lens* backgroundLens;
@end

@implementation CompositeLens

+ (instancetype)lensWithForegroundLens:(Lens*)fgLens
                        backgroundLens:(Lens*)bgLens {
    CompositeLens* lens = [CompositeLens new];
    lens.foregroundLens = fgLens;
    lens.backgroundLens = bgLens;
    return lens;
}

- (id)view:(id)subject {
    return [self.backgroundLens view:[self.foregroundLens view:subject]];
}

- (id)set:(id)value over:(id)subject {
    id fgSubject = [self.backgroundLens set:value over:[self.foregroundLens view:subject]];
    return [self.foregroundLens set:fgSubject over:subject];
}

@end
