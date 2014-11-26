//
//  Lens+DSL.h
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.23..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "Lens.h"

Lens* Focus();

@interface Lens (DSL_Composite)
@property (nonatomic, strong, readonly) Lens* (^thru)(Lens* lens);
@end

@interface Lens (DSL_Array)
@property (nonatomic, strong, readonly) Lens* (^onFirst)();
@property (nonatomic, strong, readonly) Lens* (^onLast)();
@property (nonatomic, strong, readonly) Lens* (^onIndex)(NSInteger index);
@end

@interface Lens (DSL_Dictionary)
@property (nonatomic, strong, readonly) Lens* (^onKey)(id<NSCopying> key);
@end

@interface Lens (DSL_KVC)
@property (nonatomic, strong, readonly) Lens* (^onKeyPath)(NSString* keyPath);
@end

@interface Lens (DSL_Struct)
@property (nonatomic, strong, readonly) Lens* (^onStructKeyPath)(StructKeyPath skp);
@end

