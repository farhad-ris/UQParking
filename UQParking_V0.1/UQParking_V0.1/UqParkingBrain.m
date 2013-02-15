//
//  UqParkingBrain.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UqParkingBrain.h"
#import "AvailabilityAreas.h"

@implementation UqParkingBrain

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
        
    }
    
    return self;
    
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** getCurrentDayOfWeek *****
//
//
//***************************************************************************
//---------------------------------------------------------------------------

+ (NSString *) getCurrentDayOfWeek{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    NSString *newDateString= [dateFormatter stringFromDate:[NSDate date]];
    

    
    return newDateString;


}



//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** getCurrentTime *****
//
//
//***************************************************************************
//---------------------------------------------------------------------------

+(NSString *) getCurrentTime{
    
    
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    NSLog(@"newDateString %@", newDateString);
    return newDateString;
    
    
}





//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** getCurrentTimeInNSDate *****
//
//
//***************************************************************************
//---------------------------------------------------------------------------

+(NSDate *) getCurrentTimeInNSDate{
    
    
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    NSLog(@"getCurrentTimeInNSDate %@", newDateString);
    return outputFormatter;
    

    
}



//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** getMinutesInDay *****
//
//          
//***************************************************************************
//---------------------------------------------------------------------------

+ (int) getMinutesInDay:(NSString *)stringTime {
    NSScanner* timeScanner=[NSScanner scannerWithString:stringTime];
    int hours;
    int minutes;
    [timeScanner scanInt:&hours];
    [timeScanner scanString:@":" intoString:nil]; //jump over :
    [timeScanner scanInt:&minutes];
    return (hours*60)+minutes;
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//       ***** colorOfChosenParkingAreaBaseOnChosenDayAndTime *****
//
// giving the current color of the chosen Parking area based on chosen day and time
//***************************************************************************
//---------------------------------------------------------------------------

+ (NSString *) colorOfChosenParkingArea: (NSString *) parkingName BaseOnChosenDay:(NSString *) day AndTime:(NSString *) stringTime{
    
    
    NSString *colorOfChosenParkingArea;
    
    
    
    if ([day isEqual:@"Saturday"]) {
        day = @"WeekEnds";
    } else if ([day isEqual:@"Sunday"]) {
        day = @"WeekEnds";
    } else if ([day isEqual:@"Monday"]) {
        day = @"WeekDays";
    } else if ([day isEqual:@"Tuesday"]) {
        day = @"WeekDays";
    } else if ([day isEqual:@"Wednesday"]) {
        day = @"WeekDays";
    } else if ([day isEqual:@"Thursday"]) {
        day = @"WeekDays";
    } else if ([day isEqual:@"Friday"]) {
        day = @"WeekDays";
    } 




    
    
    
    
   
    
    
    int currentTime = [UqParkingBrain getMinutesInDay:stringTime];
    
    
    NSPredicate *areaFilter = [NSPredicate predicateWithFormat:@"(daysOfWeek == %@) AND (parkingName == %@)", day,parkingName];
    NSArray *areas = [AvailabilityAreas findAllWithPredicate:areaFilter];
    
    if([areas count] > 0) {
    
        
        int currentSmallest = 99999999;
        AvailabilityAreas *currentArea = nil;
        for (AvailabilityAreas *area in areas) {
            int timestamp = [UqParkingBrain getMinutesInDay:[area time]];
            int diff = timestamp - currentTime;
            if(diff >= 0 && diff < currentSmallest) {
                currentSmallest = diff;
                currentArea = area;
            }
        }
        if(currentArea) {
            NSString *percentage = [currentArea availabilityPercentage];
            percentage = [percentage substringToIndex:[percentage length]-1];
            
            colorOfChosenParkingArea = [UqParkingBrain colorBasedOnPercentage:percentage];
        } else {
            NSLog(@"COULDNT FIND A FURTHER TIME");
        }
    }
else {
        NSLog(@"NOTHING FOUND !#@!#@#!@@!");
    }
    return colorOfChosenParkingArea;
    
    
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//            ***** colorOfChosenParkingAreaBasedOnChosenTime *****
//
//        giving the current color of the chosen Parking area
//***************************************************************************
//---------------------------------------------------------------------------

+ (NSString *) colorOfChosenParkingArea: (NSString *) parkingName BasedOnChosenTime:(NSString *) stringTime
{
    
    NSString *colorOfChosenParkingArea;
    
    
    NSString *day = @"Tuesday";
    //NSString *stringTime = @"14:43";
    
    
    day = [UqParkingBrain getCurrentDayOfWeek];
    
    NSLog(@"The Parking Area Name: %@", parkingName);
    NSLog( @"The Current Day of Week: %@", day);
    NSLog(@"The Current Time: %@", stringTime);
    
    NSLog(@"The Parking Name: %@",parkingName);
   
    
    
    colorOfChosenParkingArea = [UqParkingBrain colorOfChosenParkingArea:parkingName BaseOnChosenDay:day AndTime:stringTime];
    
    return colorOfChosenParkingArea;
}




//---------------------------------------------------------------------------
//***************************************************************************
//
//            ***** colorOfChosenParkingAreaCurrentTime *****
//
//        giving the current color of the chosen Parking area 
//***************************************************************************
//---------------------------------------------------------------------------

+ (NSString *) colorOfChosenParkingAreaCurrentTime: (NSString *) parkingName
{
    
    NSString *colorOfChosenParkingArea;
    
    
    NSString *day = @"Tuesday";
    NSString *stringTime = @"14:43";
    
    
    stringTime = [UqParkingBrain getCurrentTime];
    day = [UqParkingBrain getCurrentDayOfWeek];
    
    NSLog(@"The Parking Area Name: %@", parkingName);
    NSLog( @"The Current Day of Week: %@", day);
    NSLog(@"The Current Time: %@", stringTime);
    
    NSLog(@"The Parking Name: %@",parkingName);

    
    
    colorOfChosenParkingArea = [UqParkingBrain colorOfChosenParkingArea:parkingName BaseOnChosenDay:day AndTime:stringTime];
    
    return colorOfChosenParkingArea;
}



//---------------------------------------------------------------------------
//***************************************************************************
//
//                   ***** percentageToColour *****
//
//            return a colour based on a percentage number
//***************************************************************************
//---------------------------------------------------------------------------



+(NSString *) percentageToColour:(int) aNumber{
    
    if (aNumber < 40) {
        return @"redColor";
    } else if ( aNumber >= 40 && aNumber < 70){
        return @"orangeColor";
    } else if ( aNumber >= 70 && aNumber <90){
        return @"yellowColor";
    } else if ( aNumber >=90 && aNumber <=100){
        return @"greenColor";
    }
    return @"Gray";    
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                  ***** colorBasedOnPercentage *****
//
//          giving a color back based on the data base percentages
//***************************************************************************
//---------------------------------------------------------------------------

+(NSString *)colorBasedOnPercentage:(NSString *)percentage {
    NSString * colour;
    colour = @"greenColor";
    colour = [ UqParkingBrain percentageToColour:[percentage intValue]];
    return colour;
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** randomPercentage *****
//
//                  return a random number from 0 to 100t
//***************************************************************************
//---------------------------------------------------------------------------


+(int) randomPercentage{
    
   
    int percentage = 0 + random() % 100;
    
    NSString* myNewString = [NSString stringWithFormat:@"%d", percentage];
    NSLog(@"SVM Returned Percentage:");
    NSLog( @"Random Percentage is: %@",myNewString);

    
    return percentage;
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//            ***** colorsBasedOnRandomPercentages *****
//
//          giving a color back based on a random percentages
//***************************************************************************
//---------------------------------------------------------------------------

+(NSString* ) colorsBasedOnRandomPercentages{
    NSString * colour;
    colour = @"greenColor";
    
    int randNumber;
    randNumber = [UqParkingBrain randomPercentage];
    
    colour = [ UqParkingBrain percentageToColour: randNumber ];
    
    return colour;
}




@end
