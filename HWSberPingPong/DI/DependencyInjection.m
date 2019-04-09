//
//  DependencyInjection.m
//  HWSberPingPong
//
//  Created by Александр on 09.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import "DependencyInjection.h"
#import "HWSberViewControllerPresenter.h"
#import "Difficulty.h"

@implementation DependencyInjection

+(void) assignView : (id<ViewInput>) view
{
	
	Difficulty *easy = [[Difficulty alloc] initWithDufficulty: 0.01f];
	Difficulty *medium = [[Difficulty alloc] initWithDufficulty: 0.005f];
	Difficulty *hard = [[Difficulty alloc] initWithDufficulty: 0.0025f];
	
	NSArray *difficuly = @[easy, medium, hard];
	
	HWSberViewControllerPresenter * presenter = [[HWSberViewControllerPresenter alloc] initWithModelArray: difficuly];
	[view assign:presenter];
}

@end
