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

-(void)incrementBottomScore;
-(void)incrementTopScore;
-(void) changeSpeed: (NSString*) dufficuly;
@property (assign, nonatomic) CGPoint savePoint;
@property (assign, nonatomic) CGFloat currentSpeed;
@property (assign, nonatomic) NSInteger topScore;
@property (assign, nonatomic) NSInteger bottomScore;


@end

NS_ASSUME_NONNULL_END
