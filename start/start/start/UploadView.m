
// 录制按钮、暂停按钮、结束按钮

#import "UploadView.h"
#import "PDButton.h"


@implementation UploadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _recorderBtn = [PDButton buttonWithType:UIButtonTypeRoundedRect];
        [_recorderBtn addTarget:self action:@selector(recoderBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_recorderBtn setTitle:@"开始" forState:UIControlStateNormal];
        [_recorderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *recorderImg = [UIImage imageNamed:@"recorder"];
        recorderImg = [recorderImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_recorderBtn setImage:recorderImg forState:UIControlStateNormal];
        _recorderBtn.layer.borderWidth = 3;
        _recorderBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _recorderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _recorderBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_recorderBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        _recorderBtn.backgroundColor = [UIColor redColor];
        [self addSubview:_recorderBtn];
        
        _uploadBtn = [PDButton buttonWithType:UIButtonTypeRoundedRect];
        [_uploadBtn addTarget:self action:@selector(uploadBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_uploadBtn setTitle:@"结束" forState:UIControlStateNormal];
        [_uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *uploadImg = [UIImage imageNamed:@"end"];
        uploadImg = [uploadImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_uploadBtn setImage:uploadImg forState:UIControlStateNormal];
        _uploadBtn.layer.borderWidth = 3;
        _uploadBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _uploadBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _uploadBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_uploadBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        _uploadBtn.backgroundColor = [UIColor redColor];
        _uploadBtn.enabled = NO;
        _uploadBtn.hidden = YES;
        [self addSubview:_uploadBtn];
        
        
        _pauseBtnView = [[PauseBtnView alloc]init];
        _pauseBtnView.timeLabel.text = @"00:00";
        _pauseBtnView.hidden = YES;
        [self addSubview:_pauseBtnView];
        
        __weak typeof(self)weakSelf = self;
        _pauseBtnView.pause = ^(){
            weakSelf.pause();
        };
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    CGFloat padding = 10;
    CGFloat topspace = 5;
    CGFloat linespace = 3;
    //recorderBtn,uploadBtn,pauseBtn都是宽度是高度的1.5倍
    _recorderBtn.frame = CGRectMake(viewW - 1.5*viewH, 0, 1.5*viewH, viewH);
    _uploadBtn.frame = CGRectMake(viewW - 1.5*viewH, 0, 1.5*viewH, viewH);
    _pauseBtnView.frame = CGRectMake(viewW - 1.5*viewH, 0, 1.5*viewH, viewH);
    _uploadBtn.layer.cornerRadius = viewH*0.2;
    _recorderBtn.layer.cornerRadius = viewH*0.2;
    
    CGRect recordBtnImageViewFrame = CGRectMake(0, topspace, viewH * 0.75, viewH - 2 * topspace);
    CGRect recordBtnTitleLabelFrame = CGRectMake(viewH*0.75 - padding / 2.0, 0, viewH*0.75, viewH);
    [_recorderBtn setImageViewFrame:recordBtnImageViewFrame titleLabelFrame:recordBtnTitleLabelFrame];
    
    CGRect uploadBtnImageViewFrame = CGRectMake(0, topspace, viewH * 0.75, viewH - 2 * topspace);
    CGRect uploadBtnTitleLabelFrame = CGRectMake(viewH*0.75 - padding / 2.0, 0, viewH*0.75, viewH);
    [_uploadBtn setImageViewFrame:uploadBtnImageViewFrame titleLabelFrame:uploadBtnTitleLabelFrame];

}

-(void)recoderBtnClicked{
    
    _uploadBtn.hidden = NO;
    _uploadBtn.enabled = YES;

    _pauseBtnView.hidden = NO;
    
    _recorderBtn.hidden = YES;
    _recorderBtn.enabled = NO;
    
    CGRect newPauseBtnFrame = _pauseBtnView.frame;
    newPauseBtnFrame.origin.x -= (_pauseBtnView.frame.size.width + 5);
    // 暂停（包括计时）按钮的出场动画
    [UIView animateWithDuration:0.3 animations:^{
        self->_pauseBtnView.frame = newPauseBtnFrame;
    }completion:^(BOOL success){
        if (success) {
            [self->_pauseBtnView addTimer];
        }
    }];
    // 此record指针所指内容在ViewController中的实例中赋予
    self.record();
}

-(void)uploadBtnClicked{
    [_pauseBtnView removeTimer];       //确定录音时间，上传需要此数据
    // 此upload指针所指内容在ViewController中的实例中赋予
    self.upload();
}

- (void)uploadSuccessWithAnimate{
    
    CGRect newPauseBtnFrame = _pauseBtnView.frame;
    newPauseBtnFrame.origin.x += (_pauseBtnView.frame.size.width+5);
    // 暂停按钮的退场动画
    [UIView animateWithDuration:0.3 animations:^{
        self->_pauseBtnView.frame = newPauseBtnFrame;
    } completion:^(BOOL success){
        if(success){
            self->_uploadBtn.hidden = YES;
            self->_uploadBtn.enabled = NO;
            
            self->_pauseBtnView.hidden = YES;
            
            self->_recorderBtn.hidden = NO;
            self->_recorderBtn.enabled = YES;
        }
    }];
}

#pragma mark 抖动动画

- (void)beginShaking{
    //创建动画
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"position";
    
    CGFloat padding = 25;
    CGPoint upPoint = CGPointMake(self.frame.size.width - self.bounds.size.height * 0.75, _recorderBtn.frame.origin.y + self.bounds.size.height/2.0 + padding);
    CGPoint downPoint = CGPointMake(self.frame.size.width - self.bounds.size.height * 0.75, _recorderBtn.frame.origin.y+ self.bounds.size.height/2.0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:downPoint];
    [path addLineToPoint:upPoint];
    [path addLineToPoint:downPoint];
    
    keyAnimaion.duration = 0.4f;
    keyAnimaion.repeatCount = 2;
    keyAnimaion.path = path.CGPath;
    
    [self.recorderBtn.layer addAnimation:keyAnimaion forKey:@"UploadView_Shaking"];
    
    [_recorderBtn setBackgroundColor:[UIColor redColor]];
    [self performSelector:@selector(setRecorderButtonColorAfterShaking) withObject:nil afterDelay:0.8];
}

- (void)setRecorderButtonColorAfterShaking{
    
    [_recorderBtn setBackgroundColor:[UIColor redColor]];
    //[_recorderBtn setBackgroundColor:[UIColor colorWithRed:29/255.0 green:30/255.0 blue:33/255.0 alpha:1]];
}

- (void)stopShaking{
    [self.recorderBtn.layer removeAllAnimations];
}

@end
