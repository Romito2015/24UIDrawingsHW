//
//  RSViewController.h
//  24UIDrawingsHW
//
//  Created by Roma Chopovenko on 9/29/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSDrawingView;
@class RSTiltedView;
#import "RSFigureRect.h"


@interface RSViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *canvas;


@property (weak, nonatomic) IBOutlet RSDrawingView *drawingView;
@property (weak, nonatomic) IBOutlet RSTiltedView  *tiltedView;

@property (strong, nonatomic) RSFigureRect *brushShape;

@property (weak, nonatomic) IBOutlet UIImageView *brushPreviewCanvas;


@property (weak, nonatomic) IBOutlet UISegmentedControl *brushTypeSelectorOutlet;

@property (weak, nonatomic) IBOutlet UISlider *firstColorOutlet;
@property (weak, nonatomic) IBOutlet UISlider *secondColorOutlet;
@property (weak, nonatomic) IBOutlet UISlider *thirdColorOutlet;




- (IBAction)brushShapePicker:(UISegmentedControl *)sender forEvent:(UIEvent *)event;
- (IBAction)brushSizePicker:(UISlider *)sender;

- (IBAction)brushPropertiesButton:(UIButton *)sender;

- (IBAction)colorSynthesisAction:(UISlider *)sender forEvent:(UIEvent *)event;

@end
