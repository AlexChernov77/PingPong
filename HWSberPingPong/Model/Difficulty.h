//
//  Difficulty.h
//  HWSberPingPong
//
//  Created by Александр on 08.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Difficulty : NSObject

@property (readonly) CGFloat difficulty;

-(instancetype) initWithDufficulty : (CGFloat) difficulty;

@end

NS_ASSUME_NONNULL_END
