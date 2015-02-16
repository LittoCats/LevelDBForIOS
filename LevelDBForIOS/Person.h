//
//  Person.h
//  LevelDBForIOS
//
//  Created by 程巍巍 on 2/16/15.
//  Copyright (c) 2015 Littocats. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
