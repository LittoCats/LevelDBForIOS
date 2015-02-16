//
//  ViewController.m
//  LevelDBForIOS
//
//  Created by 程巍巍 on 2/16/15.
//  Copyright (c) 2015 Littocats. All rights reserved.
//

#import "ViewController.h"

#import "db.h"

#import "LevelDB_objc/LevelDB.h"

#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) LevelDB *db;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.db = [LevelDB dbWithName:[NSTemporaryDirectory() stringByAppendingPathComponent:@"person"] options:@{@"create_if_missing":@(YES)}];

    Person *p0 = [Person new];
    p0.name = @"张三";
    p0.age = 27;
    
    [self.db putValue:p0 forKey:@"p0"];
    
    Person *p = [self.db getValueForKey:@"p0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
