//
//  ParkingRegionOverlay.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface ParkingRegionOverlay : NSObject <MKOverlay> {
    //CLLocationCoordinate2D origin;
    MKPolygon *polygon;
    
    //MKMapRect rect;
}

//@property (nonatomic) CLLocationCoordinate2D origin;
@property (nonatomic, retain) MKPolygon *polygon;

//@property (nonatomic) MKMapRect rect;

//-(ParkingRegionOverlay*)initialize;

-(MKMapRect)boundingMapRect;
-(CLLocationCoordinate2D)coordinate;

@end