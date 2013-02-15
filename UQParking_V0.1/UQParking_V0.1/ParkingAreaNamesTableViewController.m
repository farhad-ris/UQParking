//
//  parkingAreaNamesTableView.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 27/07/12.
//
//
#import "UIColor-Expanded.h"
#import "UIColor-Expanded.m"
#import "ParkingAreaNamesTableViewController.h"
#import "ParkingAreasViewController.h"

@interface ParkingAreaNamesTableViewController ()


@end

@implementation ParkingAreaNamesTableViewController
@synthesize planParkingDatePicker = _planParkingDatePicker;
@synthesize parkingAreaNameAndTime;


@synthesize parkingAreasNames= _parkingAreasNames;
@synthesize parkingAreasPhotos= _parkingAreasPhotos;
@synthesize parkingAreasColors= _parkingAreasColors;
@synthesize date=_date;

@synthesize dateString;

@synthesize parkingAndTime;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) viewWillAppear:(BOOL)animated
{
    // Hide the navigation bar while we're at the top level
    
    
    
   
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    NSDate *now = [NSDate date];
    
    

    [_planParkingDatePicker setDate:now animated:YES];
   
    
     [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.backItem.title = @"Plan Parking";
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                          ***** viewDidLoad *****
//
// 
//***************************************************************************
//---------------------------------------------------------------------------
- (void)viewDidLoad
{
  


    //************************************************************************
    //                loading and giving animation to the planParkingDatePicker
    //************************************************************************
    
    NSDate *now = [NSDate date];
    
    [_planParkingDatePicker setDate:now animated:YES];
    dateString = [UqParkingBrain getCurrentTime];
    
    
    
    
    //[self colorOfAllParkingAreaCurrentTime];
    [self colorOfAllParkingAreaBasedOnDatePickerTime:dateString];

[super viewDidLoad];
}






#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    
    
    return [self.parkingAreasNames count]  ;
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                          cellForRowAtIndexPath
//
//                      Show the configuration of cells
//***************************************************************************
//---------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Parking Areas Names";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier ];
    }
    NSLog(@"---------------------");

    
//************************************************************************
//                          Configure the cell...
//************************************************************************
    
    id theParkingAreaName = [ self.parkingAreasNames objectAtIndex:indexPath.row];
    cell.textLabel.text = theParkingAreaName;
    
    id theParkingAreaPhoto = [ self.parkingAreasPhotos objectAtIndex:indexPath.row];
    cell.imageView.image= theParkingAreaPhoto;
    
    id theParkingAreaColor = [self.parkingAreasColors objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor = theParkingAreaColor;
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    NSLog(@"Cell Text is: %@",cellText);
}



//---------------------------------------------------------------------------
//***************************************************************************
//
//                     colorOfAllParkingAreaCurrentTime
//
// giving the current color of the chosen Parking area based on chosen day and time
//***************************************************************************
//---------------------------------------------------------------------------
- (void) colorOfAllParkingAreaCurrentTime {
    
    
    //************************************************************************
    //                checking the color of each parking area
    //************************************************************************
    
    
    
    self.parkingAreasNames = [[NSArray alloc] initWithObjects:
                              @"UQ Centre Parking Station",
                              @"Sir William MacGregor Drive",
                              @"Conifer Knoll Parking L1",
                              @"Conifer Knoll Parking L3",
                              nil];
    
//    self.parkingAreasPhotos = [[NSArray alloc] initWithObjects:
//                               [UIImage imageNamed:@"ParkingArea1.png"],
//                               [UIImage imageNamed:@"ParkingArea2.png"],
//                               [UIImage imageNamed:@"ParkingArea3.png"],
//                               [UIImage imageNamed:@"ParkingArea4.png"],
//                               nil];
    
    NSString *uqCentreColor = [UqParkingBrain colorOfChosenParkingAreaCurrentTime: @"UQ Centre Parking Station"];
    NSString *sirWilliamColor = [UqParkingBrain colorOfChosenParkingAreaCurrentTime: @"Sir William MacGregor Drive"];
    NSString *coniferL1Color = [UqParkingBrain colorOfChosenParkingAreaCurrentTime: @"Conifer Knoll Parking Station L1"];
    NSString *coniferL3Color = [UqParkingBrain colorOfChosenParkingAreaCurrentTime: @"Conifer Knoll Parking Station L3"];
    
    UIColor *uqCentreUIColor = [UIColor redColor];
    UIColor *sirWilliamUIColor = [UIColor redColor];
    UIColor *coniferL1UIColor = [UIColor redColor];
    UIColor *coniferL3UIColor = [UIColor redColor];
    
    
    
    if (uqCentreColor == @"redColor")
    {
        uqCentreUIColor = [UIColor colorWithHexString:@"EE2734"];
    }else if (uqCentreColor == @"greenColor")
    {
        uqCentreUIColor = [UIColor colorWithHexString:@"8DC63F"];
    }else if (uqCentreColor == @"yellowColor")
    {
        uqCentreUIColor = [UIColor colorWithHexString:@"ECBF25"];
    }else if (uqCentreColor == @"orangeColor")
    {
        uqCentreUIColor = [UIColor orangeColor];
    }
    
    
    
    if (sirWilliamColor == @"redColor")
    {
        sirWilliamUIColor = [UIColor colorWithHexString:@"EE2734"];
    }else if (sirWilliamColor == @"greenColor")
    {
        sirWilliamUIColor = [UIColor colorWithHexString:@"8DC63F"];
    }else if (sirWilliamColor == @"yellowColor")
    {
        sirWilliamUIColor = [UIColor colorWithHexString:@"ECBF25"];
    }else if (sirWilliamColor == @"orangeColor")
    {
        sirWilliamUIColor = [UIColor orangeColor];
    }
    
    
    if (coniferL1Color == @"redColor")
    {
        coniferL1UIColor = [UIColor colorWithHexString:@"EE2734"];
    }else if (coniferL1Color == @"greenColor")
    {
        coniferL1UIColor = [UIColor colorWithHexString:@"8DC63F"];
    }else if (coniferL1Color == @"yellowColor")
    {
        coniferL1UIColor = [UIColor colorWithHexString:@"ECBF25"];
    }else if (coniferL1Color == @"orangeColor")
    {
        coniferL1UIColor = [UIColor orangeColor];
    }
    
    
    if (coniferL3Color == @"redColor")
    {
        coniferL3UIColor = [UIColor colorWithHexString:@"EE2734"];
    }else if (coniferL3Color == @"greenColor")
    {
        coniferL3UIColor = [UIColor colorWithHexString:@"8DC63F"];
    }else if (coniferL3Color == @"yellowColor")
    {
        coniferL3UIColor = [UIColor colorWithHexString:@"ECBF25"];
    }else if (coniferL3Color == @"orangeColor")
    {
        coniferL3UIColor = [UIColor orangeColor];
    }
    //  parkingAreaColor = [UqParkingBrain colorOfChosenParkingAreaCurrentTime: parkingAreaName ];
    
    self.parkingAreasColors = [[NSArray alloc] initWithObjects:
                               uqCentreUIColor,
                               sirWilliamUIColor,
                               coniferL1UIColor,
                               coniferL3UIColor,
                               nil];
    
    
    
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                 colorOfAllParkingAreaBasedOnDatePickerTime
//
// giving the current color of the chosen Parking area based on chosen time
//***************************************************************************
//---------------------------------------------------------------------------

- (void) colorOfAllParkingAreaBasedOnDatePickerTime: (NSString *) stringTime {
    
    
    
    //************************************************************************
    //                checking the color of each parking area
    //************************************************************************
    
    
    
    self.parkingAreasNames = [[NSArray alloc] initWithObjects:
                              @"UQ Centre Parking Station",
                              @"Sir William MacGregor Drive",
                              @"Conifer Knoll Parking L1",
                              @"Conifer Knoll Parking L3",
                              nil];
//    
//    self.parkingAreasPhotos = [[NSArray alloc] initWithObjects:
//                               [UIImage imageNamed:@"ParkingArea1.png"],
//                               [UIImage imageNamed:@"ParkingArea2.png"],
//                               [UIImage imageNamed:@"ParkingArea3.png"],
//                               [UIImage imageNamed:@"ParkingArea4.png"],
//                               nil];
    
    NSString *uqCentreColor = [UqParkingBrain colorOfChosenParkingArea:@"UQ Centre Parking Station" BasedOnChosenTime:stringTime];
    NSString *sirWilliamColor = [UqParkingBrain colorOfChosenParkingArea: @"Sir William MacGregor Drive" BasedOnChosenTime:stringTime];
    NSString *coniferL1Color = [UqParkingBrain colorOfChosenParkingArea: @"Conifer Knoll Parking Station L1" BasedOnChosenTime:stringTime];
    NSString *coniferL3Color = [UqParkingBrain colorOfChosenParkingArea: @"Conifer Knoll Parking Station L3" BasedOnChosenTime:stringTime];
    
    UIColor *uqCentreUIColor = [UIColor redColor];
    UIColor *sirWilliamUIColor = [UIColor redColor];
    UIColor *coniferL1UIColor = [UIColor redColor];
    UIColor *coniferL3UIColor = [UIColor redColor];
    

    
    if (uqCentreColor == @"redColor")
    {
        uqCentreUIColor = [UIColor colorWithHexString:@"EE2734"];
    }else if (uqCentreColor == @"greenColor")
    {
        uqCentreUIColor = [UIColor colorWithHexString:@"8DC63F"];
    }else if (uqCentreColor == @"yellowColor")
    {
        uqCentreUIColor = [UIColor colorWithHexString:@"ECBF25"];
    }else if (uqCentreColor == @"orangeColor")
    {
        uqCentreUIColor = [UIColor orangeColor];
    }
    
    
    
    if (sirWilliamColor == @"redColor")
    {
        sirWilliamUIColor = [UIColor colorWithHexString:@"EE2734"];
    }else if (sirWilliamColor == @"greenColor")
    {
        sirWilliamUIColor = [UIColor colorWithHexString:@"8DC63F"];
    }else if (sirWilliamColor == @"yellowColor")
    {
        sirWilliamUIColor = [UIColor colorWithHexString:@"ECBF25"];
    }else if (sirWilliamColor == @"orangeColor")
    {
        sirWilliamUIColor = [UIColor orangeColor];
    }
    
    
    if (coniferL1Color == @"redColor")
    {
        coniferL1UIColor = [UIColor colorWithHexString:@"EE2734"];
    }else if (coniferL1Color == @"greenColor")
    {
        coniferL1UIColor = [UIColor colorWithHexString:@"8DC63F"];
    }else if (coniferL1Color == @"yellowColor")
    {
        coniferL1UIColor = [UIColor colorWithHexString:@"ECBF25"];
    }else if (coniferL1Color == @"orangeColor")
    {
        coniferL1UIColor = [UIColor orangeColor];
    }
    
    
    if (coniferL3Color == @"redColor")
    {
        coniferL3UIColor = [UIColor colorWithHexString:@"EE2734"];
    }else if (coniferL3Color == @"greenColor")
    {
        coniferL3UIColor = [UIColor colorWithHexString:@"8DC63F"];
    }else if (coniferL3Color == @"yellowColor")
    {
        coniferL3UIColor = [UIColor colorWithHexString:@"ECBF25"];
    }else if (coniferL3Color == @"orangeColor")
    {
        coniferL3UIColor = [UIColor orangeColor];
    }
    //  parkingAreaColor = [UqParkingBrain colorOfChosenParkingAreaCurrentTime: parkingAreaName ];
    
    self.parkingAreasColors = [[NSArray alloc] initWithObjects:
                               uqCentreUIColor,
                               sirWilliamUIColor,
                               coniferL1UIColor,
                               coniferL3UIColor,
                               nil];
    NSLog(uqCentreColor,sirWilliamColor,coniferL1Color,coniferL3Color);
 
    
}



//---------------------------------------------------------------------------
//***************************************************************************
//
//                 planParkingDatePickerValueChange
//
//              @@@@@@ Changing the datepicker value @@@@@@
//***************************************************************************
//---------------------------------------------------------------------------
- (IBAction)planParkingDatePickerValueChange:(id)sender {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"]; //24hr time format
    dateString = [outputFormatter stringFromDate:self.planParkingDatePicker.date];
    
    NSLog(@"%@",dateString);
    
    [self colorOfAllParkingAreaBasedOnDatePickerTime:dateString];
    
//    NSDate *selected = _planParkingDatePicker.date;
//    
//    NSString *message = [[NSString alloc] initWithFormat:@"DATE AND TIME IS: %@", selected];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SELECTED DATE AND TIME" message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//    
//    [alert show];
    
    
    [self.tableView reloadData];
}


//---------------------------------------------------------------------------
//***************************************************************************
//
//                          prepareForSegue
//
//            preparing a sender for the secondControllerToParkingAreasSegue
//***************************************************************************
//---------------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"secondControllerToParkingAreasSegue"]) {
        ParkingAreas *parkingAreaViewController = [segue destinationViewController];
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:path];
        NSString *cellText = selectedCell.textLabel.text;
        NSLog(@"cellText name BEFORE refinement '%@'",cellText);
      
        if ( [cellText isEqual:@"UQ Centre Parking Station"]){
            cellText= @"UQ Centre Parking Station";
            
        }else if ([cellText isEqual: @"Sir William MacGregor Drive"]){
            cellText= @"Sir William MacGregor Drive";
            
        } else if ([cellText isEqual: @"Conifer Knoll Parking L1"])
        {
            cellText= @"Conifer Knoll Parking Station L1";
           
        }
        else if ([cellText isEqual: @"Conifer Knoll Parking L3"])
        {
            cellText = @"Conifer Knoll Parking Station L3";
            
        }
        
        parkingAndTime = [NSArray arrayWithObjects:cellText,dateString, nil];
        
        NSLog(@"cellText name AFTER refinement %@",cellText);
        parkingAreaViewController.parkingAreaNameAndTime = parkingAndTime;
        NSLog(@"%@",parkingAreaViewController.parkingAreaNameAndTime);
        
//        // Assume self.view is the table view
        
//        NSString *selectedParkingAreaName = [self.tableView.]
//        DetailObject *detail = [self detailForIndexPath:path];
//        [segue.destinationViewController setDetail:detail];
    }

}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                          showSelectedParkingArea
//
//        Sending a sender to the secondControllerToParkingAreasSegue
//***************************************************************************
//---------------------------------------------------------------------------

-(void) showSelectedParkingArea:(id)sender
{
    NSLog(@"Show the selected parking area");
    
    [self performSegueWithIdentifier:@"secondControllerToParkingAreasSegue" sender:self];
    
    
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                              viewDidUnload
//
// 
//***************************************************************************
//---------------------------------------------------------------------------
- (void)viewDidUnload
{
    [self setPlanParkingDatePicker:nil];
    [self setPlanParkingDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

@end
