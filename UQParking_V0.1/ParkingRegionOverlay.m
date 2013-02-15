//
//  ParkingRegionOverlay.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParkingRegionOverlay.h"

@implementation ParkingRegionOverlay

//@synthesize origin;
@synthesize polygon;

//@synthesize rect;

//
//-(ParkingRegionOverlay*) initialize {
//    MKMapPoint points[3] = {{38.53607,-121.765793}, {38.537606,-121.768379}, {38.53487,-121.770578}};
//    polygon = [MKPolygon polygonWithPoints:points count:3];
//    polygon.title = @"Some Polygon";
//    return self;
//}

-(id)init {
    if (self = [super init]) {
        NSLog(@"TESTING");
        MKMapPoint points[3];
        CLLocationCoordinate2D c1 = {-27.49544,153.01615};
        points[0] = MKMapPointForCoordinate(c1);
        CLLocationCoordinate2D c2 = {-27.49545,153.01621};
        points[1] = MKMapPointForCoordinate(c2);
        CLLocationCoordinate2D c3 = {-27.49541,153.01623};
        points[2] = MKMapPointForCoordinate(c3);
        
        polygon = [MKPolygon polygonWithPoints:points count:3];
        polygon.title = @"Some Polygon";
    }
    return self;
}
//        **** making overlay polygon 
//MKMapPoint points[12] = {{-27.49544,153.01615}, {-27.49545,153.01621}, {-27.49541,153.01623}, {-27.49555,153.01661}, {-27.49559,153.01659}, {-27.49563,153.01666}, {-27.4965,153.01639}, {-27.49645,153.01594}, {-27.49541,153.01597}, {-27.49617,153.01589}, {-27.49605,153.01593}, {-27.49605,153.01594}};
//MKPolygon *uqCentreParkingPolygon = [MKPolygon polygonWithPoints:points count:12];
//
//[self.parkingAreasMapView addOverlay:uqCentreParkingPolygon];


//- (MKMapRect)boundingMapRect{
//    MKMapRect bounds = MKMapRectMake(-121.770578,38.537606,-121.770578-(-121.765793),38.537606-38.53487);
//    return bounds;
//}

- (MKMapRect)boundingMapRect{
    CLLocationCoordinate2D corner1 = 
    CLLocationCoordinate2DMake(38.537606, -121.770578);
    MKMapPoint mp1 = MKMapPointForCoordinate(corner1);
    
    CLLocationCoordinate2D corner2 = 
    CLLocationCoordinate2DMake(38.53487, -121.765793);
    MKMapPoint mp2 = MKMapPointForCoordinate(corner2);
    
    MKMapRect bounds = 
    MKMapRectMake(mp1.x, mp1.y, (mp2.x-mp1.x), (mp2.y-mp1.y));
    
    return bounds;
}

- (CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake((38.537606-38.53487)/2, (-121.770578-(-121.765793))/2);
}

@end