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
@property NSArray *arrayModel;

@end

@implementation HWSberViewControllerPresenter

@synthesize savePoint;
@synthesize currentSpeed;
@synthesize bottomScore;
@synthesize topScore;

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

-(void)incrementBottomScore
{
	bottomScore++;
}

-(void)incrementTopScore
{
    topScore++;
}

-(void)changeSpeed:(NSString*)dufficuly
{
	Difficulty *game;
	if ([dufficuly isEqualToString:@"Легко"])
	{
		game = self.arrayModel[0];
		self.currentSpeed = game.difficulty;
	}
	else if ([dufficuly isEqualToString:@"Средне"])
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
