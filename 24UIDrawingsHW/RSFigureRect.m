//
//  RSFigureRect.m
//  24UIDrawingsHW
//
//  Created by Roma Chopovenko on 10/6/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import "RSFigureRect.h"

@implementation RSFigureRect

- (instancetype)init
{
    self = [super init];
    if (self) {
        // setting default properties of figure
        
        self.figureType = RSFigureTypeCircle;
        self.figureColor = [UIColor grayColor];
        self.figureRadius = 30.f;
        self.numberOfAngles = 5;
    }
    return self;
}

+ (void) drawFigureAtPoint:(CGPoint)point
                withObject:(RSFigureRect *)brush
          inContextOfImage:(UIImageView *)canvas {
  
    UIGraphicsBeginImageContext(canvas.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [canvas.image drawInRect:CGRectMake(0, 0, canvas.frame.size.width, canvas.frame.size.height)];
    CGFloat radius = brush.figureRadius;
    CGPoint origin = CGPointMake(point.x - radius, point.y - radius);
    CGRect rect = CGRectMake(origin.x, origin.y, radius*2, radius*2);
    
    if (brush.figureType == RSFigureTypeRectangle) {
        
        CGContextAddRect(context, rect);
        
    } else if (brush.figureType == RSFigureTypeCircle) {
        
        CGContextAddEllipseInRect(context, rect);
        
    } else if (brush.figureType == RSFigureTypePolygon || brush.figureType == RSFigureTypeStar) {
        
        [brush createStarPointsInContext:context withCenter:point forBrushObject:brush];
    }
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetFillColorWithColor(context, brush.figureColor.CGColor);
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    CGContextFillPath(context);
    
    canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    [canvas setAlpha:1.f];
    UIGraphicsEndImageContext();
    
}

- (void) createStarPointsInContext:(CGContextRef)context
                        withCenter:(CGPoint)center
                    forBrushObject:(RSFigureRect *)brush{
    
    self.allStarPoints   = [NSMutableArray array];
    self.outerStarPoints = [NSMutableArray array];
    self.innerStarPoints = [NSMutableArray array];
    
    CGFloat moveAngle = 2.f * M_PI / brush.numberOfAngles;
    CGFloat angleOfPoint = M_PI_2;
    CGFloat angleOfInnerPoint = angleOfPoint + (moveAngle / 2);
    
    for (int i = 0; i < brush.numberOfAngles; i++) {
        // outer points
        angleOfPoint += moveAngle;
        
        CGPoint outerPoint = CGPointMake(center.x - (brush.figureRadius * cosf(angleOfPoint)),
                                         center.y - (brush.figureRadius * sinf(angleOfPoint)));
        
        CGContextMoveToPoint(context, outerPoint.x, outerPoint.y);
        
        [self.allStarPoints addObject:[NSValue valueWithCGPoint:outerPoint]];
        [self.outerStarPoints addObject:[NSValue valueWithCGPoint:outerPoint]];
        
        
        // inner points
        CGFloat innerRadius = 0.4f * brush.figureRadius;
        angleOfInnerPoint += moveAngle;
        
        CGPoint innerPoint = CGPointMake(center.x - (innerRadius * cosf(angleOfInnerPoint)),
                                         center.y - (innerRadius * sinf(angleOfInnerPoint)));
        
        [self.allStarPoints addObject:[NSValue valueWithCGPoint:innerPoint]];
        [self.innerStarPoints addObject:[NSValue valueWithCGPoint:innerPoint]];
        
        
    }
    
    if (brush.figureType == RSFigureTypePolygon) {
        
        [brush connectPoints:brush.outerStarPoints inContext:context];
        
    } else if (brush.figureType == RSFigureTypeStar) {
        
        [brush connectPoints:brush.allStarPoints inContext:context];
    }
}

- (void) connectPoints:(NSMutableArray *)points inContext:(CGContextRef)context {
    
    for (int i = 0; i < points.count; i++) {
        
        CGPoint point = [[points objectAtIndex:i] CGPointValue];
        
        if (i == 0) {
            
            CGContextMoveToPoint(context, point.x, point.y);
        }
        
        CGContextAddLineToPoint(context, point.x, point.y);
        
        if (i == points.count-1) {
            
            CGPoint point = [[points firstObject] CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
        }
    }
}



@end
