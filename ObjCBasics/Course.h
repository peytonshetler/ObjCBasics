//
//  Course.h
//  ObjCBasics
//
//  Created by Peyton Shetler on 5/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Course : NSObject

// TO DO: Look up strong and nonatomic
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *numberOfLessons;

@end

NS_ASSUME_NONNULL_END
