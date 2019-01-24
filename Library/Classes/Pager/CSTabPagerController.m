//
// Created by Rene Dohan on 26/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import "CSTabPagerController.h"
#import "CSTabPagerTab.h"
#import "UIView+CSPosition.h"
#import "UIView+CSDimension.h"
#import "UIView+CSLayoutGetters.h"
#import "UIView+CSLayout.h"

@implementation CSTabPagerController {
    NSArray<CSMainController <CSTabPagerTab> *> *_childMainControllers;
    CSMainController *_parentController;
    UITabBar *_tabBar;
    UIScrollView *_scrollView;
    NSUInteger _currentIndex;
    UIView *_contentView;
}

- (instancetype)construct:(CSMainController *)parent :(NSArray<CSMainController <CSTabPagerTab> *> *)controllers
        :(UITabBar *)toolbar :(UIScrollView *)scrollView {
    [super construct:parent];
    _parentController = parent;
    _childMainControllers = controllers;
    _tabBar = toolbar;
    _tabBar.delegate = self;
    _scrollView = scrollView;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.directionalLockEnabled = YES;
    _contentView = [UIView withColor:UIColor.clearColor frame:_scrollView.bounds];
    [[_scrollView add:_contentView] matchParent];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    invoke(^{
        [self reload:_childMainControllers];
    });
    [self updateAppearance];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)view {
    [self onPageChange:(NSUInteger) lround(_scrollView.contentOffset.x / (_scrollView.contentSize.width / _childMainControllers.count))];
    [self showSelectEffect];
}

- (void)reload:(nonnull NSArray *)controllers {
    if (controllers.empty) return;
    for (UIViewController *controller in _childMainControllers) [_parentController dismissChildController:controller];
    _childMainControllers = controllers;
    [self loadBar];
    _scrollView.contentSize = CGSizeMake(_contentView.width = _childMainControllers.count * _scrollView.width, 0);

    for (CSMainController *controller in _childMainControllers) {
        [_contentView positionViewNextLast:controller.view];
        [_parentController showChildController:controller :_contentView];
        [[controller.view size:_scrollView.size] setNeedsUpdateConstraints];
    }
    [self selectTab:_currentIndex];
}

- (void)loadBar {
    NSMutableArray *items = NSMutableArray.new;
    for (CSMainController <CSTabPagerTab> *controller in _childMainControllers) {
        UITabBarItem *item = [controller tabItem];
        [items add:item];
    }
    [_tabBar setItems:items];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [self onPageChange:[tabBar.items indexOfObject:item]];
    [self showPage];
}

- (void)selectTab:(NSUInteger)pageIndex {
    [self onPageChange:pageIndex];
    [self showPage];
    [self showSelectEffect];
}

- (void)onPageChange:(NSUInteger)pageIndex {
    _childMainControllers[_currentIndex].showing = NO;
    _currentIndex = pageIndex;
    _childMainControllers[_currentIndex].showing = YES;
    [_parentController updateBarItemsAndMenu];
}

- (void)showPage {
    [_scrollView scrollToPage:_currentIndex of:_childMainControllers.count];
}

- (void)showSelectEffect {
    _tabBar.selectedItem = _tabBar.items[_currentIndex];
}

- (void)onViewWillTransitionToSizeCompletion:(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context {
    [super onViewWillTransitionToSizeCompletion:size :context];
    [self reload:_childMainControllers];
    [self updateAppearance];
}

- (void)updateAppearance {
    if (UIDevice.isPortrait) {
        [_tabBar show];
        [_scrollView bottomToHeight:_tabBar.top];
    } else {
        [_tabBar hide];
        [_scrollView bottomToHeight:_tabBar.bottom];
    }
}

@end
