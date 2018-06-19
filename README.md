# AipayHomeDemo
仿支付宝首页效果Demo
# Demo
![效果预览](https://github.com/dhl613/AipayHomeDemo/blob/master/AlipayHomePageDemo/AlipayHome.gif) <br>
# 关键代码
``` Objective-C
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
```

# License
AipayHomeDemo is licensed under the MIT license.[(http://opensource.org/licenses/MIT)](http://opensource.org/licenses/MIT)<br>
