//
//  PlayerRacketView.m
//  HWSberPingPong
//
//  Created by Александр on 07/04/2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import "PlayerRacketView.h"

static const CGFloat VerticalMargin = 50.f;
static const CGFloat RacketViewHWidth = 70.f;

@implementation PlayerRacketView

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    if (currentPoint.x >= width - RacketViewHWidth/2)
    {
        self.center = CGPointMake(width - RacketViewHWidth/2, height - VerticalMargin);
    }
    else if (currentPoint.x <= RacketViewHWidth/2)
    {
        self.center = CGPointMake(RacketViewHWidth/2, height - VerticalMargin);
    }
    else
    {
        self.center = CGPointMake(currentPoint.x, height - VerticalMargin);
    }
}

@end
