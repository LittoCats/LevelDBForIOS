//
//  LevelDB.m
//  LevelDBForIOS
//
//  Created by 程巍巍 on 2/16/15.
//  Copyright (c) 2015 Littocats. All rights reserved.
//

#import "LevelDB.h"

#import "db.h"
#include <stdio.h>

@interface LevelDB ()
{
    leveldb::DB *_db;
    leveldb::ReadOptions _readOptions;
    leveldb::WriteOptions _writeOptions;
}

@property (nonatomic, strong) NSString        *name;
@property (nonatomic, strong) NSDictionary    *options;

@end

static NSMapTable *dbMap;

@implementation LevelDB

+ (instancetype)dbWithName:(NSString *)name options:(NSDictionary *)options
{
    @synchronized(self){
        if (!dbMap) dbMap = [NSMapTable weakToStrongObjectsMapTable];
        LevelDB *db = [dbMap objectForKey:name];
        if (!db) {
            db = [[self alloc] initWithName:name options:options];
        }
        return db;
    }
}

- (id)initWithName:(NSString *)name options:(NSDictionary *)conf
{
    if (self = [super init]) {
        self.name       = [name copy];
        self.options    = [NSDictionary dictionaryWithDictionary:conf];
        
        leveldb::Options options = [self optionWithConfigure:self.options];
        leveldb::DB::Open(options, [self.name UTF8String], &_db);
        
    }
    return self;
}

- (BOOL)putValue:(id<NSCoding>)value forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
    leveldb::Status status = _db->Put(_writeOptions, leveldb::Slice([key UTF8String]), leveldb::Slice((const char *)[data bytes], data.length));
    return status.ok();
}

- (BOOL)deleteValueForKey:(NSString *)key
{
    leveldb::Status status = _db->Delete(_writeOptions, leveldb::Slice([key UTF8String]));
    return status.ok();
}

- (id)getValueForKey:(NSString *)key
{
    std::string slice;
    leveldb::Status status = _db->Get(_readOptions, leveldb::Slice([key UTF8String]), &slice);
    if (!status.ok()) return nil;
    
    const char *c_str = slice.c_str();
    NSData *data = [[NSData alloc] initWithBytes:c_str length:slice.length()];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (BOOL)synchronize
{
    return YES;
}

#define LoadOption(op)  id op = [conf objectForKey:@#op]; if (op) options.op = [op intValue];

#pragma mark- options init
- (leveldb::Options)optionWithConfigure:(NSDictionary *)conf
{
    leveldb::Options options;
    
    LoadOption(create_if_missing)
    LoadOption(error_if_exists)
    LoadOption(paranoid_checks)
    LoadOption(write_buffer_size)
    LoadOption(max_open_files)
    LoadOption(block_size)
    LoadOption(block_restart_interval)
    
    return options;
}
@end
