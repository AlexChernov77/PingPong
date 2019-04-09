//
//  HWSberViewControllerPresenter.h
//  HWSberPingPong
//
//  Created by Александр on 07/04/2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresenterDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWSberViewControllerPresenter : NSObject <PresenterDelegate>

-(instancetype)initWithModelArray: (NSArray*) modelArray;

@end

NS_ASSUME_NONNULL_END
