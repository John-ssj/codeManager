//
//  SideBarView.h
//  LightMooc
//
//  Created by 魏大同 on 2017/12/26.
//  Copyright © 2017年 魏大同. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiderBtn.h"

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16 )) / 255.0 green:((( s & 0xFF00 ) >> 8 )) / 255.0 blue:(( s & 0xFF )) / 255.0 alpha:1.0]
#define SiderBarGlary 0x8c8c8c
#define SiderBarGreen 0x09bb07
#define BtnH 40
#define padding 10

@protocol SideBarViewDelegate <NSObject>

- (void)SideBtnClickedWithTag:(NSString *)tag;

@end

@interface SideBarView : UIView

@property (nonatomic, strong) SiderBtn *withdrawBtn;
@property (nonatomic, strong) SiderBtn *cutBtn;
@property (nonatomic, strong) SiderBtn *eraserBtn;
@property (nonatomic, strong) SiderBtn *pathBtn;
@property (nonatomic, strong) SiderBtn *arrowBtn;
@property (nonatomic, strong) SiderBtn *draftPaperBtn;
@property (nonatomic, strong) SiderBtn *qrcodeBtn;
@property (nonatomic, strong) SiderBtn *clearBtn;
@property (nonatomic, strong) SiderBtn *lineAndWavyLineBtn;

@property (nonatomic, strong) SiderBtn *recorderBtn;
@property (nonatomic, strong) SiderBtn *uploadBtn;
@property (nonatomic, strong) SiderBtn *pauseBtn;
@property (nonatomic, strong) SiderBtn *tapeBtn;
@property (nonatomic, strong) SiderBtn *insertBtn;
@property (nonatomic, strong) SiderBtn *pointerBtn;

//@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *previousBtn;

@property (nonatomic, strong) UIButton *redColorBtn;
@property (nonatomic, strong) UIButton *blueColorBtn;
@property (nonatomic, strong) UIButton *thinLineBtn;
@property (nonatomic, strong) UIButton *strongLineBtn;

@property (nonatomic, strong) UIImageView *logoIV;


@property (nonatomic, weak) id<SideBarViewDelegate> myDelegate;

- (void)draftPaperBtnClicked;
- (void)tapeBtnClicked;
- (void)changeBtnImgWithTag:(SiderBtn *)btn;        //改变按钮状态

- (void)hideQRButtonAndTapeButton;
- (void)showQRButtonAndTapeButton;

- (void)hideButton;
- (void)showButton;
@end
