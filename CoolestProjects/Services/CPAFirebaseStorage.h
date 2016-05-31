//
//  CPAFirebaseStorage.h
//  CoolestProjects
//
//  Created by Colin Pierse on 31/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@protocol CPAFirebaseStorage <NSObject>

- (void)getImageForUrlString:(NSString *)urlString completionBlock:(void (^)(UIImage *image, NSError *error))completionBlock;

@end
