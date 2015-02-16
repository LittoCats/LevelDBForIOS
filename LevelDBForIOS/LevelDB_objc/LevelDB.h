//
//  LevelDB.h
//  LevelDBForIOS
//
//  Created by 程巍巍 on 2/16/15.
//  Copyright (c) 2015 Littocats. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelDB : NSObject

@property (nonatomic, readonly) NSString        *name;
@property (nonatomic, readonly) NSDictionary    *options;

/**
 *  创建一个 LevelDB 实例
 *  @param name 数据库的路径，e.g. /temp/testdb
 *  @param options key 及 value 请查看 <levelDB/db.h>
 *  @return LevelDB instance . name 相同时，返回同一个 实例，因此对于同一个 name ，应使用相同的 options.
 */
+ (instancetype)dbWithName:(NSString *)name options:(NSDictionary *)options;

- (BOOL)putValue:(id<NSCoding>)value forKey:(NSString *)key;

- (BOOL)deleteValueForKey:(NSString *)key;

- (id)getValueForKey:(NSString *)key;

- (BOOL)synchronize;
@end
