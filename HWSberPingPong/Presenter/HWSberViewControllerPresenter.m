//
//  HWSberViewControllerPresenter.m
//  HWSberPingPong
//
//  Created by Александр on 07/04/2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import "HWSberViewControllerPresenter.h"
#import "Difficulty.h"

@interface HWSberViewControllerPresenter ()
@property (assign, nonatomic) NSInteger topScore;
@property (assign, nonatomic) NSInteger bottomScore;
@property (assign, nonatomic) CGFloat currentSpeed;
@property (assign, nonatomic) CGPoint savePoint;
@property NSArray *arrayModel;

@end

@implementation HWSberViewControllerPresenter

-(instancetype)initWithModelArray: (NSArray*) modelArray
{
	if ( self = [super init] )
	{
		self.arrayModel = modelArray;
		self.currentSpeed = 0.005;
	}
	
	return self ;
}


#pragma mark - PresenterDelegate

-(NSInteger)incrementBottomScore
{
    return self.bottomScore++;
}

-(NSInteger)incrementTopScore
{
    return self.topScore++;
}

-(CGFloat)getSpeed
{
	return self.currentSpeed;
}

-(void)changeSpeed:(NSString*)dufficuly {
	Difficulty *game;
	if ([dufficuly isEqualToString:@"Медленно"])
	{
		game = self.arrayModel[0];
		self.currentSpeed = game.difficulty;
	}
	else if ([dufficuly isEqualToString:@"Обычная"])
	{
		game = self.arrayModel[1];
		self.currentSpeed = game.difficulty;
	}
	else
	{
		game = self.arrayModel[2];
		self.currentSpeed = game.difficulty;
	}
}


#pragma mark - Helpers Methods

@end
