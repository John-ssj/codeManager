//
//  DrawPopView.h
//  LightMooc
//
//  Created by 魏大同 on 2018/3/26.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawPopBtn.h"

typedef void(^buttonClicked)(NSString *btnName);
typedef void(^dissmissView)(void);

@interface DrawPopView : UIView

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) DrawPopBtn *thinLineBtn;
@property (nonatomic, strong) DrawPopBtn *middleLineBtn;
@property (nonatomic, strong) DrawPopBtn *strongLineBtn;

@property (nonatomic, strong) DrawPopBtn *redColorBtn;
@property (nonatomic, strong) DrawPopBtn *blueColorBtn;
@property (nonatomic, strong) DrawPopBtn *blackColorBtn;
@property (nonatomic, strong) DrawPopBtn *brownColorBtn;

@property (nonatomic, strong) DrawPopBtn *purpleColorBtn;
@property (nonatomic, strong) DrawPopBtn *orangeColorBtn;
@property (nonatomic, strong) DrawPopBtn *cyanColorBtn;
@property (nonatomic, strong) DrawPopBtn *greenColorBtn;

@property (nonatomic, strong) DrawPopBtn *magentaColorBtn;
@property (nonatomic, strong) DrawPopBtn *grayColorBtn;
@property (nonatomic, strong) DrawPopBtn *yellowColorBtn;
@property (nonatomic, strong) DrawPopBtn *whiteColorBtn;

@property (nonatomic, copy) buttonClicked btnClickedWithName;
@property (nonatomic, copy) dissmissView dissmissView;

- (instancetype)initWithMainViewFrame:(CGRect )frame;

- (void)setDefault;

@end
