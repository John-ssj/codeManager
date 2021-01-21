//
//  PauseBtnView.m
//  LightMooc
//
//  Created by 魏大同 on 2018/3/29.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import "PauseBtnView.h"
#import "TimeTools.h"

#define CR 0.2
#define PAUSE_DURATION_ARRAY_NOTIFICATION @"pauseDurationArrayNotification"
#define PAUSE_OR_NOT_NOTIFICATION @"pauseOrNotNotification"

@interface PauseBtnView()
//开始暂停的时刻
@property (nonatomic, assign)NSTimeInterval startPauseTimeInterval;
//结束暂停的时刻，两者相减就得出暂停的准确时间
@property (nonatomic, assign)NSTimeInterval endPauseTimeInterval;
//这个数组专门用来保存暂停的时间，每一个暂停的时间为一个元素
@property (nonatomic, strong)NSMutableArray *pauseDurationArray;

@end

@implementation PauseBtnView{
    UIView *bgView;
    UIView *btnView;
    NSTimeInterval _timeInterval;
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.clipsToBounds = YES;
        self.isBackFromPause = NO;
        
        bgView = [[UIView alloc]init];
        bgView.clipsToBounds = YES;
        [self addSubview:bgView];
        
        _gradient = [CAGradientLayer layer];
        _gradient.colors = @[(id)[UIColor grayColor].CGColor , (id)[UIColor grayColor].CGColor];
        _gradient.locations = @[@(0.0f) ,@(1.0f)];
        _gradient.startPoint = CGPointMake(1, 1);
        _gradient.endPoint = CGPointMake(0, 0);
        [bgView.layer insertSublayer:_gradient atIndex:0];
        
        _gradient1 = [CAGradientLayer layer];
        _gradient1.colors = @[(id)[UIColor grayColor].CGColor , (id)[UIColor grayColor].CGColor];
        _gradient1.locations = @[@(0.0f) ,@(1.0f)];
        _gradient1.startPoint = CGPointMake(1, 0);
        _gradient1.endPoint = CGPointMake(0, 1);
        [bgView.layer insertSublayer:_gradient1 atIndex:0];
        
        _gradient2 = [CAGradientLayer layer];
        _gradient2.colors = @[(id)[UIColor grayColor].CGColor , (id)[UIColor grayColor].CGColor];
        _gradient2.locations = @[@(0.0f) ,@(1.0f)];
        _gradient2.startPoint = CGPointMake(0, 1);
        _gradient2.endPoint = CGPointMake(1, 0);
        [bgView.layer insertSublayer:_gradient2 atIndex:0];
        
        _gradient3 = [CAGradientLayer layer];
        _gradient3.colors = @[(id)[UIColor grayColor].CGColor , (id)[UIColor grayColor].CGColor];
        _gradient3.locations = @[@(0.0f) ,@(1.0f)];
        _gradient3.startPoint = CGPointMake(0, 0);
        _gradient3.endPoint = CGPointMake(1, 1);
        [bgView.layer insertSublayer:_gradient3 atIndex:0];
        
        [bgView.layer addAnimation:[self AlphaLight:1] forKey:@"aAlpha"];
        
        btnView = [[UIView alloc]init];
        //btnView.backgroundColor = [UIColor colorWithRed:29/255.0 green:30/255.0 blue:33/255.0 alpha:1];
        btnView.backgroundColor = [UIColor redColor];
        btnView.clipsToBounds = YES;
        [self addSubview:btnView];
        
        _pauseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_pauseBtn addTarget:self action:@selector(pauseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_pauseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *pauseImg = [UIImage imageNamed:@"pause"];
        pauseImg = [pauseImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_pauseBtn setImage:pauseImg forState:UIControlStateNormal];
        [self addSubview:_pauseBtn];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_timeLabel];
        
        _coverBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_coverBtn addTarget:self action:@selector(pauseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_coverBtn setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_coverBtn];
        
        _timeInterval = 0;
        
        self.pauseDurationArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    CGFloat padding = 10;
    CGFloat btnWH = 20;
    
    self.layer.cornerRadius = viewH*CR;
    
    _gradient.frame = CGRectMake(0, 0, viewW*0.5, viewH*0.5);
    _gradient1.frame = CGRectMake(0, viewH*0.5, viewW*0.5, viewH*0.5);
    _gradient2.frame = CGRectMake(viewW*0.5, 0, viewW*0.5, viewH*0.5);
    _gradient3.frame = CGRectMake(viewW*0.5, viewH*0.5, viewW*0.5, viewH*0.5);
    
    btnView.layer.cornerRadius = (viewH - padding - padding)*CR;
    btnView.frame = CGRectMake(3, 3, viewW - 6, viewH - 6);
    
    bgView.frame = CGRectMake(0, 0, viewW, viewH);
    bgView.layer.cornerRadius = viewH*CR;
    
    _pauseBtn.frame = CGRectMake(5, 15, btnWH, btnWH);
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_pauseBtn.frame), 0, viewW-btnWH-padding, viewH);
    
    _coverBtn.frame = CGRectMake(0, 0, viewW, viewH);
}

-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setTimeLabelText) userInfo:nil repeats:YES];
    _timeInterval = 0.0;
}
-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
    _duration = [NSString stringWithFormat:@"%g",_timeInterval];
    
    _timeInterval = 0;
    _timeLabel.text = @"00:00";
    
    [self.pauseDurationArray removeAllObjects];
    
}
- (void)setTimeLabelText{

    _timeInterval += 1;
    //这里的if语句是为了解决连续点击暂停录音时间直线增加的问题
    if(_isBackFromPause){
        
        _timeInterval -= 1;
        _isBackFromPause = NO;
    }
    _timeLabel.text = [TimeTools getTimeStringWithTimeInterval:_timeInterval];
}

- (void)pauseBtnClicked{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PAUSE_OR_NOT_NOTIFICATION object:nil userInfo:[NSDictionary dictionaryWithObject:@(!_isPause) forKey:PAUSE_OR_NOT_NOTIFICATION]];
    
    if(_isPause){
        _isPause = NO;
        
        _endPauseTimeInterval = [TimeTools getTimeIntervalSince1970];
        NSTimeInterval pauseDuration = _endPauseTimeInterval - _startPauseTimeInterval;
        [self.pauseDurationArray addObject:@(pauseDuration)];
        [[NSNotificationCenter defaultCenter] postNotificationName:PAUSE_DURATION_ARRAY_NOTIFICATION object:nil userInfo:[NSDictionary dictionaryWithObject:self.pauseDurationArray forKey:PAUSE_DURATION_ARRAY_NOTIFICATION]];
        
        UIImage *pauseImg = [UIImage imageNamed:@"pause"];
        pauseImg = [pauseImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_pauseBtn setImage:pauseImg forState:UIControlStateNormal];
        
        //继续timer
        [_timer setFireDate:[NSDate date]];
        //继续动画
        [bgView.layer addAnimation:[self AlphaLight:1] forKey:@"aAlpha"];
        
        self.pause();
        self.isBackFromPause = YES;
        
    }else{
        _isPause = YES;
        
        _startPauseTimeInterval = [TimeTools getTimeIntervalSince1970];
        
        UIImage *pauseImg = [UIImage imageNamed:@"recorder"];
        pauseImg = [pauseImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_pauseBtn setImage:pauseImg forState:UIControlStateNormal];
        
        //暂停timer
        [_timer setFireDate:[NSDate distantFuture]];
        //暂停动画
        [bgView.layer removeAnimationForKey:@"aAlpha"];
        
        self.pause();
    }
    
   
    
}

- (void)setDefault{
    
    UIImage *pauseImg = [UIImage imageNamed:@"pause"];
    pauseImg = [pauseImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_pauseBtn setImage:pauseImg forState:UIControlStateNormal];
}

#pragma mark - 呼吸灯动画
-(CABasicAnimation *) AlphaLight:(float)time
{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
//    animation.fromValue = [NSNumber numberWithFloat:1.0f];
//    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
//    animation.autoreverses = YES;
//    animation.duration = time;
//    animation.repeatCount = MAXFLOAT;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    return animation;
}

@end
