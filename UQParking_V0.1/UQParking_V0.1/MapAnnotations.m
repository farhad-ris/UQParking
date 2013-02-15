//
//  MapAnnotations.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotations.h"

@implementation MapAnnotations

@synthesize title;
@synthesize subtitle;
@synthesize coordinate;

- (void)dealloc
{
    self.title = nil;
    self.subtitle = nil;
}

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}

@end
