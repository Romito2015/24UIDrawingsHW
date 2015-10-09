//
//  RSFigureRect.h
//  24UIDrawingsHW
//
//  Created by Roma Chopovenko on 10/6/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    RSFigureTypeCircle    = 0,
    RSFigureTypeRectangle = 1,
    RSFigureTypePolygon   = 2,
    RSFigureTypeStar      = 3
} RSFigureType;

@interface RSFigureRect : NSObject

@property (assign, nonatomic) RSFigureType figureType;
@property (assign, nonatomic) CGFloat figureRadius;
@property (assign, nonatomic) UIColor *figureColor;
@property (assign, nonatomic) CGContextRef context;
@property (assign, nonatomic) CGRect mainRect;
@property (assign, nonatomic) NSInteger numberOfAngles;



@property (strong, nonatomic) NSMutableArray *allStarPoints;
@property (strong, nonatomic) NSMutableArray *outerStarPoints;
@property (strong, nonatomic) NSMutableArray *innerStarPoints;

+ (void) drawFigureAtPoint:(CGPoint)point withObject:(RSFigureRect *)brush inContextOfImage:(UIImageView *)canvas;

- (void) createStarPointsInContext:(CGContextRef)context withCenter:(CGPoint)center forBrushObject:(RSFigureRect *)brush;





@end
