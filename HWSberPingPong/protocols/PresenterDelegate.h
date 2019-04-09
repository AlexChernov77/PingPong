//
//  PresenterDelegate.h
//  HWSberPingPong
//
//  Created by Александр on 09.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PresenterDelegate <NSObject>

-(NSInteger)incrementBottomScore;
-(NSInteger)incrementTopScore;
-(void) changeSpeed: (NSString*) dufficuly;
-(CGFloat)getSpeed;

@end

NS_ASSUME_NONNULL_END
