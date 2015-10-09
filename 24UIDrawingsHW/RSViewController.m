//
//  RSViewController.m
//  24UIDrawingsHW
//
//  Created by Roma Chopovenko on 9/29/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import "RSViewController.h"
#import "RSDrawingView.h"
#import "RSTiltedView.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface RSViewController ()

@property (assign, nonatomic) BOOL tiltActive;
@property (assign, nonatomic) CGPoint touchPoint;


@end

@implementation RSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    RSFigureRect *brush = [[RSFigureRect alloc] init];
    
    self.brushShape = brush;
}

#pragma mark - Orientation

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [self.drawingView setNeedsDisplay];
}

# pragma mark - UITouch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch  = [touches anyObject];
    self.touchPoint = [touch locationInView:self.canvas];
    
    [RSFigureRect drawFigureAtPoint:self.touchPoint
                         withObject:self.brushShape
                   inContextOfImage:self.canvas];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.canvas];
    
    [RSFigureRect drawFigureAtPoint:currentPoint
                         withObject:self.brushShape
                   inContextOfImage:self.canvas];
    
    self.touchPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark Actions

- (IBAction)brushShapePicker:(UISegmentedControl *)sender forEvent:(UIEvent *)event {
    
    self.brushShape.figureType = sender.selectedSegmentIndex;
    
    [self refreshPreviewCanvas];
}

- (IBAction)brushSizePicker:(UISlider*)sender {
    
    self.brushShape.figureRadius = sender.value / 2;
    
    [self refreshPreviewCanvas];
}

- (IBAction)brushPropertiesButton:(UIButton *)sender{
    
    //self.drawingView.canvas.image = nil;
    
    CGAffineTransform currentTransform = self.tiltedView.transform;
    
    CGFloat angle;
    
    if (!self.tiltActive) {
        
        [self refreshPreviewCanvas];
        
        angle = DEGREES_TO_RADIANS(-23);
        self.tiltActive = YES;
        
    } else {
        
        angle = DEGREES_TO_RADIANS(+23);
        self.tiltActive = NO;
    }
    
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, angle);
    
    [UIView animateWithDuration:0.3f
                          delay:0.f
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.tiltedView.transform = newTransform;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (IBAction)colorSynthesisAction:(UISlider *)sender forEvent:(UIEvent *)event {
    
    [self refreshColor];
    [self refreshPreviewCanvas];
}

#pragma mark - helpMethods

- (void)refreshColor {
    
    self.brushShape.figureColor = [UIColor colorWithRed:self.firstColorOutlet.value
                                                  green:self.secondColorOutlet.value
                                                   blue:self.thirdColorOutlet.value
                                                  alpha:self.opacityOutlet.value];
}

- (void) refreshPreviewCanvas {

    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.brushPreviewCanvas.bounds),
                                      CGRectGetMidY(self.brushPreviewCanvas.bounds));
    
    self.brushPreviewCanvas.image = nil;
    
    [RSFigureRect drawFigureAtPoint:centerPoint
                         withObject:self.brushShape
                   inContextOfImage:self.brushPreviewCanvas];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
