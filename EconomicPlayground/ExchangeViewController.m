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
@property (weak, nonatomic) IBOutlet UITextField *usdTextField;
@property (weak, nonatomic) IBOutlet UITextField *currencyTextField;
@property NSMutableDictionary* dicts;
@property NSMutableArray* dates;
@property NSMutableArray* toUSDs;
@property NSMutableArray* dataSet;
@property double exchangeRate;
@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.exchangeRate = 2;
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
//    Data* data = [Data new];
    return @"";
}

- (void) loadDates:(NSArray*) temp
{
    for (id tuple in temp) {
        [self breakApartTuple:tuple];
        NSLog(@"At datapoint %lu, %@,", (unsigned long)[temp indexOfObject:tuple], tuple);
    }
}

- (void) displayData:(NSArray*) tempTwo
{
//    NSLog(@"Value of Dolar in (Date , Peso) format - \n\n%@", tempTwo);
//    NSLog(@"%@", [tempTwo objectAtIndex:1]);
//    NSLog(@"%@", self.dates);
}

- (IBAction)checkTextField:(UITextField*)sender
{
    NSNumberFormatter* formatter = [NSNumberFormatter new];
    NSNumber* number = [formatter numberFromString:sender.text];
    if (![sender.text isEqualToString:@""] && number != nil && [self.currencyTextField.text isEqualToString:@""])
    {

    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Cannot execute this conversion." message:@"Must have only one number input, and currency selected" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
        self.usdTextField.text = @"";
    }
}

- (IBAction)checkTextFieldTwo:(UITextField*)sender
{
    NSNumberFormatter* formatter = [NSNumberFormatter new];
    NSNumber* number = [formatter numberFromString:sender.text];
    if (![sender.text isEqualToString:@""] && number != nil && [self.usdTextField.text isEqualToString:@""])
    {

    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Cannot execute this conversion." message:@"Must have only one number input, and currency selected" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
        self.currencyTextField.text = @"";
    }
}

- (IBAction)currencyButtonHit:(id)sender
{

}

- (IBAction)convertButtonPressed:(id)sender
{
    if ([self.usdTextField.text isEqualToString:@""])
    {
        NSLog(@"%@ pesos, is equivalent to $%00f USD", self.currencyTextField.text, self.currencyTextField.text.doubleValue/self.exchangeRate);
    }
    if ([self.currencyTextField.text isEqualToString:@""])
    {
        NSLog(@"$%@ USD, is equivalent to %00f pesos", self.usdTextField.text, self.usdTextField.text.doubleValue*self.exchangeRate);
    }
}

@end
