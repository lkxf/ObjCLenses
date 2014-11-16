//
//  PersonExample.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "PersonExample.h"
#import "Lens.h"

#define $(__struct__, ...)  ({__struct__ s = __VA_ARGS__; [NSValue valueWithBytes:&s objCType:@encode(__struct__)];})


typedef struct {
    int floor;
    int door;
} FlatSpec;

@interface Address : NSObject <NSCopying>
@property (nonatomic, copy, readonly) NSString* street;
@property (nonatomic, copy, readonly) NSString* city;
@property (nonatomic, assign, readonly) FlatSpec flat;
@end

@interface Address ()
@property (nonatomic, copy, readwrite) NSString* street;
@property (nonatomic, copy, readwrite) NSString* city;
@property (nonatomic, assign, readwrite) FlatSpec flat;
@end


@implementation Address
- (id)copyWithZone:(NSZone*)zone {
    Address* addressCopy = [[self class] new];
    addressCopy.street = self.street;
    addressCopy.city = self.city;
    addressCopy.flat = self.flat;
    return addressCopy;
}

@end


@interface Person : NSObject <NSCopying>
@property (nonatomic, copy, readonly) NSString* name;
@property (nonatomic, copy, readonly) Address* address;
@property (nonatomic, copy, readonly) NSArray* cars;
@end

@interface Person ()
@property (nonatomic, copy, readwrite) NSString* name;
@property (nonatomic, copy, readwrite) Address* address;
@property (nonatomic, copy, readwrite) NSArray* cars;
@end

@implementation Person
- (id)copyWithZone:(NSZone*)zone {
    Person* personCopy = [[self class] new];
    personCopy.name = self.name;
    personCopy.address = self.address;
    personCopy.cars = self.cars;
    return personCopy;
}

@end


// ------------------------------
static Person* p = nil;
static Address* a = nil;

void EXAMPLE_LensComposition() {
    Lens* addressLens = [Lens lensToKeyPath:@"address"];
    Lens* streetLens = [Lens lensToKeyPath:@"street"];
    Lens* addressStreetLens = [addressLens lensByAppendingLens:streetLens];
    NSLog(@"from: %@ %@", [addressStreetLens view:p], p);
    Address* a2 = [streetLens set:@"Folsom St" over:a];
    Person* p2 = [addressStreetLens set:@"Folsom St" over:p];
    NSLog(@"to a: %@ %@", a2.street, a2);
    NSLog(@"to p: %@ %@", [addressStreetLens view:p2], p2);
}

void EXAMPLE_FocusingOnArrays() {
    Lens* carLens = [Lens lensToKeyPath:@"cars"];
    Lens* lastLens = [Lens lensToFirstItem];
    Lens* lastCarLens = [carLens lensByAppendingLens:lastLens];
    
    NSLog(@"from: %@ %@", [lastCarLens view:p], p);
    Person* p3 = [lastCarLens set:@"porsche" over:p];
    NSLog(@"to: %@ %@", [lastCarLens view:p3], p3);
}

void EXAMPLE_CrossObjectKeyPaths() {
    Lens* streetLens = [Lens lensToKeyPath:@"address.street"];
    NSLog(@"from: %@ %@", [streetLens view:p], p);
    Person* p4 = [streetLens map:^id(id x) {
        return [x stringByAppendingString:@" (w/o number)"];
    } over:p];
    NSLog(@"to: %@ %@", [streetLens view:p4], p4);
}

void EXAMPLE_StructKeyPaths() {
    Lens* flatLens = [Lens lensToKeyPath:@"address.flat"];
    Lens* doorLens = [Lens lensToStructKeyPath:SKP(FlatSpec, door)];
    Lens* flatDoorLens = [flatLens lensByAppendingLens:doorLens];
    
    NSLog(@"from: %@ %@", [flatDoorLens view:p], p);
    Person* p5 = [flatDoorLens map:^id(NSNumber* door) {
        return @([door intValue] + 2);
    } over:p];
    NSLog(@"to: %@ %@", [flatDoorLens view:p5], p5);
}

void PersonExample() {
    a = [Address new];
    [a setValue:@"SF" forKey:@"city"];
    [a setValue:@"Market St" forKey:@"street"];
    [a setValue:$(FlatSpec, {5, 4}) forKey:@"flat"];
    
    p = [Person new];
    [p setValue:@"John Muir" forKey:@"name"];
    [p setValue:a forKey:@"address"];
    [p setValue:@[@"toyota", @"wartburg", @"nissan"] forKey:@"cars"];
    
    EXAMPLE_LensComposition();
    EXAMPLE_FocusingOnArrays();
    EXAMPLE_CrossObjectKeyPaths();
    EXAMPLE_StructKeyPaths();
}


