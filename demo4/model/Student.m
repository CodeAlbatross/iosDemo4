//
//  Student.m
//  demo4
//
//  Created by 刘知远 on 2021/1/4.
//

#import "Student.h"

@implementation Student
//完成序列化
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.number forKey:@"number"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeFloat:self.score forKey:@"score"];
    [aCoder encodeObject:self.memo forKey:@"memo"];
    [aCoder encodeObject:self.teacher forKey:@"teacher"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.number = [aDecoder decodeObjectForKey:@"number"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
        self.score = [aDecoder decodeFloatForKey:@"score"];
        self.memo = [aDecoder decodeObjectForKey:@"memo"];
        self.teacher = [aDecoder decodeObjectForKey:@"teacher"];
    }
    return self;
}
@end
