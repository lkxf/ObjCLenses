//
//  DSLExample.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.23..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "DSLExample.h"

void DSLExample() {
    NSArray* test = @[@1, @2, @3, @4,
                      @{
                          @"x": @"blah",
                          @"y": @"quux",
                          @"foo": @{
                                  @"baz": [NSValue valueWithRange:NSMakeRange(1234, 42)],
                                  @"bar": @"stuff"
                                  }
                          }
                      ];
    Lens* lastFooBar = Focus().onLast().onKey(@"foo").onKey(@"bar");
    NSLog(@"%@", [lastFooBar set:@"whoop" over:test]);
    
    Lens* rangeLocation = Focus().onLast().onKey(@"foo").onKey(@"baz").onStructKeyPath(SKP(NSRange, location));
    NSLog(@"%@", [rangeLocation map:^id(id x) {
        return @([x intValue] + 99);
    } over:test]);
    
}

