//
//  ViewController.m
//  DetailInfo
//
//  Created by 张奥 on 2020/4/4.
//  Copyright © 2020 张奥. All rights reserved.
//

#import "ViewController.h"
#import "ZATableView.h"
#import "HeadView.h"
#import "MJRefresh.h"
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong)HeadView *headView;
@property (nonatomic, strong)ZATableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 250)];
    self.headView = headView;
    [self.view addSubview:headView];
    
    ZATableView *tableView = [[ZATableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_Width , SCREEN_Height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = [UIView new];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    tableView.contentInset = UIEdgeInsetsMake(250.f, 0, 0, 0);
    tableView.contentOffset = CGPointMake(0, -250);
    self.tableView = tableView;
    
    MJRefreshHeader *header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
    }];
    tableView.mj_header = header;
    [self.view addSubview:tableView];
    [tableView.mj_header beginRefreshing];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView.mj_header endRefreshing];
    });
}

# pragma mark -- UITabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld=====%ld",indexPath.section,indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%ld=====%ld",indexPath.section,indexPath.row);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = fabsf(scrollView.contentOffset.y) - 250.f;
    if (y < 0) return;
    CGRect rect = self.headView.frame;
    rect.origin.y = y;
    self.headView.frame = rect;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}
@end
