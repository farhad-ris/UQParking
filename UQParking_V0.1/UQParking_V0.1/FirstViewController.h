//
//  FirstViewController.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ParkingAreas;

BOOL parkingAreasPageControlIsChangingPage;

@interface FirstViewController: UIViewController <UIScrollViewDelegate , UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *applicationName;
@property (weak, nonatomic) IBOutlet UIImageView *uqLogo;


@property (weak, nonatomic) IBOutlet UIScrollView *parkingScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *parkingPageControl;
  
//@property (nonatomic, retain) ParkingAreas * parkingAreas;

@property (nonatomic, retain) ParkingAreas *parkingAreaNameAndTime;
@property (nonatomic, strong) NSArray * parkingAndTime;



  
//     **** parkingPageControl ****
- (IBAction)slidePage:(id)sender;

//     **** recognizing the gesture when a image is tabbed ****
- (void)showSelectedParkingArea:(id)sender;
- (int)selectedParkingAreaInScrollView:(CGPoint)contentOffset;


//      **** Parking areas scrollView ****

- (void) parkingAreaScrollingView;
//- (void)updateCurrentPageDisplay;

@end
