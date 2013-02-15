//
//  MapStyleViewController.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 25/09/12.
//
//

#import <UIKit/UIKit.h>
#import "ParkingAreasViewController.h"

@interface MapStyleViewController : UIViewController
- (IBAction)mapStyleChange:(id)sender;
- (IBAction)postOnFacebook:(id)sender;
- (IBAction)postOnTwitter:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mapStyleSegmentControl;

@property (weak) ParkingAreas *parentVC;

@end
