//
//  UploadView.h
//  LightMooc
//
//  Created by 魏大同 on 2018/3/27.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PauseBtnView.h"
#import "PDButton.h"

typedef void(^recorderBtnClicked)(void);
typedef void(^pasueBtnClicked)(void);
typedef void(^uploadBtnClicked)(void);

@interface UploadView : UIView

@property (nonatomic, strong) PDButton *recorderBtn;
@property (nonatomic, strong) PDButton *uploadBtn;
@property (nonatomic, strong) PauseBtnView *pauseBtnView;

@property (nonatomic, copy) recorderBtnClicked record;
@property (nonatomic, copy) pasueBtnClicked pause;
@property (nonatomic, copy) uploadBtnClicked upload;

@property (nonatomic, assign)BOOL pptIsDownloaded;//这个标志位是用在只有当PPT下载完成后，点击录音按钮才有响应

- (void)beginShaking;                   //抖动录制按钮
- (void)uploadSuccessWithAnimate;       //上传成功后一定调用此方法收回暂停结束按钮

@end
