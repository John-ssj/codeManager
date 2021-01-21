//
//  EditHeaderView.h
//  LightMooc
//
//  Created by 魏大同 on 2018/3/25.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^popViewWithBackBtn)(void);

@interface EditHeaderView : UIView

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLab;

//是否是直播模式
@property (nonatomic, strong) UISwitch *liveSwith;
//直播label
@property (nonatomic, strong) UILabel *liveLabel;
// 顶部栏下方的渐变层（阴影）
@property (nonatomic, strong)CAGradientLayer *gradient;

@property (nonatomic, copy) popViewWithBackBtn pop;

@property (nonatomic, copy)void (^switchStateChangedBlock)(BOOL isOn, BOOL showProgressView);

@end
