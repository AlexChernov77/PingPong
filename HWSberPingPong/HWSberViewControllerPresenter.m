//
//  HWSberViewControllerPresenter.m
//  HWSberPingPong
//
//  Created by Александр on 07/04/2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import "HWSberViewControllerPresenter.h"

@interface HWSberViewControllerPresenter ()
@property (assign, nonatomic) NSInteger topScore;
@property (assign, nonatomic) NSInteger bottomScore;
@property (assign, nonatomic) double currentSpeed;
@property (assign, nonatomic) CGPoint savePoint;

@end

@implementation HWSberViewControllerPresenter

-(NSInteger)incrementBottomScore
{
    return self.bottomScore++;
}

-(NSInteger)incrementTopScore
{
    return self.topScore++;
}


#pragma mark - Helpers Methods

@end
