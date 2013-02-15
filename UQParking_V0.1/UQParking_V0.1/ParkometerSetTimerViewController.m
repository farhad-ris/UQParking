//
//  ParkometerSetTimerViewController.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 6/12/12.
//
//

#import "ParkometerSetTimerViewController.h"

@interface ParkometerSetTimerViewController ()

@end

@implementation ParkometerSetTimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
//    - (void)drawRect:(CGRect)rect {
//        [self.parkometerUIView drawRect:rect];
//        
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        CGContextBeginPath(ctx);
//        
//        // Add path
//        CGContextMoveToPoint(ctx, 100.0, 100.0);
//        CGContextAddLineToPoint(ctx, 200.0, 200.0);
//        CGContextAddLineToPoint(ctx, 200.0f, 300.0f);
//        CGContextAddLineToPoint(ctx, 100.0f, 300.0f);
//        CGContextClosePath(ctx);
//        CGContextStrokePath(ctx);
//        
//        //Create circle and fill it in
//        CGContextAddArc(ctx, 200, 100.0, 50.0, 0, 2*M_PI, 0);
//        CGContextSetFillColorWithColor(ctx,
//                                       [[UIColor whiteColor] CGColor]);
//        CGContextFillPath(ctx);
//        
//        CGContextAddArc(ctx, 200, 100.0, 50.0, 0, 2*M_PI, 0);
//        CGContextSetStrokeColorWithColor(ctx, 
//                                         [[UIColor redColor] CGColor]);
//        CGContextStrokePath(ctx);
//    }
@end
