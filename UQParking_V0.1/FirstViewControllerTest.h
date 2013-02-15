//
//  FirstViewControllerTest.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 1/08/12.
//
//

#import <UIKit/UIKit.h>

@interface FirstViewControllerTest : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *parkingAreasScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *parkingAreasPageControl;

@end
