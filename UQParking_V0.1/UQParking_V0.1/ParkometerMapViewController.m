//
//  ParkometerMapViewController.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 27/11/12.
//
//

#import "ParkometerMapViewController.h"
#import <MapKit/Mapkit.h>
#import <UIKit/UIKit.h>
#import "MapAnnotations.h"

#define StLucia_LAT -27.4955
#define StLucia_LONG 153.015454


@interface ParkometerMapViewController ()

@end

@implementation ParkometerMapViewController

@synthesize annotations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    // Show the navigation bar when view appears
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.hidesBottomBarWhenPushed= YES ;
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                              viewDidUnload
//
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)viewDidLoad
{
    self.setLocation = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    self.parkometerMapView.showsUserLocation=YES;
//    self.hidesBottomBarWhenPushed = YES;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    _parkometerMapView = [[MKMapView alloc]
//               initWithFrame:CGRectMake(0,
//                                        0,
//                                        self.view.bounds.size.width,
//                                        self.view.bounds.size.height)
//               ];
    _parkometerMapView.showsUserLocation = YES;
    _parkometerMapView.mapType = MKMapTypeHybrid;
    _parkometerMapView.delegate = self;
//    [self.view addSubview:_parkometerMapView];
//    [self.view bringSubviewToFront:self.timeButton];
//    [self.view bringSubviewToFront:self.textField];
//    [self.view bringSubviewToFront:self.helpButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    										 selector:@selector(keyboardWasShown:)
    											 name:UIKeyboardDidShowNotification
    										   object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    										 selector:@selector(keyboardWasHidden:)
    											 name:UIKeyboardDidHideNotification
    										   object:nil];

}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                      Mapview did update user location
//
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    if(!self.setLocation) {
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        CLLocationCoordinate2D location;
        location.latitude = aUserLocation.coordinate.latitude;
        location.longitude = aUserLocation.coordinate.longitude;
        region.span = span;
        region.center = location;
        [aMapView setRegion:region animated:YES];
        [self loadParkingAnnotations:&location];
        self.setLocation = YES;
        self.parkometerMapView.userLocation.title = @"";
    }
}





//---------------------------------------------------------------------------
//***************************************************************************
//
//                  MKAnnotationView for showing the created Annotations
//
//***************************************************************************
//---------------------------------------------------------------------------

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    
    
    
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MapAnnotations class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[mapView
                                                                 dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (!pinView)
        {
            //            *** If an existing pin view was not available, create one ***
            
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomPinAnnotation"]
            ;
            pinView.pinColor = MKPinAnnotationColorPurple;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.draggable = YES;
            
            
            
            //            *** Add image at the left side ***
            UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parking.png"]];
            pinView.leftCalloutAccessoryView = profileIconView;
            //            pinView.rightCalloutAccessoryView = UIButtonTypeInfoLight;
            
            //             *** Add button at the right side ***
//            UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            pinView.rightCalloutAccessoryView = infoButton;
            
        }
        else
            pinView.annotation = annotation;
        
        return pinView;
    }
    
    return nil;
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                      mapview didAddAnnotationViews
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    for (id annot in mapView.annotations) {
        [mapView selectAnnotation:annot animated:FALSE];
    }
    
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                  Creating and Loading the Annotations
//
//***************************************************************************
//---------------------------------------------------------------------------

-(void)loadParkingAnnotations: (CLLocationCoordinate2D *) parkingCoordination{
    NSLog(@"load Parking Annotation");
    
    
    
    annotations =[[NSMutableArray alloc] init];
    
    CLLocationCoordinate2D theCoordinate=*parkingCoordination;
//    theCoordinate.latitude = StLucia_LAT;
//    theCoordinate.longitude = StLucia_LONG;
    
    MapAnnotations* myAnnotation=[[MapAnnotations alloc] init];
    
    myAnnotation.coordinate=theCoordinate;
    myAnnotation.title=@"Your car is parked here";
//    myAnnotation.subtitle=@"Full Day Parking";
    
    [self.parkometerMapView addAnnotation:myAnnotation];
    [annotations addObject:myAnnotation];
    
    
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                          textFieldDidBeginEditing
//
//***************************************************************************
//---------------------------------------------------------------------------

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"A");
    self.activeField = textField;
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                          textFieldDidEndEditing
//
//***************************************************************************
//---------------------------------------------------------------------------

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"B");
    self.activeField = nil;
    // Additional Code
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                          textFieldShouldReturn
//
//***************************************************************************
//---------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSLog(@"%@",self.textField.text);
    return NO;
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                          keyboardWasShown
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)keyboardWasShown:(NSNotification *)aNotification {
    NSLog(@"C");
    if ( self.keyboardShown )
    	return;
    
    //if ( ( self.activeField != self.textField ) ) {
        
        CGRect _keyboardEndFrame;
        [[aNotification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&_keyboardEndFrame];
    
//        CGFloat _keyboardHeight = ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) ? _keyboardEndFrame.size.height : _keyboardEndFrame.size.width;
    
    CGFloat _keyboardHeight = (_keyboardEndFrame.size.height);
    
    	//NSDictionary *info = [aNotification userInfo];
    	//NSValue *aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    	//CGSize keyboardSize = [aValue CGRectValue].size;
        
    	NSTimeInterval animationDuration = 0.300000011920929;
    	CGRect frame = self.view.frame;
        int oldY = frame.origin.y;
    	frame.origin.y -= _keyboardHeight-44;
        int newY = frame.origin.y;
        int deltaY = oldY-newY;
    	frame.size.height += _keyboardHeight-44;
    
    CGRect textFieldFrame = self.textField.frame;
    textFieldFrame.origin.y += deltaY - _keyboardHeight+60;
    textFieldFrame.size.height += 44;
  
    
        NSLog(@"XX CHANGING TO %f",_keyboardHeight);
    NSLog(@"Delta Y %d",deltaY);
    	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    	[UIView setAnimationDuration:animationDuration];
    	self.view.frame = frame;
    self.textField.frame = textFieldFrame;
    	[UIView commitAnimations];
        
    	self.viewMoved = YES;
    //}
    
    self.keyboardShown = YES;
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                          keyboardWasHidden
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)keyboardWasHidden:(NSNotification *)aNotification {
    NSLog(@"D");
    if ( self.viewMoved ) {
    	//NSDictionary *info = [aNotification userInfo];
    	//NSValue *aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    	//CGSize keyboardSize = [aValue CGRectValue].size;
        
        CGRect _keyboardEndFrame;
        [[aNotification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&_keyboardEndFrame];
        
//        CGFloat _keyboardHeight = ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) ? _keyboardEndFrame.size.height : _keyboardEndFrame.size.width;
        
        CGFloat _keyboardHeight = (_keyboardEndFrame.size.height);

        
    	NSTimeInterval animationDuration = 0.300000011920929;
    	CGRect frame = self.view.frame;
        NSLog(@"CHANGING TO %f",_keyboardHeight);
        int oldY = frame.origin.y;

    	frame.origin.y += _keyboardHeight-44;
        
        int newY = frame.origin.y;
        int deltaY = newY-oldY;
        
    	frame.size.height -= _keyboardHeight-44;
        NSLog(@"Delta Y %d",deltaY);

        CGRect textFieldFrame = self.textField.frame;
        textFieldFrame.origin.y += deltaY - _keyboardHeight+60;
        
        textFieldFrame.size.height -= 44;
        NSLog(@"Text field frame orgin Y%f",textFieldFrame.origin.y);

        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    	[UIView setAnimationDuration:animationDuration];
        self.textField.frame = textFieldFrame;
        
    	[UIView commitAnimations];
        
    	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    	[UIView setAnimationDuration:animationDuration];
    	self.view.frame = frame;
        
        
    	[UIView commitAnimations];
        textFieldFrame.origin.y += deltaY - _keyboardHeight+12;
        self.textField.frame = textFieldFrame;
        [UIView commitAnimations];
        
    	self.viewMoved = NO;
    }
    
    self.keyboardShown = NO;
}





//---------------------------------------------------------------------------
//***************************************************************************
//
//        mapView annotationView view didChangeDragState fromOldState
//
//          for getting the new coordination of dragable annotations
//***************************************************************************
//---------------------------------------------------------------------------
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:
(MKAnnotationViewDragState)oldState
{
    CLLocationCoordinate2D currentCoordinates = view.annotation.coordinate;
    NSLog(@"%f Latitude %f L", currentCoordinates.latitude);
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                              didReceiveMemoryWarning
//
//***************************************************************************
//---------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
