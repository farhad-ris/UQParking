//
//  MapAnnotations.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotations : NSObject<MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString* title;
    NSString* subtitle;
    
}

@property (nonatomic, assign)   CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)     NSString* title;
@property (nonatomic, copy)     NSString* subtitle;

@end
