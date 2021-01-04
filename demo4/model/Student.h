//
//  Student.h
//  demo4
//
//  Created by 刘知远 on 2021/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *number;
@property(nonatomic)NSInteger age;
@property(nonatomic)float score;
@property(strong,nonatomic) NSString *memo;
@property(strong,nonatomic) NSString *teacher;
@end

NS_ASSUME_NONNULL_END
