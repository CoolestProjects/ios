//
//  CPAMessage.h
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPAObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPAMessage : CPAObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *regionId;
@property (nonatomic, copy) NSString *versionId;

@end

NS_ASSUME_NONNULL_END
