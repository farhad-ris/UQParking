//
//  parkingAreaNamesTableView.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 27/07/12.
//
//

#import <UIKit/UIKit.h>
#import "UqParkingBrain.h"

@class ParkingAreas;

@interface ParkingAreaNamesTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>//, NSObject,UIApplicationDelegate>

@property (nonatomic, strong) NSArray *parkingAreasNames; // names of parking areas in the table view
@property (nonatomic, strong) NSArray *parkingAreasPhotos; // pictures of parking areas in the table view
@property (nonatomic, strong) NSArray *parkingAreasColors; // colors of parking areas based on their availability probability

@property (nonatomic, strong) NSString *dateString;

@property (nonatomic, retain) ParkingAreas * parkingAreaNameAndTime;
@property (strong, nonatomic) NSArray *parkingAndTime;


@property (strong, nonatomic) IBOutlet UIDatePicker *planParkingDatePicker;

- (IBAction)planParkingDatePickerValueChange:(id)sender;
@property (nonatomic, retain) NSDate *date;

//     **** recognizing the gesture when a image is tabbed ****
- (void)showSelectedParkingArea:(id)sender;
- (int)selectedParkingAreaInScrollView:(CGPoint)contentOffset;

  
@end
