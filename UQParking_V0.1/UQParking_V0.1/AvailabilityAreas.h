//
//  AvailabilityAreas.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 27/07/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AvailabilityAreas : NSManagedObject

@property (nonatomic, retain) NSString * availabilityPercentage;
@property (nonatomic, retain) NSString * daysOfWeek;
@property (nonatomic, retain) NSString * parkingName;
@property (nonatomic, retain) NSString * time;

@end
