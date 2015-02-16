//
//  Person.m
//  LevelDBForIOS
//
//  Created by 程巍巍 on 2/16/15.
//  Copyright (c) 2015 Littocats. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.age = [aDecoder decodeIntegerForKey:@"age"];
    
    return self;
}

@end
