//
//  ParkometerTimerViewController.m
//  UQParking_V0.1
//
//  Created by Farhad Rismanchian on 6/12/12.
//
//

#import "ParkometerTimerView.h"
#define greenSize  60
#define redSize 40


@implementation ParkometerTimerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void) touchesMoved:(NSSet *)touches
            withEvent:(UIEvent *)event {
    
    NSLog( @"%@",touches.observationInfo);
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.window];
    
    CGFloat pointX = point.x;
    CGFloat pointY = point.y;
    
    double rectangularCoordinate = sqrt ( (pointX * pointX) + (pointY * pointY) );
    
    NSLog(@"Rectangular Coordinate is :  %f", rectangularCoordinate);
    NSLog(@" You are touching at the coordination of:  %f X and  %f Y", pointX,pointY);
    
    NSUInteger touchCount = [touches count];
    NSUInteger tapCount = [[touches anyObject] tapCount];
    NSLog(@"Touch count is =  %d And  Tap count is =  %d  ", touchCount,tapCount);
}

//---------------------------------------------------------------------------
//***************************************************************************
//
//                              drawRect
//
//
//***************************************************************************
//---------------------------------------------------------------------------

- (void)drawRect:(CGRect)rect {

    double rectCoordinate = sqrt( ((self.frame.size.height/2) * (self.frame.size.height/2))+
                                  ((self.frame.size.width/2) * (self.frame.size.width/2)) );
    
    
    NSLog(@"Rectangular Coordinate is: %f", rectCoordinate);
//----------------------------------------------------------------------------
//                                RedCircle
//----------------------------------------------------------------------------
    
    CGContextRef redCircle = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(redCircle, redSize);
    CGContextSetStrokeColorWithColor(redCircle,
                                     [UIColor redColor].CGColor);
    
    
    CGRect redCircleRectangle = CGRectMake(self.frame.origin.x + (redSize/2),
                                           self.frame.origin.y + (redSize/2),
                                           self.frame.size.width - redSize,
                                           self.frame.size.height - redSize);
    CGContextAddEllipseInRect(redCircle, redCircleRectangle);
    CGContextStrokePath(redCircle);
    
    
    
//----------------------------------------------------------------------------
//                                greenCircle
//----------------------------------------------------------------------------
    CGContextRef greenCircle = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(greenCircle, greenSize);
    CGContextSetStrokeColorWithColor(greenCircle,
                                     [UIColor greenColor].CGColor);
    
    
    CGRect greenCircleRectangle = CGRectMake(self.frame.origin.x + (greenSize/2),
                                             self.frame.origin.y + (greenSize/2),
                                             self.frame.size.width - greenSize ,
                                             self.frame.size.height - greenSize);
    CGContextAddEllipseInRect(greenCircle, greenCircleRectangle);
    CGContextStrokePath(greenCircle);
    
//----------------------------------------------------------------------------
//                                Minutes
//----------------------------------------------------------------------------
    CGContextRef minutes = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(minutes, 20.0);
    CGContextSetStrokeColorWithColor(minutes,
                                     [UIColor whiteColor].CGColor);
    
    CGFloat dashArray[] = {6,9,2};
    CGContextSetLineDash(minutes, 3, dashArray, 4);
    
    CGRect minuteRectangle = CGRectMake(self.frame.origin.x +10 ,
                                        self.frame.origin.y +10 ,
                                        self.frame.size.width-20,
                                        self.frame.size.height-20);

    
    CGContextAddEllipseInRect(minutes, minuteRectangle);
    CGContextStrokePath(minutes);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
