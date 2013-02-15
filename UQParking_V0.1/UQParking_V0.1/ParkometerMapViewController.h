//
//  ParkometerMapViewController.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 27/11/12.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>


@interface ParkometerMapViewController : UIViewController  <MKMapViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *parkometerMapView;
@property (strong) NSMutableArray* annotations;

@property (weak) IBOutlet UITextField *textField;
@property (weak) IBOutlet UIButton *timeButton;
@property (weak) IBOutlet UIButton *helpButton;

@property (strong) UITextField *activeField;
@property (assign) BOOL keyboardShown;
@property (assign) BOOL viewMoved;

@property (assign) BOOL setLocation;

@end
