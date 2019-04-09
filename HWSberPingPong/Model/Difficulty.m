//
//  Difficulty.m
//  HWSberPingPong
//
//  Created by Александр on 08.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import "Difficulty.h"

@interface Difficulty()

@property CGFloat difficulty;

@end

@implementation Difficulty

-(instancetype) initWithDufficulty : (CGFloat) difficulty
{
	if ( self = [super init] )
	{
		_difficulty = difficulty;
	}
	
	return self ;
}

@end
