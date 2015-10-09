//
//  RSDrawingView.h
//  24UIDrawingsHW
//
//  Created by Roma Chopovenko on 9/29/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSFigureRect.h"
#import "RSViewController.h"

@interface RSDrawingView : UIView


@property (strong, nonatomic) RSViewController *controllerView;





@property (strong, nonatomic) NSMutableArray *allStarPoints;
@property (strong, nonatomic) NSMutableArray *outerStarPoints;
@property (strong, nonatomic) NSMutableArray *innerStarPoints;

@property (strong, nonatomic) NSMutableArray *panCoordinates;

- (void)drawStarInContext:(CGContextRef)context
       withNumberOfPoints:(NSInteger)points
                   center:(CGPoint)center
              innerRadius:(CGFloat)innerRadius
              outerRadius:(CGFloat)outerRadius
              strokeWidth:(CGFloat)strokeWidth ;

@end
