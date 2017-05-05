//
//  ZRSHotViewController.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/30.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSHotViewController.h"
#import "ZRSTopAD.h"
#import "ZRSHomeADCell.h"
#import "ZRSHotLiveCell.h"
#import <MJRefresh.h>
#import "ZRSLiveItem.h"
#import "ZRSWebViewController.h"
#import "ZRSRefreshGifHeader.h"

@interface ZRSHotViewController ()
/** 当前页 */
@property (nonatomic, assign) NSUInteger currentPage;
/** 直播 */
@property (nonatomic, strong) NSMutableArray *lives;
/** 广告 */
@property (nonatomic, copy) NSArray *topADS;

@end

static NSString *reuseIdentifer = @"ZRSHotLiveCell";
static NSString *ZReuseIdentifer = @"ZRSHomeADCell";

@implementation ZRSHotViewController

- (NSMutableArray *)lives {
    if (!_lives) {
        _lives = [NSMutableArray array];
    }
    return _lives;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZRSHotLiveCell class]) bundle:nil] forCellReuseIdentifier:reuseIdentifer];
    [self.tableView registerClass:[ZRSHomeADCell class] forCellReuseIdentifier:ZReuseIdentifer];
    
    self.currentPage = 1;
    self.tableView.mj_header = [ZRSRefreshGifHeader headerWithRefreshingBlock:^{
        self.lives = [NSMutableArray array];
        self.currentPage = 1;
        //取得顶部的广告
        [self getTopAD];
        [self getHotLiveList];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage ++;
        [self getHotLiveList];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)getTopAD {
    [[ZRSNetworkTool shareTool] GET:@"http://live.9158.com/Living/GetAD" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *result = responseObject[@"data"];
        if ([self isNotEmpty:result]) {
            self.topADS  = [ZRSTopAD mj_objectArrayWithKeyValuesArray:result];
            [self.tableView reloadData];
        } else {
            [self showHint:@"网络异常"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"网络异常"];
    }];
}

- (void)getHotLiveList {
    [[ZRSNetworkTool shareTool] GET:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld",  self.currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSArray *result = [ZRSLiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if ([self isNotEmpty:result]) {
            [self.lives addObjectsFromArray:result];
            [self.tableView reloadData];
        } else {
            [self showHint:@"暂时没有更多更新数据"];
            //恢复当前页
            self.currentPage --;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.currentPage--;
        [self showHint:@"网络异常"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.lives.count + 1;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }
    return 465;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ZRSHomeADCell *cell = [tableView dequeueReusableCellWithIdentifier:ZReuseIdentifer];
        if (self.topADS.count) {
            cell.topADs = self.topADS;
            
            [cell setImageClickBlock:^(ZRSTopAD *topAD) {
                if (topAD.link.length) {
                    ZRSWebViewController *web = [[ZRSWebViewController alloc] initWithUrlStr:topAD.link];
                    web.navigationItem.title = topAD.title;
                    [self.navigationController pushViewController:web animated:YES];
                }
            }];
        }
        return cell;
    }
    
    ZRSHotLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
    if (self.lives.count) {
        ZRSLiveItem *live = self.lives[indexPath.row - 1];
        cell.live = live;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
