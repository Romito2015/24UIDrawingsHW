//
//  RSTiltedView.m
//  24UIDrawingsHW
//
//  Created by Roma Chopovenko on 10/6/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import "RSTiltedView.h"

@implementation RSTiltedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    self.layer.anchorPoint = CGPointMake(0, 1);
    self.center = CGPointMake(768, 1024);
}



@end
