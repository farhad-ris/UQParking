//
//  AppDelegate.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AvailabilityAreas.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"availabilitytimes.sqlite"];
    [MagicalRecord setDefaultModelNamed:@"ModelTest.momd"];
   
    
    
    [self loadCSVFile];
    
    
    
    return YES;
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                          loadCSVFile
//
//            Import and pars the CSV file and make the entities
//***************************************************************************
//---------------------------------------------------------------------------

- (void)loadCSVFile {
    [AvailabilityAreas truncateAll];
    NSError *error = nil;
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"parkingavailability" ofType:@"csv"];
    NSString *data = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    NSArray *entries = [data componentsSeparatedByString:@"\r"];
    
    
    
    //---------------------------------------------------------------------------
    //                               Block Used
    //---------------------------------------------------------------------------
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
        for(NSString *entry in entries) {
            NSArray *fields = [entry componentsSeparatedByString:@","];
            if(![[fields objectAtIndex:0] isEqualToString:@""]) {
                AvailabilityAreas *newEntry = [AvailabilityAreas createInContext:context];
                [newEntry setParkingName:[fields objectAtIndex:0]];
                [newEntry setDaysOfWeek:[fields objectAtIndex:1]];
                [newEntry setTime:[fields objectAtIndex:2]];
                [newEntry setAvailabilityPercentage:[fields objectAtIndex:3]];
                //            [context save];
            }
            //        [context save];
        }
        [context save];
    });
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
