//
//  ViewController.m
//  demo4
//
//  Created by 刘知远 on 2021/1/3.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "model/Student.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *TxtName;
@property (weak, nonatomic) IBOutlet UITextField *TxtNumber;
@property (weak, nonatomic) IBOutlet UITextField *TxtAge;
@property (weak, nonatomic) IBOutlet UITextField *TxtScore;
@property (weak, nonatomic) IBOutlet UITextView *TxtMemo;

@end

@implementation ViewController

- (IBAction)DataSave:(UIButton *)sender {
    TableViewController *tc = [[TableViewController alloc] init];
    Student *student = [[Student alloc] init];
    student.name = self.TxtName.text;
    student.age = [self.TxtAge.text floatValue];
    student.number = self.TxtNumber.text;
    student.score = [self.TxtScore.text floatValue];
    student.memo = self.TxtMemo.text;
    student.teacher = @"Tian bai";
    
    if (self.indexPath == nil) {
        [self.students addObject:student];
        [tc writeToFile:self.students filePath:self.path];
    }else{
        self.students[self.indexPath.row] = student;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)DataClear:(UIButton *)sender {
    self.TxtMemo.text = nil;
    self.TxtAge.text = nil;
    self.TxtName.text =nil;
    self.TxtNumber.text = nil;
    self.TxtScore.text = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    if (self.indexPath != nil) {
        Student *student = self.students[self.indexPath.row];
        self.TxtName.text = student.name;
        self.TxtNumber.text = student.number;
        self.TxtAge.text = [NSString stringWithFormat:@"%ld",(long)student.age];
        self.TxtScore.text = [NSString stringWithFormat:@"%f",student.score];
        self.TxtMemo.text = student.memo;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
