//
// Created by Rene Dohan on 17/11/16.
// Copyright (c) 2016 renetik_software. All rights reserved.
//

@import UIKit;

@class CSResponse;

@protocol CSViewControllerProtocol <NSObject>

- (CSResponse *)showFailed:(CSResponse *)response;

- (UIViewController *)asController;

- (CSResponse *)showProgress:(CSResponse *)response;

@end