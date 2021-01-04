//
//  TableViewController.h
//  demo4
//
//  Created by 刘知远 on 2021/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController
- (void)writeToFile:(NSMutableArray *) sts filePath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
