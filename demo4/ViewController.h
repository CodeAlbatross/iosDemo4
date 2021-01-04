//
//  ViewController.h
//  demo4
//
//  Created by 刘知远 on 2021/1/3.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(strong,nonatomic) NSMutableArray *students;
@property(strong,nonatomic) NSIndexPath *indexPath;//表示图的某一行的位置信息
@property(strong,nonatomic) NSString *path;

@end

