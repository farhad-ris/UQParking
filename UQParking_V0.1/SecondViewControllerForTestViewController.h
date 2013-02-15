//
//  SecondViewControllerForTestViewController.h
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 27/07/12.
//
//

#import <UIKit/UIKit.h>

@interface SecondViewControllerForTestViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *parkingAreaNames;
}

@property (nonatomic, retain) NSArray *parkingAreaNames;

@end
