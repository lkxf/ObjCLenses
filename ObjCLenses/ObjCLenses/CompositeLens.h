//
//  CompositeLens.h
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "Lens.h"

@interface CompositeLens : Lens
+ (instancetype)lensWithForegroundLens:(Lens*)fgLens
                        backgroundLens:(Lens*)bgLens;
@end
