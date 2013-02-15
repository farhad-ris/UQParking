//
//  FirstViewController.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "ParkingAreasViewController.h"
#import "UIColor-Expanded.h"
#import "UqParkingBrain.h"

//@interface FirstViewController
//
//
//@end

@implementation FirstViewController
@synthesize applicationName;
@synthesize uqLogo;
@synthesize parkingScrollView=_parkingScrollView;
@synthesize parkingPageControl=_parkingPageControl;
@synthesize parkingAndTime;
@synthesize parkingAreaNameAndTime;

//---------------------------------------------------------------------------
//***************************************************************************
//
//                              viewDidLoad
//
//***************************************************************************
//---------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self parkingAreaScrollingView];
    
    
}



//---------------------------------------------------------------------------  
//***************************************************************************
//    
//                          showSelectedParkingArea
//
//  calling the firstControllerToParkingAreasSegue to show the next page
//***************************************************************************
//--------------------------------------------------------------------------- 


-(void) showSelectedParkingArea:(id)sender
{
    NSLog(@"Show the selected parking area");

    [self performSegueWithIdentifier:@"firstControllerToParkingAreasSegue" sender:self];
    
     
}


//---------------------------------------------------------------------------  
//***************************************************************************
//    
//                          prepareForSegue
//
//            preparing a sender for the firstControllerToParkingAreasSegue 
//***************************************************************************
//--------------------------------------------------------------------------- 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{ 
    if ([[segue identifier] isEqualToString:@"firstControllerToParkingAreasSegue"]) {
        
        // Get destination view
        NSLog(@"PUSHING TO NEW");
        
        NSString *now;
        
        now = [UqParkingBrain getCurrentTime];
        
          ParkingAreas *parkingAreaViewController = [segue destinationViewController];
        
        int currentPakingAreaIndex = [self selectedParkingAreaInScrollView:self.parkingScrollView.contentOffset];
        
        switch (currentPakingAreaIndex) {
            case 0:
                NSLog(@"St Lucia");
                parkingAndTime = [NSArray arrayWithObjects:@"St Lucia", now, nil];
                
                parkingAreaViewController.parkingAreaNameAndTime = parkingAndTime;
                break;

        }
        
  
        
    }
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                              viewWillAppear
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void) viewWillAppear:(BOOL)animated
{
    // Hide the navigation bar while we're at the top level
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
   
  
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                              viewWillDisappear
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.backItem.title = @"Park Now";
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                              viewDidAppear
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    //self.view.backgroundColor = [UIColor colorWithHexString:@"204494"];
    [applicationName setImage:[UIImage imageNamed:@"UQParkingLogo.png"]];
    [uqLogo setImage:[UIImage imageNamed:@"uqLogo.png"]]; 
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                     selectedParkingAreaInScrollView
//
//***************************************************************************
//---------------------------------------------------------------------------
- (int)selectedParkingAreaInScrollView:(CGPoint)contentOffset
{
    return floor(contentOffset.x / self.parkingScrollView.frame.size.width);
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                              viewDidUnload
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)viewDidUnload
{
    [self setApplicationName:nil];
    [self setUqLogo:nil];
    [self setParkingScrollView:nil];
    [self setParkingPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//---------------------------------------------------------------------------  
//***************************************************************************
//    
//                       parkingAreaScrollingView
//
//            the scrolling area in the firstViewController
//***************************************************************************
//--------------------------------------------------------------------------- 


-(void)parkingAreaScrollingView
{  
    
	[self.parkingScrollView setBackgroundColor:[UIColor blackColor]];
	[_parkingScrollView setCanCancelContentTouches:NO];
	
	_parkingScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	_parkingScrollView.clipsToBounds = YES;
	_parkingScrollView.scrollEnabled = YES;
	_parkingScrollView.pagingEnabled = YES;
    
	
	NSUInteger nimages = 0;
	CGFloat cx = 0;
	for (; ; nimages++) {
		NSString *imageName = [NSString stringWithFormat:@"campus%d.png", (nimages + 1)];
		UIImage *image = [UIImage imageNamed:imageName];
        NSLog(@"compus%d.png", (nimages + 1));
		if (image == nil) {
			break;
		}
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		CGRect rect = imageView.frame;
		rect.size.height = image.size.height;
		rect.size.width = image.size.width;

		rect.origin.x = ((_parkingScrollView.frame.size.width - image.size.width) / 2) + cx;
		rect.origin.y = ((_parkingScrollView.frame.size.height - image.size.height) / 2);
        
		imageView.frame = rect;
        
		[_parkingScrollView addSubview:imageView];
        
		cx += _parkingScrollView.frame.size.width;
	}
	
	self.parkingPageControl.numberOfPages = nimages;
    int currentPakingAreaIndex = [self selectedParkingAreaInScrollView:self.parkingScrollView.contentOffset];
    NSLog([NSString stringWithFormat:@"%d", currentPakingAreaIndex]);
     self.parkingPageControl.currentPage = currentPakingAreaIndex;
	[_parkingScrollView setContentSize:CGSizeMake(cx, [_parkingScrollView bounds].size.height)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSelectedParkingArea:)];
    [self.parkingScrollView addGestureRecognizer:tap];

    
}

//---------------------------------------------------------------------------  
//***************************************************************************
//    
//                       scrollViewDidScroll
//
//           refreshing the scrolling area in the firstViewController
//***************************************************************************
//---------------------------------------------------------------------------  


- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
   NSLog(@"Scrollllleeeeed");

    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog([NSString stringWithFormat:@"%d",page]);
    self.parkingPageControl.numberOfPages = page;
    self.parkingPageControl.currentPage = page;
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                              scrollViewDidEndDecelerating
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    parkingAreasPageControlIsChangingPage = YES;
}




//---------------------------------------------------------------------------
//***************************************************************************
//
//                              slidePage
//
//***************************************************************************
//---------------------------------------------------------------------------
- (IBAction)slidePage:(id)sender {
    
    CGRect frame = _parkingScrollView.frame;
    frame.origin.x = frame.size.width * _parkingPageControl.currentPage;
    frame.origin.y = 0;
	
    [_parkingScrollView scrollRectToVisible:frame animated:YES];

    parkingAreasPageControlIsChangingPage = YES;
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                              supportedInterfaceOrientations
//
//***************************************************************************
//---------------------------------------------------------------------------
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)updateCurrentPageDisplay {
    
}
@end
