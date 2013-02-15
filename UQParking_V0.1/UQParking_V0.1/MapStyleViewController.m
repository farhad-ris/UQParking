//
//  MapStyleViewController.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 25/09/12.
//
//

#import "MapStyleViewController.h"
#import <Social/Social.h>
#import "ParkingAreasViewController.h"


@interface MapStyleViewController ()

@end

@implementation MapStyleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** VIEW DID LOAD *****
//
//***************************************************************************
//---------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texturebluebg.png"]];
  //  self.mapStyleSegmentControl.selectedSegmentIndex=
    

    //---------------------------------------------------------------------------
    //***************************************************************************
    //
    //            check which mapStyleSegmentControl to be selected
    //
    //***************************************************************************
    //---------------------------------------------------------------------------
    
    
   // NSString *mapStyle=@"";
    int mapStyle = [[self.parentVC parkingAreasMapView] mapType];
    
    if (mapStyle == 0)  {
        self.mapStyleSegmentControl.selectedSegmentIndex = 0;
    } else if (mapStyle == 1)  {
        self.mapStyleSegmentControl.selectedSegmentIndex = 1;
    } else if (mapStyle == 2)  {
        self.mapStyleSegmentControl.selectedSegmentIndex = 2;
    } 



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** Changing the style of map *****
//
//***************************************************************************
//---------------------------------------------------------------------------

- (IBAction)mapStyleChange:(id)sender {
    
    


        switch (((UISegmentedControl *)sender).selectedSegmentIndex)
        {
            case 0:
            {
                self.mapStyleSegmentControl.selectedSegmentIndex = 0;
                [[self.parentVC parkingAreasMapView] setMapType:MKMapTypeStandard];
                
                [self dismissViewControllerAnimated:YES completion:nil ];

                break;
            }
            case 1:
            {
                    self.mapStyleSegmentControl.selectedSegmentIndex = 1;
                [[self.parentVC parkingAreasMapView] setMapType:MKMapTypeSatellite];
                
                [self dismissViewControllerAnimated:YES completion:nil ];
                

                break;
            }
            default:
            {
                    self.mapStyleSegmentControl.selectedSegmentIndex = 2;
                [[self.parentVC parkingAreasMapView] setMapType:MKMapTypeHybrid];
                
                [self dismissViewControllerAnimated:YES completion:nil ];
                

                break;
            } 
        }
    

    
    
    
    
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** Post On Facebook *****
//
//***************************************************************************
//---------------------------------------------------------------------------


- (IBAction)postOnFacebook:(id)sender {
    
    
    SLComposeViewController *slcvc = [ SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [slcvc setInitialText: @"I just've found a place to park at UQ with UQParking App"];
    
    [self presentViewController: slcvc animated: YES completion: nil];
    
    [slcvc addImage:[UIImage imageNamed:@"parking114.png"]];
    
    
    
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                      ***** Post On Twitter *****
//
//***************************************************************************
//---------------------------------------------------------------------------

- (IBAction)postOnTwitter:(id)sender {
    
    
    SLComposeViewController *slcvc = [ SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [slcvc setInitialText: @"I just've found a place to park at UQ with UQParking App"];
    
    [self presentViewController: slcvc animated: YES completion: nil];
    
    [slcvc addImage:[UIImage imageNamed:@"parking114.png"]];
    

   
    
}
@end
