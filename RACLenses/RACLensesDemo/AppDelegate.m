//
//  AppDelegate.m
//  RACLensesDemo
//
//  Created by Tamás Lustyik on 2015.03.03..
//  Copyright (c) 2015 Tamas Lustyik. All rights reserved.
//

#import "AppDelegate.h"
#import <ObjCLenses/ObjCLenses.h>
#import "RACStream+Lenses.h"

@interface RACSignal (PZExtensions)

+ (instancetype)returnAll:(NSArray*)objects;

@end

@implementation RACSignal (PZExtensions)

+ (instancetype)returnAll:(NSArray*)objects {
    return [objects.rac_sequence
        foldRightWithStart:[RACSignal empty]
        reduce:^RACSignal*(id next, RACSequence* rest) {
            return [rest.head startWith:next];
        }];
}

@end


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    RACSignal* signal = [RACSignal returnAll:@[@{@"x": @1}, @{@"x": @5}, @{@"x": @2}, @{@"x": @4}, @{@"x": @3}]];
    Lens* xlens = Focus().onKey(@"x");

    [[signal
        focus:xlens flattenMap:^RACSignal*(NSNumber* value) {
            int n = value.intValue;
            return (n<3)? [RACSignal return:@(2*n)]:
                        (n>3)? [RACSignal returnAll:@[@(n),@0,@(n),@0]]:
                            [RACSignal error:[NSError errorWithDomain:@"e" code:-1 userInfo:nil]];
        }]
        subscribeNext:^(id x) {
            NSLog(@"next %@", x);
        } error:^(NSError *error) {
            NSLog(@"error %@", error);
        }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
