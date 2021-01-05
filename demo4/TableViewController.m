//
//  TableViewController.m
//  demo4
//
//  Created by 刘知远 on 2021/1/4.
//

#import "TableViewController.h"
#import "model/Student.h"
#import "ViewController.h"

@interface TableViewController ()
@property(strong,nonatomic) NSMutableArray *students;//所有学生对象
@property(strong,nonatomic) Student *student;//选中的学生对象
@property(strong,nonatomic) NSString *path;//保存文件目录
@end

@implementation TableViewController
//下拉刷新
- (IBAction)refreshData:(UIRefreshControl *)sender {
    [self.refreshControl beginRefreshing];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
}

- (void)writeToFile:(NSMutableArray *) sts filePath:(NSString *)path{
    NSDate *data;
    NSMutableArray *ds = [[NSMutableArray alloc] init];
    for (Student *s in sts) {
        data = [NSKeyedArchiver archivedDataWithRootObject:s];
        [ds addObject:data];
    }
    [ds writeToFile:path atomically:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //获得文件路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.path = [doc stringByAppendingPathComponent:@"students.plist"];
    NSMutableArray *dataarray = [NSMutableArray arrayWithContentsOfFile:self.path];
    self.students = [[NSMutableArray alloc] init];
    for (NSDate *s in dataarray) {
        [self.students addObject:[NSKeyedUnarchiver unarchiveObjectWithData:s]];
    }
    
}
//解决添加了信息后tableview无法刷新的问题
//这个函数会调用cellForRowAtIndexPath这个方法，从而重新加载了UITableViewCell的数据。
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addinfo"]) {
        if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
            ViewController *vc = (ViewController *)segue.destinationViewController;
            vc.students = self.students;
            vc.indexPath = nil;
            vc.path = self.path;
        }
    }
    if ([segue.identifier isEqualToString:@"showdetail"]) {
        if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            ViewController *vc = (ViewController *)segue.destinationViewController;
            vc.students = self.students;
            vc.indexPath = indexPath;
            vc.path = self.path;
        }
    }
    
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
// 告诉我们有多少个表单元，小结

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.students count];
}

//把表单元显示出来
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell" forIndexPath:indexPath];
    self.student = self.students[indexPath.row];
    cell.textLabel.text = self.student.name;
    cell.detailTextLabel.text = self.student.number;
    return cell;
}

//滑动删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //如果处于删除状态，则删除表单以及数据库的内容
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.students removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self writeToFile:self.students filePath:self.path];
    }
}

//修改
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"modifyview"];
    vc.students = self.students;
    vc.indexPath = indexPath;
    vc.path = self.path;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
