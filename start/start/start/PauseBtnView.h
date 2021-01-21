//
//  PauseBtnView.h
//  LightMooc
//
//  Created by 魏大同 on 2018/3/29.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiderBtn.h"
//#import "DTFileManger.h"

typedef void(^pauseBtnClicked)(void);

@interface PauseBtnView : UIView

@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *coverBtn;

@property (nonatomic, strong) CAGradientLayer *gradient;
@property (nonatomic, strong) CAGradientLayer *gradient1;
@property (nonatomic, strong) CAGradientLayer *gradient2;
@property (nonatomic, strong) CAGradientLayer *gradient3;

@property (nonatomic, assign) BOOL isPause;

@property (nonatomic, assign) NSString *duration;

@property (nonatomic, copy) pauseBtnClicked pause;

@property (nonatomic, assign)BOOL isBackFromPause;   //是否是暂停后重新开始的计时


-(void)addTimer;
-(void)removeTimer;
- (void)setDefault;
@end
