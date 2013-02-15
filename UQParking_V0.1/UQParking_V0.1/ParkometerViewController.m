//
//  ParkometerViewController.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 27/11/12.
//
//

#import "ParkometerViewController.h"
#import "XYPieChart.h"


@interface ParkometerViewController ()

@end

@implementation ParkometerViewController


@synthesize parkometerPieChartView;
@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;



//---------------------------------------------------------------------------
//***************************************************************************
//
//                              viewDidAppear
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
{
//    [self.parkometerPieChartView reloadData];

    //self.view.backgroundColor = [UIColor colorWithHexString:@"204494"];
  
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                              viewWillAppear
//
//***************************************************************************
//---------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    // Show the navigation bar when view appears
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
   
    
}

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
	// Do any additional setup after loading the view.
    self.tabBarController.hidesBottomBarWhenPushed= YES ;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    
    
    self.slices = [NSMutableArray arrayWithCapacity:10];
    
    for(int i = 0; i < 5; i ++)
    {
        NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
        [_slices addObject:one];
    }
    
    
    [self.parkometerPieChartView setDelegate:self];
    [self.parkometerPieChartView setDataSource:self];
    [self.parkometerPieChartView setPieCenter:CGPointMake(160, 160)];
    [self.parkometerPieChartView setShowPercentage:NO];
    [self.parkometerPieChartView setLabelColor:[UIColor blackColor]];
    
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    [self.parkometerPieChartView reloadData];
    
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


//---------------------------------------------------------------------------
//***************************************************************************
//
//                              initWithNibName bundle
//
//***************************************************************************
//---------------------------------------------------------------------------
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
//                              numberOfSlicesInPieChart 
//
//***************************************************************************
//---------------------------------------------------------------------------
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart{
    
    return 3;
}
//---------------------------------------------------------------------------
//***************************************************************************
//
//                              pieChart valueForSliceAtIndex
//
//***************************************************************************
//---------------------------------------------------------------------------
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index{
    
    return 5;
    
}



//---------------------------------------------------------------------------
//***************************************************************************
//
//                              clearSlices
//
//***************************************************************************
//---------------------------------------------------------------------------
- (IBAction)clearSlices {
    [_slices removeAllObjects];
    [self.parkometerPieChartView reloadData];
}

@end
