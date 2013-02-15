//
//  ParkingAreas.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 13/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/Mapkit.h>
#import <UIKit/UIKit.h>
#import "FirstViewController.h"

//#import "ParkingProfileVC.h"

@class FirstViewController;



@interface ParkingAreas : UIViewController <MKMapViewDelegate> 
{
    NSArray *parkingAreaNameAndTime;
    
    NSString *parkingAreaName;
    NSString *parkingAreaColor;
    FirstViewController* firstvc;
    IBOutlet MKMapView *parkingAreasMapView;
    IBOutlet UIView *parkingAreaViewControler;
 
    IBOutlet UIButton *currentLocationButton;
    
    
    
//    MKMapType *mapTypeGlobal;
    
}
@property (nonatomic,copy) NSArray *parkingAreaNameAndTime;
@property (strong) NSMutableArray* annotations;
@property (nonatomic, retain) IBOutlet MKMapView* parkingAreasMapView ;
@property (nonatomic, copy) FirstViewController* firstvc;
@property (nonatomic, copy) NSString *parkingAreaName;
@property (nonatomic, copy) NSString *parkingAreaColor;
@property (nonatomic, retain) NSDate *
getCurrentTimeInNSDate;

@property (assign) BOOL setLocation;

//    +(NSString*) getTheMapStyle;

- (IBAction)showCurrentLocation:(id)sender;

@end
