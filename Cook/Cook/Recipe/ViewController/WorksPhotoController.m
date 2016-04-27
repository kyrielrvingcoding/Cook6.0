//
//  WorksPhotoController.m
//  Cook
//
//  Created by 诸超杰 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "WorksPhotoController.h"
#import "WorksPhotoHeaderView.h"
#import "WorksPhotoCommentCell.h"
#import "CommentsModel.h"

static NSString *WorksPhotoCommentCellIdentifier = @"WorksPhotoCommentCellIdentifier";

@interface WorksPhotoController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) WorksPhotoHeaderView *worksPhotoHeaderView;
@property (nonatomic, strong) NSMutableArray *CommentsArray;
@end

@implementation WorksPhotoController

- (NSMutableArray *)CommentsArray {
    if (_CommentsArray == nil) {
        _CommentsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _CommentsArray = _WorkWaterfallModel.commentArray;
    }
    return _CommentsArray;
}

- (UITableView *)tabelView {
    if (_tabelView == nil) {
        _tabelView = [[UITableView alloc] initWithFrame:SCREENBOUNDS style:(UITableViewStyleGrouped)];
        [_tabelView registerNib:[UINib nibWithNibName:@"WorksPhotoCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:WorksPhotoCommentCellIdentifier];
        _tabelView.dataSource = self;
        _tabelView.delegate = self;
    }
    return _tabelView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tabelView];
    _worksPhotoHeaderView = [[NSBundle mainBundle] loadNibNamed:@"WorksPhotoHeaderView" owner:nil options:nil][0];
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [_worksPhotoHeaderView getHeightByNewWorkWaterfallModel:_WorkWaterfallModel];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    [_worksPhotoHeaderView setNewWorkWaterfallModel:_WorkWaterfallModel];
    return _worksPhotoHeaderView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   return [WorksPhotoCommentCell getHeightByNewWorkWaterfallModel:_WorkWaterfallModel andIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_WorkWaterfallModel.commentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentsModel *model = self.CommentsArray[indexPath.row];
    WorksPhotoCommentCell *cell = [self.tabelView dequeueReusableCellWithIdentifier:WorksPhotoCommentCellIdentifier forIndexPath:indexPath];
    [cell setWithComentsModel:model];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
