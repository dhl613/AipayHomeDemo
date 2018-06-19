//
//  ViewController.m
//  AlipayHomePageDemo
//
//  Created by MEIS011 on 2018/6/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "JHHomeCollectionViewCell.h"
#import "JHVerticalButton.h"
#import "UIButton+JH.h"
#import "UIView+Frame.h"
#import "MJRefresh.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define RGBA(rgbValue, opacity) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:opacity]
#define RGB(rgbValue) RGBA(rgbValue, 1.0)
// 主题颜色
#define THEME_COLOR RGB(0x5280BE)

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kNavigationHeight 44

static NSInteger kFunctionViewHeight = 90;
static NSString *const kCellID = @"JHHomeCollectionViewCellID";

@interface ViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIScrollView  *scrollView; // 可滑动容器contentView
@property (strong, nonatomic) UIView  *navView;          // 导航栏容器view
@property (strong, nonatomic) UIView  *normalNavView;    // 正常导航栏view
@property (strong, nonatomic) UIView  *coverNavView;     // 上滑显示的导航栏view
@property (strong, nonatomic) UIView  *headerView;       // 头部view(下面没有view则是contentView)
@property (strong, nonatomic) UIView  *functionView;     // 功能view(扫一扫)
@property (strong, nonatomic) UICollectionView  *collectionView;
@property (strong, nonatomic) NSMutableArray  *moduleData;

@end

@implementation ViewController {
    CGFloat  _itemWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
    [self layoutUIs];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup UI
- (void)setupUI {
    
    // 导航栏
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.normalNavView];
    [self.navView addSubview:self.coverNavView];
    
    // 功能view 模块view
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headerView];
    [self.headerView addSubview:self.functionView];
    [self.scrollView addSubview:self.collectionView];
    
    // 设置collectionview下拉刷新
    WS(weakSelf);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    // 模块item的宽度
    _itemWidth = (kScreenWidth - 2)/3.0;
    self.moduleData = [@[@2,@2,@2,@2,@2,@2,@2,@2,@2,@2,@2,@2,@2,@2,@2] mutableCopy];
    CGFloat moduleHeight = (self.moduleData.count/3 + 1) * _itemWidth;
    self.collectionView.jh_height = moduleHeight;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kFunctionViewHeight + moduleHeight + 20);
}
- (void)layoutUIs {
    CGFloat statusHeight = kScreenHeight == 812? 44: 20;
    [self.navView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(kNavigationHeight + statusHeight);
    }];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.bottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        make.left.right.equalTo(self.view);
    }];
}

// 设置滚动动画
- (void)setScrollViewAnimation:(CGFloat)y {
    if (y > kFunctionViewHeight/2.0) {
        [self.scrollView setContentOffset:CGPointMake(0, kFunctionViewHeight) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat y = scrollView.contentOffset.y;
    if (y < -65) {
        
        [self.collectionView.mj_header beginRefreshing];
    } else if (y>0 && y<=kFunctionViewHeight) {
        [self setScrollViewAnimation:y];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        // 设置collectionView的偏移量时 会调用scrollViewDidScroll: 为了避免死循环
        return;
    }
    
    CGFloat y = scrollView.contentOffset.y;
    //    JHLog(@"scrollView y:%f",y);
    if (y <= 0) {
        
        self.headerView.jh_y = y ;
        
        // 保持collectionview的frame不动
        self.collectionView.jh_y = y + kFunctionViewHeight;
        
        if (![self.collectionView.mj_header isRefreshing]) {
            //设置collectionView的偏移量 会调用scrollViewDidScroll:
            self.collectionView.contentOffset = CGPointMake(0, y);
        }
        
        self.functionView.jh_y = 0;
    } else {
        // 功能view视觉差
        self.headerView.jh_y = y/2;
    }
    
    // 2.功能view透明度 从1到0  0.5时 覆盖导航栏 原正常导航栏显示切换
    float alpha = (1 - y/kFunctionViewHeight*1.5) >0 ? (1 - y/kFunctionViewHeight*1.5): 0;
    
    self.functionView.alpha = alpha;
    if (alpha > 0.5) {
        
        self.normalNavView.alpha = alpha * 2 - 1;
        self.coverNavView.alpha = 0;
    } else {
        
        self.normalNavView.alpha = 0;
        self.coverNavView.alpha = 1 - alpha * 2;
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.moduleData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JHHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (kScreenWidth - 2)/3.0;
    return CGSizeMake(width, width);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

#pragma mark - Network Request
- (void)loadData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.collectionView.mj_header endRefreshing];
    });
}

#pragma mark - Lazy Loading
- (UIView *)navView {
    if (_navView == nil) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kNavigationHeight)];
        _navView.backgroundColor = THEME_COLOR;
    }
    return _navView;
}
- (UIView *)normalNavView {
    if ( _normalNavView == nil) {
        CGFloat statusHeight = kScreenHeight == 812? 44: 20;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, statusHeight, kScreenWidth, kNavigationHeight)];
        _normalNavView = view;
        _normalNavView.backgroundColor = THEME_COLOR;
        
        UIButton *message = [UIButton buttonWithImage:[UIImage imageNamed:@"message"]];
        [view addSubview:message];
        [message makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(view);
            make.width.equalTo(kNavigationHeight);
        }];
    }
    return _normalNavView;
}
- (UIView *)coverNavView {
    if ( _coverNavView == nil) {
        CGFloat statusHeight = kScreenHeight == 812? 44: 20;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, statusHeight, kScreenWidth, kNavigationHeight)];
        _coverNavView = view;
        _coverNavView.backgroundColor = THEME_COLOR;
        _coverNavView.alpha = 0;
        
        /// 添加扫一扫按钮
        UIButton *sao1 = [UIButton buttonWithImage:[UIImage imageNamed:@"scan"]];
        [view addSubview:sao1];
        UIButton *sao2 = [UIButton buttonWithImage:[UIImage imageNamed:@"scan"]];
        [view addSubview:sao2];
        UIButton *sao3 = [UIButton buttonWithImage:[UIImage imageNamed:@"scan"]];
        [view addSubview:sao3];
        CGFloat margin = 30;
        [sao1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(15);
            make.centerY.equalTo(view);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
        [sao2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sao1.right).offset(margin);
            make.centerY.equalTo(view);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
        [sao3 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sao2.right).offset(margin);
            make.centerY.equalTo(view);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
    }
    return _coverNavView;
}
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        CGFloat naviHeight = 20 + kNavigationHeight;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHeight, kScreenWidth, kScreenHeight - naviHeight)];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = RGB(0xf0f0f0);
        _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(kFunctionViewHeight, 0, 0, 0);
        //        [_scrollView setContentOffset:CGPointMake(0, 0)];
        //        [_scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return _scrollView;
}
- (UIView *)headerView {
    if (_headerView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFunctionViewHeight)];
        _headerView = view;
        _headerView.backgroundColor = THEME_COLOR;
    }
    return _headerView;
}
- (UIView *)functionView {
    if ( _functionView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFunctionViewHeight)];
        _functionView = view;
        _functionView.backgroundColor = THEME_COLOR;
        
        JHVerticalButton *sao = [JHVerticalButton buttonWithFrame:CGRectZero image:[UIImage imageNamed:@"scan"] title:@"扫一扫" titleColor:[UIColor whiteColor]];
        sao.titleLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:sao];
        JHVerticalButton *sao1 = [JHVerticalButton buttonWithFrame:CGRectZero image:[UIImage imageNamed:@"scan"] title:@"付钱" titleColor:[UIColor whiteColor]];
        sao1.titleLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:sao1];
        JHVerticalButton *sao2 = [JHVerticalButton buttonWithFrame:CGRectZero image:[UIImage imageNamed:@"scan"] title:@"收钱" titleColor:[UIColor whiteColor]];
        sao2.titleLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:sao2];
        CGFloat margin = (kScreenWidth - 180)/4.0;
        [sao makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.size.equalTo(CGSizeMake(60, 80));
            make.left.equalTo(view).offset(margin);
        }];
        [sao1 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.size.equalTo(sao);
            make.left.equalTo(sao.right).offset(margin);
        }];
        [sao2 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.size.equalTo(sao);
            make.left.equalTo(sao1.right).offset(margin);
        }];
    }
    return _functionView;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kFunctionViewHeight, kScreenWidth, self.scrollView.bounds.size.height - kFunctionViewHeight) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JHHomeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kCellID];
        [_collectionView setScrollEnabled:NO];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = RGB(0xf0f0f0);
    }
    return _collectionView;
}
- (NSMutableArray *)moduleData {
    if (_moduleData == nil) {
        _moduleData = [NSMutableArray array];
    }
    return _moduleData;
}


@end
