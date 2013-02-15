//
//  ParkingAreas.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParkingAreasViewController.h"
#import "FirstViewController.h"
#import "MapAnnotations.h"
#import "ParkingRegionOverlay.h"
#import <MapKit/Mapkit.h>
#import "UqParkingBrain.h"
#import "AvailabilityAreas.h"
#import "UIColor-Expanded.h"
#import "MapStyleViewController.h"


#define StLucia_LAT -27.4955
#define StLucia_LONG 153.015454


#define Knoll_LAT -27.499402
#define Knoll_LONG 153.017449

#define UQCentre_LAT -27.49603
#define UQCentre_LONG 153.01632

#define MacGregor_LAT -27.492798
#define MacGregor_LONG 153.014917

@interface ParkingAreas () <UITabBarControllerDelegate> 
- (void)configureView;
@end

@implementation ParkingAreas 

@synthesize parkingAreasMapView=_parkingAreasMapView;
@synthesize firstvc;
@synthesize parkingAreaName;
@synthesize annotations;
@synthesize parkingAreaColor;
@synthesize parkingAreaNameAndTime;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    // Show the navigation bar when view appears
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)gotoLocation
{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = -27.497880;
    newRegion.center.longitude = 153.011312;
    
    
    [self.parkingAreasMapView setRegion:newRegion animated:YES];
}    


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"AAA %@",segue.identifier);
    if ([segue.identifier isEqualToString:@"StyleSegue"])
    {
        MapStyleViewController *mapStyle = segue.destinationViewController;
        mapStyle.parentVC = self;
    }
}




//---------------------------------------------------------------------------
//***************************************************************************
//              
//                      ***** VIEW DID LOAD *****
//
//          Loading the mapview and set the centre cordinate of it
//***************************************************************************
//---------------------------------------------------------------------------



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"parkingAreaName in the ParkingAreasViewController is: %@  at: %@ ", [parkingAreaNameAndTime objectAtIndex:0], [parkingAreaNameAndTime objectAtIndex:1] );
    
    
//    mapTypeGlobal = self.parkingAreasMapView.mapType;
   
    
    if ([[parkingAreaNameAndTime objectAtIndex:0] isEqual: @"St Lucia"]) { NSLog(@"St Lucia");
        CLLocationCoordinate2D center =
        CLLocationCoordinate2DMake(StLucia_LAT, StLucia_LONG);
        
        parkingAreaColor = [UqParkingBrain colorOfChosenParkingArea:@"UQ Centre Parking Station" BasedOnChosenTime:[parkingAreaNameAndTime objectAtIndex:1]];
       
        [self.parkingAreasMapView setRegion:
         MKCoordinateRegionMake(center,
                                MKCoordinateSpanMake(0.007, 0.007)) animated:YES];
        
        [self loadParkingOverlays: @"UQ Centre Parking Station"  ];
        [self loadParkingOverlays: @"Sir William MacGregor Drive" ];
        [self loadParkingOverlays: @"Conifer Knoll Parking Station L1"   ];
        [self loadParkingOverlays: @"Conifer Knoll Parking Station L3"  ];
        
        
        [self loadParkingAnnotations:@"UQ Centre Parking Station" ];
        [self loadParkingAnnotations:@"Sir William MacGregor Drive" ];
        [self loadParkingAnnotations:@"Conifer Knoll Parking Station L1" ];
        [self loadParkingAnnotations:@"Conifer Knoll Parking Station L3" ];
        
        
    }
    
    else if ([[parkingAreaNameAndTime objectAtIndex:0] isEqual: @"UQ Centre Parking Station"]) { NSLog(@"UQ Centre Parking Station Map");
        CLLocationCoordinate2D center = 
        CLLocationCoordinate2DMake(UQCentre_LAT, UQCentre_LONG);
        
        parkingAreaColor = [UqParkingBrain colorOfChosenParkingArea:[parkingAreaNameAndTime objectAtIndex:0] BasedOnChosenTime:[parkingAreaNameAndTime objectAtIndex:1]];
        [self.parkingAreasMapView setRegion: 
         MKCoordinateRegionMake(center, 
                                MKCoordinateSpanMake(0.001, 0.001)) animated:YES];
        [self loadParkingOverlays:@"UQ Centre Parking Station"];
        [self loadParkingAnnotations: @"UQ Centre Parking Station"];
        
         
    }
    
    else if ([[parkingAreaNameAndTime objectAtIndex:0] isEqual: @"Sir William MacGregor Drive"]) { NSLog(@"Sir William MacGregor Drive Map");
        CLLocationCoordinate2D center = 
        CLLocationCoordinate2DMake(MacGregor_LAT, MacGregor_LONG);
        
        parkingAreaColor = [UqParkingBrain colorOfChosenParkingArea:[parkingAreaNameAndTime objectAtIndex:0] BasedOnChosenTime:[parkingAreaNameAndTime objectAtIndex:1]];
        [self.parkingAreasMapView setRegion:
         MKCoordinateRegionMake(center, 
                                MKCoordinateSpanMake(0.004, 0.004))animated:YES];
        
        [self loadParkingOverlays: @"Sir William MacGregor Drive"];
        [self loadParkingAnnotations:@"Sir William MacGregor Drive"];
    
    }
    else if ([[parkingAreaNameAndTime objectAtIndex:0] isEqual: @"Conifer Knoll Parking Station L1"]) { NSLog(@"Conifer Knoll Parking Station Map");
        CLLocationCoordinate2D center = 
        CLLocationCoordinate2DMake(Knoll_LAT, Knoll_LONG);
        
        parkingAreaColor = [UqParkingBrain colorOfChosenParkingArea:[parkingAreaNameAndTime objectAtIndex:0] BasedOnChosenTime:[parkingAreaNameAndTime objectAtIndex:1]];
        [self.parkingAreasMapView setRegion:
         MKCoordinateRegionMake(center, 
                                MKCoordinateSpanMake(0.001, 0.001))animated:YES];
        
        [self loadParkingOverlays: @"Conifer Knoll Parking Station L1"];
        [self loadParkingAnnotations: @"Conifer Knoll Parking Station L1"];
    }
    else if ([[parkingAreaNameAndTime objectAtIndex:0] isEqual: @"Conifer Knoll Parking Station L3"]) { NSLog(@"Conifer Knoll Parking Station Map");
        CLLocationCoordinate2D center = 
        CLLocationCoordinate2DMake(Knoll_LAT, Knoll_LONG);
        
        parkingAreaColor = [UqParkingBrain colorOfChosenParkingArea:[parkingAreaNameAndTime objectAtIndex:0] BasedOnChosenTime:[parkingAreaNameAndTime objectAtIndex:1]];
        [self.parkingAreasMapView setRegion:
         MKCoordinateRegionMake(center, 
                                MKCoordinateSpanMake(0.001, 0.001))animated:YES];
        
        [self loadParkingOverlays: @"Conifer Knoll Parking Station L3"];
        [self loadParkingAnnotations: @"Conifer Knoll Parking Station L3"];
    }
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                      Mapview did update user location
//
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
//    if(!self.setLocation){
//        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.007;
        span.longitudeDelta = 0.007;
        CLLocationCoordinate2D location;
        location.latitude = aUserLocation.coordinate.latitude;
        location.longitude = aUserLocation.coordinate.longitude;
        region.span = span;
        region.center = location;
        [aMapView setRegion:region animated:YES];
//        self.setLocation= YES;
//    }
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                  MKAnnotationView for showing the created Annotations
//
//***************************************************************************
//---------------------------------------------------------------------------

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    
    
    
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MapAnnotations class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[mapView
                                                                 dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (!pinView)
        {
            //            *** If an existing pin view was not available, create one ***
            
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomPinAnnotation"]
            ;
            pinView.pinColor = MKPinAnnotationColorPurple;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            
            
            
            //            *** Add image at the left side ***
            UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parking.png"]];
            pinView.leftCalloutAccessoryView = profileIconView;
//            pinView.rightCalloutAccessoryView = UIButtonTypeInfoLight;
            
            //             *** Add button at the right side ***
            UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = infoButton;
            
        }
        else
            pinView.annotation = annotation;
        
        return pinView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    for (id annot in mapView.annotations) {
        [mapView selectAnnotation:annot animated:FALSE];
    }
    
}

//---------------------------------------------------------------------------
//***************************************************************************
//    
//            Creating and Loading the Annotations
//
//***************************************************************************
//---------------------------------------------------------------------------    

-(void)loadParkingAnnotations: (NSString *) parkingArea{
    NSLog(@"load Parking Annotation");
    

    
    annotations =[[NSMutableArray alloc] init];
    
    if ([parkingArea isEqual: @"UQ Centre Parking Station" ]) { NSLog(@"UQ Centre Parking Station Annotation");
    


        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = UQCentre_LAT;
        theCoordinate.longitude = UQCentre_LONG;
        
        MapAnnotations* myAnnotation=[[MapAnnotations alloc] init];
        
        myAnnotation.coordinate=theCoordinate;
        myAnnotation.title=@"UQ Centre Parking Station";
        myAnnotation.subtitle=@"Full Day Parking";
        
        [self.parkingAreasMapView addAnnotation:myAnnotation];
        [annotations addObject:myAnnotation];
        
        
    }
    else if ([parkingArea isEqual: @"Conifer Knoll Parking Station L1"]) { NSLog(@"Conifer Knoll Parking Station Annotation");

       
        
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = Knoll_LAT;
        theCoordinate.longitude = Knoll_LONG;
        
        MapAnnotations* myAnnotation=[[MapAnnotations alloc] init];
        
        myAnnotation.coordinate=theCoordinate;
        myAnnotation.title=@"Conifer Knoll Parking L1";
        myAnnotation.subtitle=@"Full Day Parking";
        
        [self.parkingAreasMapView addAnnotation:myAnnotation];
        [annotations addObject:myAnnotation];
    }
    
    
    
    else if ([parkingArea isEqual: @"Conifer Knoll Parking Station L3"]) { NSLog(@"Conifer Knoll Parking Station Annotation");
        

        
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = Knoll_LAT;
        theCoordinate.longitude = Knoll_LONG;
        
        MapAnnotations* myAnnotation=[[MapAnnotations alloc] init];
        
        myAnnotation.coordinate=theCoordinate;
        myAnnotation.title=@"Conifer Knoll Parking L3";
        myAnnotation.subtitle=@"Full Day Parking";
        
        [self.parkingAreasMapView addAnnotation:myAnnotation];
        [annotations addObject:myAnnotation];
    }
    
    
    
    else if ([parkingArea isEqual: @"Sir William MacGregor Drive"]) { NSLog(@"Sir William MacGregor Drive Annotation");
    
        
        
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = MacGregor_LAT;
        theCoordinate.longitude = MacGregor_LONG;
        
        MapAnnotations* myAnnotation=[[MapAnnotations alloc] init];
        
        myAnnotation.coordinate=theCoordinate;
        myAnnotation.title=@"Sir William MacGregor Drive";
        myAnnotation.subtitle=@"Full Day Parking";
        
        [self.parkingAreasMapView addAnnotation:myAnnotation];
        [annotations addObject:myAnnotation];
    }
}


//--------------------------------------------------------------------------- 
//***************************************************************************
//    
//            Creating and Loading the Overlays
//
//***************************************************************************
//---------------------------------------------------------------------------    

- (void)loadParkingOverlays: (NSString*) parkingArea{
    NSLog(@"load Parking Overlay");
    
    if ([parkingArea isEqual: @"UQ Centre Parking Station"]) { NSLog(@"UQ Centre Parking Station Overlay");
        
    
    
    CLLocationCoordinate2D  points[13];
    
    points[0] = CLLocationCoordinate2DMake(-27.49544, 153.01615);
    points[1] = CLLocationCoordinate2DMake(-27.49545, 153.01621);
    points[2] = CLLocationCoordinate2DMake(-27.49541, 153.01623);
    points[3] = CLLocationCoordinate2DMake(-27.49555, 153.01661);
    points[4] = CLLocationCoordinate2DMake(-27.49559, 153.01659);
    points[5] = CLLocationCoordinate2DMake(-27.49563, 153.01666);
    points[6] = CLLocationCoordinate2DMake(-27.49614, 153.01652);    
    points[7] = CLLocationCoordinate2DMake(-27.4965, 153.01639);
    points[8] = CLLocationCoordinate2DMake(-27.49645, 153.01594);
    points[9] = CLLocationCoordinate2DMake(-27.49618, 153.01597);
    points[10] = CLLocationCoordinate2DMake(-27.49617, 153.01589);
    points[11] = CLLocationCoordinate2DMake(-27.49605, 153.01593);
    points[12] = CLLocationCoordinate2DMake(-27.49605, 153.01594);

//        chosenColor = [UqParkingBrain colorOfChosenParkingAreaCurrentTime: parkingAreaName ];
    
    MKPolygon* poly = [MKPolygon polygonWithCoordinates:points count:13];
    poly.title = @"UQ Centre Parking Station";
        
        [self.parkingAreasMapView addOverlay:poly ];
    }
    else if ([parkingArea isEqual: @"Conifer Knoll Parking Station L1"]) { NSLog(@"Conifer Knoll Parking Station Overlay");
        
        
        CLLocationCoordinate2D  points[17];
        
        points[0] = CLLocationCoordinate2DMake(-27.49981, 153.01740);
        points[1] = CLLocationCoordinate2DMake(-27.49978, 153.01741);
        points[2] = CLLocationCoordinate2DMake(-27.49977, 153.01745);
        points[3] = CLLocationCoordinate2DMake(-27.49968, 153.01776);
        points[4] = CLLocationCoordinate2DMake(-27.49946, 153.01792);
        points[5] = CLLocationCoordinate2DMake(-27.49919, 153.01792);
        points[6] = CLLocationCoordinate2DMake(-27.49905, 153.01783);
        points[7] = CLLocationCoordinate2DMake(-27.49905, 153.01783);
        points[8] = CLLocationCoordinate2DMake(-27.49896, 153.01777);
        points[9] = CLLocationCoordinate2DMake(-27.49885, 153.01767);
        points[10] = CLLocationCoordinate2DMake(-27.49892, 153.01759);
        points[11] = CLLocationCoordinate2DMake(-27.49906, 153.01737);
        points[12] = CLLocationCoordinate2DMake(-27.49916, 153.01726);
        points[13] = CLLocationCoordinate2DMake(-27.49942, 153.01705);
        points[14] = CLLocationCoordinate2DMake(-27.49954, 153.01701);
        points[15] = CLLocationCoordinate2DMake(-27.49968, 153.01699);
        points[16] = CLLocationCoordinate2DMake(-27.49969, 153.01703);
//        points[1] = CLLocationCoordinate2DMake(41.002371, 102.052066);

        
        
        MKPolygon* poly = [MKPolygon polygonWithCoordinates:points count:17];
        poly.title = @"Conifer Knoll Parking Station L1";
        
        [self.parkingAreasMapView addOverlay:poly];
    }
    else if ([parkingArea isEqual: @"Conifer Knoll Parking Station L3"]) { NSLog(@"Conifer Knoll Parking Station Overlay");
        
        
        CLLocationCoordinate2D  points[17];
        
        points[0] = CLLocationCoordinate2DMake(-27.49981, 153.01740);
        points[1] = CLLocationCoordinate2DMake(-27.49978, 153.01741);
        points[2] = CLLocationCoordinate2DMake(-27.49977, 153.01745);
        points[3] = CLLocationCoordinate2DMake(-27.49968, 153.01776);
        points[4] = CLLocationCoordinate2DMake(-27.49946, 153.01792);
        points[5] = CLLocationCoordinate2DMake(-27.49919, 153.01792);
        points[6] = CLLocationCoordinate2DMake(-27.49905, 153.01783);
        points[7] = CLLocationCoordinate2DMake(-27.49905, 153.01783);
        points[8] = CLLocationCoordinate2DMake(-27.49896, 153.01777);
        points[9] = CLLocationCoordinate2DMake(-27.49885, 153.01767);
        points[10] = CLLocationCoordinate2DMake(-27.49892, 153.01759);
        points[11] = CLLocationCoordinate2DMake(-27.49906, 153.01737);
        points[12] = CLLocationCoordinate2DMake(-27.49916, 153.01726);
        points[13] = CLLocationCoordinate2DMake(-27.49942, 153.01705);
        points[14] = CLLocationCoordinate2DMake(-27.49954, 153.01701);
        points[15] = CLLocationCoordinate2DMake(-27.49968, 153.01699);
        points[16] = CLLocationCoordinate2DMake(-27.49969, 153.01703);
        //        points[1] = CLLocationCoordinate2DMake(41.002371, 102.052066);
        
        
        
        MKPolygon* poly = [MKPolygon polygonWithCoordinates:points count:17];
        poly.title = @"Conifer Knoll Parking Station L3";
        
        [self.parkingAreasMapView addOverlay:poly ];
    }
        
else if ([parkingArea isEqual: @"Sir William MacGregor Drive"]) { NSLog(@"Sir William MacGregor Drive Overlay");
    
    
    CLLocationCoordinate2D  points[15];
    
    points[0] = CLLocationCoordinate2DMake(-27.49214, 153.01264);
    points[1] = CLLocationCoordinate2DMake(-27.49213, 153.01281);
    points[2] = CLLocationCoordinate2DMake(-27.49214, 153.01290);
    points[3] = CLLocationCoordinate2DMake(-27.49220, 153.01338);
    points[4] = CLLocationCoordinate2DMake(-27.49226, 153.01362);
    points[5] = CLLocationCoordinate2DMake(-27.49238, 153.01404);
    points[6] = CLLocationCoordinate2DMake(-27.49246, 153.01427);
    points[7] = CLLocationCoordinate2DMake(-27.49259, 153.01459);
    points[8] = CLLocationCoordinate2DMake(-27.49271, 153.01483);
    points[9] = CLLocationCoordinate2DMake(-27.49281, 153.01502);
    points[10] = CLLocationCoordinate2DMake(-27.49291, 153.01516);
    points[11] = CLLocationCoordinate2DMake(-27.49301, 153.01533);
    points[12] = CLLocationCoordinate2DMake(-27.49312, 153.01547);
    points[13] = CLLocationCoordinate2DMake(-27.49369, 153.01621);
    points[14] = CLLocationCoordinate2DMake(-27.49428, 153.01681);
//    points[15] = CLLocationCoordinate2DMake(27.49968, 153.01699);
//    points[16] = CLLocationCoordinate2DMake(27.49969, 153.01703);
//    points[1] = CLLocationCoordinate2DMake(41.002371, 102.052066);
    
    
    
    MKPolyline* poly = [MKPolyline polylineWithCoordinates:points count:15];
    poly.title = @"Sir William MacGregor Drive";
    
    [self.parkingAreasMapView addOverlay:poly  ];    }
    
   

}






//---------------------------------------------------------------------------
//***************************************************************************
//
//                  MKOverlayView for showing the created Overlays
//
//***************************************************************************
//---------------------------------------------------------------------------




- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay //parkingAreaColors: (NSString *) parkingAreaColors
{
    NSLog(@"CALLING BACK OVERLAYS %@",overlay);
    
    
    NSString *parkingAreaColors=@"";
    parkingAreaColors = parkingAreaColor;
    
    NSString *theColor = parkingAreaColor;
    theColor = [UqParkingBrain colorOfChosenParkingArea:overlay.title BasedOnChosenTime:[parkingAreaNameAndTime objectAtIndex:1]];
    NSLog(@"SHOWING ANIMATION %@ %@",overlay.title,theColor);
    
    
    
    //---------------------------------------------------------------------------
    //***************************************************************************
    //
    //              cheking if it is Polugon
    //
    //***************************************************************************
    //---------------------------------------------------------------------------
    
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        
        
        
        MKPolygonView*    aView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay];
        
        if (theColor == @"redColor"){
            
            aView.fillColor = [[UIColor colorWithHexString:@"EE2734"] colorWithAlphaComponent:0.9];NSLog(@"Overlay Fill Color:%@", aView.fillColor);
            aView.strokeColor = [[UIColor colorWithHexString:@"204494"] colorWithAlphaComponent:0.9];NSLog(@"Overlay Stroke Color:%@", aView.strokeColor);
            aView.lineWidth = 3;
        }
        
        
        else if (theColor == @"yellowColor"){
            
            aView.fillColor = [[UIColor colorWithHexString:@"ECBF25"] colorWithAlphaComponent:0.9];NSLog(@"Overlay Fill Color:%@", aView.fillColor);
            aView.strokeColor = [[UIColor colorWithHexString:@"204494"] colorWithAlphaComponent:0.9];NSLog(@"Overlay Stroke Color:%@", aView.strokeColor);
            aView.lineWidth = 3;
        }
        
        
        else if (theColor == @"orangeColor"){
            
            aView.fillColor = [[UIColor orangeColor] colorWithAlphaComponent:0.9];NSLog(@"Overlay Fill Color:%@", aView.fillColor);
            aView.strokeColor = [[UIColor colorWithHexString:@"204494"] colorWithAlphaComponent:0.9];NSLog(@"Overlay Stroke Color:%@", aView.strokeColor);
            aView.lineWidth = 3;
        }
        
        
        else if (theColor == @"greenColor"){
            
            aView.fillColor = [[UIColor colorWithHexString:@"8DC63F"] colorWithAlphaComponent:0.9];NSLog(@"Overlay Fill Color:%@", aView.fillColor);
            aView.strokeColor = [[UIColor colorWithHexString:@"204494"] colorWithAlphaComponent:0.9];NSLog(@"Overlay Stroke Color:%@", aView.strokeColor);
            aView.lineWidth = 3;        }
        
        
        
        return aView;
    }
    
    
    //---------------------------------------------------------------------------
    //***************************************************************************
    //
    //              all overlayers but Polygon (if it's not polygon)
    //
    //***************************************************************************
    //---------------------------------------------------------------------------
    
    
    else if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineView* aView = [[MKPolylineView alloc] initWithPolyline:(MKPolyline *) overlay];
        if (theColor == @"greenColor"){
            aView.strokeColor = [[UIColor colorWithHexString:@"8DC63F"] colorWithAlphaComponent:0.9];NSLog(@"Overlay color:%@", aView.strokeColor);
            
        }else if (theColor == @"yellowColor"){
            aView.strokeColor = [[UIColor colorWithHexString:@"ECBF25"] colorWithAlphaComponent:0.9];NSLog(@"Overlay color:%@", aView.strokeColor);
            
        }else if (theColor == @"orangeColor"){
            aView.strokeColor = [[UIColor orangeColor] colorWithAlphaComponent:0.9];NSLog(@"Overlay color:%@", aView.strokeColor);
            
        }else if (theColor == @"redColor"){
            aView.strokeColor = [[UIColor colorWithHexString:@"EE2734"] colorWithAlphaComponent:0.9];NSLog(@"Overlay color:%@", aView.strokeColor);
        }else 
            
            
            
            
            
            aView.lineWidth = 6;
        
        return aView;
    }
    
    return nil;
    
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** VIEW DID LOAD *****
//
//          Loading the mapview and set the centre cordinate of it
//***************************************************************************
//---------------------------------------------------------------------------



- (void)viewDidUnload
{
//    currentLocationButton = nil;
    currentLocationButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    parkingAreasMapView = nil;
    parkingAreasMapView = nil;
    parkingAreaViewControler = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** showCurrentLocation *****
//
//          Loading the mapview and set the centre cordinate of it
//***************************************************************************
//---------------------------------------------------------------------------

- (IBAction)showCurrentLocation:(id)sender {
    NSLog(@"Show the current location");
    
    if (self.parkingAreasMapView.showsUserLocation==YES) {
        NSLog(@"Show the current location");
        self.parkingAreasMapView.showsUserLocation=NO;
    } else {
        NSLog(@"Don't show the current location");
        self.parkingAreasMapView.showsUserLocation=YES;
        
    }
   
//    if (parkingAreasMapView.showsUserLocation==YES)
//    {
//        parkingAreasMapView.showsUserLocation=NO;
//    
//    } else
//    if (parkingAreasMapView.showsUserLocation==YES) {
//        parkingAreasMapView.showsUserLocation=NO;
//
//    }
}
@end
