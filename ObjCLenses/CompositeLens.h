//
//  CompositeLens.h
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "Lens.h"

typedef id (^Mapping)(id value);

typedef id (^LensViewBlock)(id subject);
typedef id (^LensOverBlock)(Mapping mapping, id subject);


@interface CompositeLens : Lens
- (instancetype)initWithViewBlock:(LensViewBlock)viewBlock
                        overBlock:(LensOverBlock)overBlock;
@end
