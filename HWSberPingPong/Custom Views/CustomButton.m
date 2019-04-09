//
//  CustomButton.m
//  HWSberPingPong
//
//  Created by Александр on 09.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(instancetype)initWithParamets: (NSString*) title : (UIColor*) backgroudcolor : (CGRect) frame
{
	if ( self = [super init] )
	{
		self.frame = frame;
		self.backgroundColor = backgroudcolor;
		[self setTitle:title forState:UIControlStateNormal];
	}
	
	return self ;
}

@end
