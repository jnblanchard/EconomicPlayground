//
//  ExchangeViewController.m
//  EconomicPlayground
//
//  Created by John Blanchard on 11/10/14.
//  Copyright (c) 2014 John Blanchard. All rights reserved.
//

#import "ExchangeViewController.h"
#import "Data.h"
//#import <ShinobiCharts/ShinobiCharts.h>

@interface ExchangeViewController ()    //<SChartDatasource, SChartDelegate>
@property NSMutableDictionary* dicts;
@property NSMutableArray* dates;
@property NSMutableArray* toUSDs;
@property NSMutableArray* dataSet;
@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadJSON];
}

//-(NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
//{
//    return 5;
//}
//
//-(NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart
//{
//    return 1;
//}
//
//-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index
//{
//    SChartSeries* series = [[SChartSeries alloc] init];
//    return series;
//}
//
//-(id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex
//{
//    SChartDataPoint* dp = [[SChartDataPoint alloc] init];
//    return dp;
//}

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
         [self loadDates:tempTwo];
         [self displayData:tempTwo];
     }];
}

- (NSString*) breakApartTuple:(NSString*) tuple
{
    if ([tuple isKindOfClass:[NSString class]]) {
        NSLog(@"true");
    }
    Data* data = [Data new];
    return @"";
}

- (NSString*) loadDates:(NSArray*) temp
{
    for (id tuple in temp) {
        [self breakApartTuple:tuple];
    }
    return [NSString stringWithFormat:@"load dates finished"];
}

- (void) displayData:(NSArray*) tempTwo
{
//    NSLog(@"Value of Dolar in (Date , Peso) format - \n\n%@", tempTwo);
//    NSLog(@"%@", [tempTwo objectAtIndex:1]);
//    NSLog(@"%@", self.dates);
}

@end
