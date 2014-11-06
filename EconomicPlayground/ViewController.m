//
//  ViewController.m
//  EconomicPlayground
//
//  Created by John Blanchard on 11/5/14.
//  Copyright (c) 2014 John Blanchard. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSMutableDictionary* dicts;
@property NSMutableArray* dates;
@property NSMutableArray* toUSDs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadJSON];
}

- (void) loadJSON
{
    self.dicts = [NSMutableDictionary new];
    self.dates = [NSMutableArray new];
    self.toUSDs = [NSMutableArray new];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.quandl.com/api/v1/datasets/FRED/DEXMXUS"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *rsp, NSData *data, NSError *connectionError)
     {
         NSArray* temp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         NSArray* tempTwo = [temp valueForKey:@"data"];
         NSLog(@"%@", [tempTwo objectAtIndex:1]);
         for (NSDictionary* dict in tempTwo) {
             if ([dict isKindOfClass:[NSDictionary class]]) {
                 [self.dicts addEntriesFromDictionary:dict];
             }
         }
         [self.dates addObjectsFromArray:[self.dicts allKeys]];
         [self.toUSDs addObjectsFromArray:[self.dicts allValues]];
         [self displayData];
     }];
}

- (void) displayData
{
    NSLog(@"%@", self.dates);
}

@end
