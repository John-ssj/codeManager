
// 顶部栏

#import "EditHeaderView.h"

@implementation EditHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:253.0/255.0 blue:253.0/255.0 alpha:1.0];
        
        self.titleLab = [[UILabel alloc]init];
        [self addSubview:self.titleLab];
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.backBtn setBackgroundImage:[UIImage imageNamed:@"back-1"] forState:UIControlStateNormal];
        [self.backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backBtn];
        
        _gradient = [CAGradientLayer layer];
        _gradient.colors = @[(id)[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1].CGColor , (id)[UIColor whiteColor].CGColor];
        //  设置三种颜色变化点，取值范围 0.0~1.0
        _gradient.locations = @[@(0.0f) ,@(1.0f)];
        //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        _gradient.startPoint = CGPointMake(0, 0);
        _gradient.endPoint = CGPointMake(0, 1);
        //  添加渐变色到创建的 UIView 上去
        [self.layer insertSublayer:_gradient atIndex:0];
        
        
        self.liveSwith = [[UISwitch alloc] init];
        [self addSubview:_liveSwith];
        [self.liveSwith setOn:false];
        [self.liveSwith addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        
        self.liveLabel = [[UILabel alloc] init];
        [self addSubview:_liveLabel];
        self.liveLabel.text = @"同屏";
        _liveLabel.textAlignment = NSTextAlignmentCenter;
        
//        self.liveSwith.hidden = YES;
//        self.liveLabel.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    CGFloat lableW = 400;
    CGFloat padding = 10;
    CGFloat maskH = 5;
    
    self.titleLab.frame = CGRectMake((viewW - lableW)/2.0, 0, lableW, viewH);
    self.titleLab.center = self.center;
    self.titleLab.text = @"示例";
    self.backBtn.frame = CGRectMake(padding + 65, padding+5, 69, 36);
    self.gradient.frame = CGRectMake(0, viewH - maskH, viewW, maskH);
    self.liveSwith.frame = CGRectMake(self.backBtn.frame.origin.x + 100, 0, 0, 0);
    self.liveLabel.frame = CGRectMake(self.backBtn.frame.origin.x + 100, 33, self.liveSwith.frame.size.width, 20);
}

- (void)backBtnClicked{
    // 返回键的功能，暂时先不写
//    self.pop();
}

- (void)switchChanged:(UISwitch *)sender {
    self.switchStateChangedBlock(sender.isOn, YES);
}

@end
