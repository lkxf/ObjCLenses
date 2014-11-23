//
//  NSArray+Lenses.h
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.22..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Lens;

@interface NSArray (Lenses)
+ (Lens*)lensToItemAtIndex:(NSInteger)index;
+ (Lens*)lensToFirstItem;
+ (Lens*)lensToLastItem;
@end
