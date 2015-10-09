//
//  RSDrawingView.m
//  24UIDrawingsHW
//
//  Created by Roma Chopovenko on 9/29/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import "RSDrawingView.h"


@interface RSDrawingView()





@end
@implementation RSDrawingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.controllerView = [[RSViewController alloc] init];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    self.panCoordinates = [NSMutableArray array];
    
    
    
    
    [self drawStarInContext:context withNumberOfPoints:5
                                 center:CGPointMake(400, 400)
                            innerRadius:100.f
                            outerRadius:200.f
                            strokeWidth:2.f];
    
    [self connectPoints:self.outerStarPoints inContext:context fillWithColor:[UIColor yellowColor]];
    [self connectPoints:self.allStarPoints inContext:context fillWithColor:[UIColor redColor]];
    [self connectPointsWithSkip:self.innerStarPoints inContext:context withStrokeColor:[UIColor yellowColor]];
    
    
}

- (void)drawStarInContext:(CGContextRef)context
       withNumberOfPoints:(NSInteger)points
                   center:(CGPoint)center
              innerRadius:(CGFloat)innerRadius
              outerRadius:(CGFloat)outerRadius
              strokeWidth:(CGFloat)strokeWidth {
    
    self.allStarPoints   = [NSMutableArray array];
    self.outerStarPoints = [NSMutableArray array];
    self.innerStarPoints = [NSMutableArray array];
    
    CGFloat moveAngle = 2.f * M_PI / points;
    CGFloat angleOfPoint = M_PI_2;
    CGFloat angleOfInnerPoint = angleOfPoint + (moveAngle / 2);
    
    CGRect centerRect = CGRectMake(center.x - 5.f, center.y - 5.f, 10.f, 10.f);
    CGContextAddEllipseInRect(context, centerRect);
    

    for (int i = 0; i < points; i++) {
        // outer points
        angleOfPoint += moveAngle;
        
        CGPoint outerPoint = CGPointMake(center.x - (outerRadius * cosf(angleOfPoint)),
                                 center.y - (outerRadius * sinf(angleOfPoint)));
        
        CGContextMoveToPoint(context, outerPoint.x, outerPoint.y);
        
        CGRect smallRect = CGRectMake(outerPoint.x - 5.f, outerPoint.y - 5.f, 10.f, 10.f);
        CGContextAddEllipseInRect(context, smallRect);
        
        [self.allStarPoints addObject:[NSValue valueWithCGPoint:outerPoint]];
        [self.outerStarPoints addObject:[NSValue valueWithCGPoint:outerPoint]];
        
        
        // inner points
        angleOfInnerPoint += moveAngle;
        
        CGPoint innerPoint = CGPointMake(center.x - (innerRadius * cosf(angleOfInnerPoint)),
                                         center.y - (innerRadius * sinf(angleOfInnerPoint)));
        CGRect smallInnerRect = CGRectMake(innerPoint.x - 5.f, innerPoint.y - 5.f, 10.f, 10.f);
        CGContextAddEllipseInRect(context, smallInnerRect);
        
        [self.allStarPoints addObject:[NSValue valueWithCGPoint:innerPoint]];
        [self.innerStarPoints addObject:[NSValue valueWithCGPoint:innerPoint]];
        
        
    }
    
    
    
   
    CGContextStrokePath(context);

}

- (void) connectPoints:(NSMutableArray *)points inContext:(CGContextRef)context fillWithColor:(UIColor *)fill{
    
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
    [fill setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void) connectPointsWithSkip:(NSMutableArray *)points inContext:(CGContextRef)context withStrokeColor:(UIColor *)strokeColor{
    
    
    int cornersNumber = points.count;
    int skip = (cornersNumber - 1) / 2;
    CGPoint firstPoint = [[points firstObject] CGPointValue];
    int counter = 0;
    
    for (int i = 0; i < cornersNumber; ) {
        
        counter++;
        
        if (i == 0 && counter == 1) {
            
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
        }
        
        i = (i + skip) % cornersNumber;
        CGPoint point = [[points objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
        
        if (i == 0) {
            
            i = cornersNumber;
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
        }
    }
   
    [strokeColor setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}



@end
