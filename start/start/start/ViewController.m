//
//  ViewController.m
//  start
//
//  Created by apple on 2020/9/28.
//

#import "ViewController.h"
#import "SideBarView.h"
#import "EditHeaderView.h"
#import "UploadView.h"
//#import "DraftPaperView.h"
#import "DrawPopView.h"
//#import "TapeView.h"
//#import "LMLineTypeViewController.h"

#define ScreenK 1

#define SideBarW 60
#define drawingBoardDevY ScreenK * self.view.bounds.size.height-(ScreenK * self.view.bounds.size.width-100)*0.75-10
#define drawingBoardY (drawingBoardDevY > 50? drawingBoardDevY : 64)
#define drawingBoardW (ScreenK * self.view.bounds.size.width-100)
//#define drawingBoardH (ScreenK * self.view.bounds.size.width-100)*0.75
#define drawingBoardH self.view.bounds.size.height - drawingBoardY - 10
#define PageLabelWH 40
#define DraftPaperW (self.view.bounds.size.width - SideBarW) * ScreenK

@interface ViewController ()<SideBarViewDelegate, UIPopoverPresentationControllerDelegate, /*LMAddMediaCollectionViewControllerDelegate,*/ UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (nonatomic, strong) MainScrollView *drawingBoard;
@property (nonatomic, strong) EditHeaderView *headerView;
//@property (nonatomic, strong) DraftPaperView *draftPaperView;
@property (nonatomic, strong) SideBarView *sideBar;
@property (nonatomic, strong) UploadView *uploadView;
@property (nonatomic, strong) DrawPopView *drawPopView;
//@property (nonatomic, strong) TapeView *tapeView;

@property (nonatomic, strong) UILabel *currentPageLab;     //显示页数
@property (nonatomic, strong) UILabel *allPageLab;
@property (nonatomic, strong) UIView *redPoint;         //上传成功后的红点

//@property (nonatomic, assign) float aspectRatio;    //图片的宽高比
@property (nonatomic, strong) NSDictionary *drawingBoardDic;

//@property (nonatomic, strong) SQRView *qrView;

@property (nonatomic, assign) BOOL isTestAccount;
//@property (nonatomic, strong)LMAddMediaCollectionViewController *addMediaController;
//@property (nonatomic, assign)NSInteger inserPageIndex;

//@property (nonatomic, strong)LMEditViewModel *viewModel;
//@property (nonatomic, assign)BOOL insertBeforeThePage;
//@property (nonatomic, strong)LMMicrophoneView *microphoneView;

//@property (nonatomic, strong)LMLineTypeViewController *lineTypeViewController;

// 删除本页PPT的button
@property (nonatomic, strong)UIButton *deleteBtn;

@end

@implementation ViewController {
    BOOL _isDraftViewShow;
    NSTimeInterval _startTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    
    NSNumber *status = [[NSUserDefaults standardUserDefaults] objectForKey:@"status"];
    self.isTestAccount = status.boolValue == NO? YES:NO;
    
//    _viewModel = [[LMEditViewModel alloc] init];
    
    [self setHeaderView];
    [self setUploadView];
//    [self setDrawingBoard];
    [self setSideBar];
//    [self setDraftPaperView];
//    [self setPageNumberWithInfo:nil];
//    [self setDrawPopView];
//
//    [self setTapeView];
//    [self setMicrophoneView];
//    [self setDeleteBtn];
    
//    //通知
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    [nc addObserver:self selector:@selector(setPageNumberWithInfo:) name:@"DrawingBoard_PageChanged" object:nil];
//    [nc addObserver:self selector:@selector(choosePhotoHaveFinished:) name:CHOOSE_PHOTO_NOTIFICATION object:nil];
//    [nc addObserver:self selector:@selector(liveChanged) name:@"Enter_Background" object:nil];
//    [nc addObserver:self selector:@selector(liveChanged) name:@"live_disconnect" object:nil];
    
    //10.5模拟
    
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, ScreenK * self.view.bounds.size.height, self.view.bounds.size.width, (1-ScreenK) * self.view.bounds.size.height);
    footer.backgroundColor = [UIColor blackColor];
    [self.view addSubview:footer];
    
    UIView *sider = [[UIView alloc]init];
    sider.frame = CGRectMake(ScreenK * self.view.bounds.size.width, 0, (1-ScreenK) * self.view.bounds.size.width, self.view.bounds.size.height);
    sider.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sider];
    self.navigationController.delegate = self;
    
}

- (BOOL)prefersStatusBarHidden{
    // 隐藏状态栏
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 标题栏

- (void)setHeaderView{
    
    _headerView = [[EditHeaderView alloc]init];
    _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, drawingBoardY-5);
    NSString *nameString = _drawingBoardDic[@"doc"][@"name"];
    _headerView.titleLab.text = [nameString stringByDeletingPathExtension];
    _headerView.titleLab.numberOfLines = 1;
    _headerView.titleLab.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    _headerView.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_headerView];
    
    __weak typeof(*&self) weakSelf = self;
    
    NSString *docId = _drawingBoardDic[@"doc"][@"id"];
    NSString *urlString = [[@"https://www.qingmooc.com/api/v1/live" stringByAppendingPathComponent:docId] stringByAppendingPathComponent:@"status"];
 
//    _headerView.switchStateChangedBlock = ^(BOOL isOn, BOOL showProgressView) {
//
//        [[LMHttp sharedManager] requestWithMethod:PUT api:urlString parameters:@{@"status": @(isOn)} successBlock:^(NSURLSessionTask *task, id resonseObject) {
//
//            if (isOn) {
//              [weakSelf.drawingBoard socketConnectWithDocId:weakSelf.drawingBoardDic[@"doc"][@"id"]];
//            }else{
//              [weakSelf.drawingBoard socketDisconnect];
//            }
//
//            if (!showProgressView) {
//                return ;
//            }
//
//            isOn? [SVProgressHUD showSuccessWithStatus:@"直播模式已开启"] : [SVProgressHUD showSuccessWithStatus:@"直播模式已关闭"];
//            [SVProgressHUD dismissWithDelay:0.8];
//
//        } failBlock:^(NSURLSessionTask *task, NSError *error) {
//            if (!showProgressView) {
//                return ;
//            }
//            [SVProgressHUD showErrorWithStatus:@"操作失败"];
//            [weakSelf.headerView.liveSwith setOn:!isOn];
//            [SVProgressHUD dismissWithDelay:0.8];
//        }];
//
//    };
    
}

//#pragma mark - 造画板
//
//- (void)setDrawingBoard{
//
//    //创建新的item
//    NSString *fileName = _drawingBoardDic[@"doc"][@"id"];
//    [[DTFileManger sharedInstance]createDateFolder:fileName];
//
//    _startTime = [TimeTools getTimeIntervalSince1970];
//    _drawingBoard = [[MainScrollView alloc]initWithStartTimeIntervalSince1970:_startTime andData:_drawingBoardDic];
//    _drawingBoard.frame = CGRectMake(SideBarW+0.5*(self.view.bounds.size.width-SideBarW-drawingBoardW), drawingBoardY, drawingBoardW, drawingBoardH);
//    [self.view insertSubview:_drawingBoard atIndex:0];
//    [self.view.layer insertSublayer:_draftPaperView.layer atIndex:0];
//    _draftPaperView.clipsToBounds = YES;
//
//    __weak typeof(self)weakSelf = self;
//
//    _drawingBoard.shakingUploadView = ^(){
//        [weakSelf.uploadView beginShaking];
//    };
//}

#pragma mark - 录制按钮及一系列上传方法

- (void)setUploadView{
    
    CGFloat viewW = self.view.bounds.size.width;
    CGFloat viewH = self.view.bounds.size.height;
    CGFloat placeholderW = 80;
    CGFloat selfH = drawingBoardY - 18;
    CGFloat selfW = selfH * 3 + 5;
    
    _uploadView = [[UploadView alloc]init];
    _uploadView.frame = CGRectMake(viewW- selfW - placeholderW, 5 , selfW, selfH);
    [self.view addSubview:_uploadView];
    
    __weak typeof(*&self) weakSelf = self;
    
    _uploadView.record = ^(){
        
        [weakSelf.sideBar showButton];
        [weakSelf.drawPopView setDefault];//每次开始录音的时候设置drawPopView的按钮的初试状态
//        weakSelf.drawingBoard.isPreparedToDraw = YES;
        [weakSelf SideBtnClickedWithTag:@"recoder"];
//        weakSelf.drawingBoard.preperToShowDrawPopView = YES;
        weakSelf.deleteBtn.hidden = YES;
    };
    
    _uploadView.upload = ^(){
        
//        [weakSelf.drawingBoard socketDisconnect];
        
        BOOL hasAction = [(NSNumber *)(weakSelf.drawingBoardDic[@"doc"][@"hasAction"]) boolValue];
        weakSelf.deleteBtn.hidden = hasAction;
        
        [weakSelf.sideBar hideButton];
        [weakSelf.uploadView.pauseBtnView setDefault];
//        weakSelf.drawingBoard.isPreparedToDraw = NO;
//        [weakSelf.drawingBoard.pointerView removeFromSuperview];
        
        [weakSelf.sideBar.recorderBtn setTitle:@"录制" forState:UIControlStateNormal];
        [weakSelf.uploadView uploadSuccessWithAnimate];
        
    };
    
    _uploadView.pause = ^(){
        if (weakSelf.uploadView.pauseBtnView.isPause) {
//            weakSelf.drawingBoard.isPreparedToDraw = NO;
        }else{
//            weakSelf.drawingBoard.isPreparedToDraw = YES;
        }
    };
}

#pragma mark - 侧栏及其协议方法

- (void)setSideBar{
    
    _sideBar = [[SideBarView alloc]init];
    _sideBar.myDelegate = self;
    _sideBar.frame = CGRectMake(0, 0, SideBarW, self.view.bounds.size.height);
    [self.view addSubview:_sideBar];
//    [_sideBar hideButton];
    
}

- (void)SideBtnClickedWithTag:(NSString *)tag{
    
    if (_isDraftViewShow){
        [self draftViewSiderBarBtnClickedWithTag:tag];
    }else{
//        [self drawingBoardSiderBarBtnClickedWithTag:tag];
    }
}

//草稿纸的侧栏点击方法
- (void)draftViewSiderBarBtnClickedWithTag:(NSString *)tag{
    
    if ([tag isEqualToString:@"path"]) {
        
    
        
    }else if ([tag isEqualToString:@"lineAndWavyLine"]){
        [self draftViewSiderBarBtnClickedWithTag:@"line"];
        if (_sideBar.lineAndWavyLineBtn.isSelected) {
            [self presentViewController:self.inputViewController animated:YES completion:^{
            }];
        }
        
    }else{
    }
    
}


- (void)showDrawPopView{
    _drawPopView.hidden = NO;
}

- (void)hiddenDrawPopView{
    _drawPopView.hidden = YES;
}


@end
