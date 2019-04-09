//
//  DependencyInjection.h
//  HWSberPingPong
//
//  Created by Александр on 09.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface DependencyInjection : NSObject

+(void) assignView : (id<ViewInput>) view ;

@end

NS_ASSUME_NONNULL_END
