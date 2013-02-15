//
//  ParkometerViewController.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 27/11/12.
//
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"


@interface ParkometerViewController : UIViewController <XYPieChartDelegate, XYPieChartDataSource>

@property (strong, nonatomic) IBOutlet XYPieChart *parkometerPieChartView;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart;
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index;

@end
