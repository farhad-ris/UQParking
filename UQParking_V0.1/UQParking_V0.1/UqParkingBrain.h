//
//  UqParkingBrain.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface UqParkingBrain : NSObject

+(NSString *) getCurrentTime;
- (int) getMinutesInDay:(NSString *)stringTime;
+ (int) randomPercentage;
+ (NSString *) percentageToColour:(int) aNumber;
+ (NSString *) colorsBasedOnRandomPercentages;
+ (NSString *) colorBasedOnPercentage:(NSString *)percentage;
+ (NSString *) colorOfChosenParkingAreaCurrentTime: (NSString *) parkingName;
+ (NSString *) colorOfChosenParkingArea: (NSString *) parkingName BaseOnChosenDay:(NSString *) day AndTime:(NSString *) stringTime;
+ (NSString *) colorOfChosenParkingArea: (NSString *) parkingName BasedOnChosenTime:(NSString *) stringTime;


@end
