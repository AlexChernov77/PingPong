//
//  ViewInput.h
//  HWSberPingPong
//
//  Created by Александр on 09.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PresenterDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ViewInput <NSObject>

@required
-(void) assign: (id<PresenterDelegate>) presenterDelegate;

@end

NS_ASSUME_NONNULL_END
