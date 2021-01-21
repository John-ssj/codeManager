//
//  DrawPopView.m
//  LightMooc
//
//  Created by 魏大同 on 2018/3/26.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import "DrawPopView.h"

#define BtnWH 40
#define padding 10

@interface DrawPopView ()



@end

@implementation DrawPopView

- (instancetype)initWithMainViewFrame:(CGRect)frame{
    if (self = [super init]) {
        _mainView = [[UIView alloc]init];
        _mainView.frame = frame;
        _mainView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.95];
        [_mainView.layer setMasksToBounds:YES];
        [_mainView.layer setBorderColor:[UIColor colorWithRed:29/255.0 green:30/255.0 blue:33/255.0 alpha:1].CGColor];
        [_mainView.layer setBorderWidth:2];
        _mainView.layer.cornerRadius = frame.size.width * 0.1;
        [self addSubview:_mainView];
        
        _thinLineBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _thinLineBtn.btnTag = @"thin";
        [_thinLineBtn setImage:[self createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        [_thinLineBtn addTarget:self action:@selector(thinBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_thinLineBtn];
        
        _middleLineBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _middleLineBtn.btnTag = @"middle";
        [_middleLineBtn setImage:[self createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        [_middleLineBtn addTarget:self action:@selector(middleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_middleLineBtn];
        
        _strongLineBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _strongLineBtn.btnTag = @"strong";
        [_strongLineBtn setImage:[self createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        [_strongLineBtn addTarget:self action:@selector(strongBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_strongLineBtn];
        
        _redColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _redColorBtn.btnTag = @"red";
        [_redColorBtn setImage:[self createImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [_redColorBtn addTarget:self action:@selector(redBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_redColorBtn];
        
        _blueColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _blueColorBtn.btnTag = @"blue";
        [_blueColorBtn setImage:[self createImageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
        [_blueColorBtn addTarget:self action:@selector(blueBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_blueColorBtn];
        
        _blackColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _blackColorBtn.btnTag = @"black";
        [_blackColorBtn setImage:[self createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        [_blackColorBtn addTarget:self action:@selector(blackBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_blackColorBtn];
        
        _brownColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _brownColorBtn.btnTag = @"brown";
        [_brownColorBtn setImage:[self createImageWithColor:[UIColor brownColor]] forState:UIControlStateNormal];
        [_brownColorBtn addTarget:self action:@selector(brownBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_brownColorBtn];
        
        _purpleColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _purpleColorBtn.btnTag = @"purple";
        [_purpleColorBtn setImage:[self createImageWithColor:[UIColor purpleColor]] forState:UIControlStateNormal];
        [_purpleColorBtn addTarget:self action:@selector(purpleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_purpleColorBtn];
        
        _orangeColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _orangeColorBtn.btnTag = @"orange";
        [_orangeColorBtn setImage:[self createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        [_orangeColorBtn addTarget:self action:@selector(orangeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_orangeColorBtn];
        
        _cyanColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _cyanColorBtn.btnTag = @"cyan";
        [_cyanColorBtn setImage:[self createImageWithColor:[UIColor cyanColor]] forState:UIControlStateNormal];
        [_cyanColorBtn addTarget:self action:@selector(cyanBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_cyanColorBtn];
        
        _greenColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _greenColorBtn.btnTag = @"green";
        [_greenColorBtn setImage:[self createImageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
        [_greenColorBtn addTarget:self action:@selector(greenBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_greenColorBtn];
        
        _magentaColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _magentaColorBtn.btnTag = @"magenta";
        [_magentaColorBtn setImage:[self createImageWithColor:[UIColor magentaColor]] forState:UIControlStateNormal];
        [_magentaColorBtn addTarget:self action:@selector(magentaBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_magentaColorBtn];
        
        _grayColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _grayColorBtn.btnTag = @"gray";
        [_grayColorBtn setImage:[self createImageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
        [_grayColorBtn addTarget:self action:@selector(grayBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_grayColorBtn];
        
        _yellowColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _yellowColorBtn.btnTag = @"yellow";
        [_yellowColorBtn setImage:[self createImageWithColor:[UIColor yellowColor]] forState:UIControlStateNormal];
        [_yellowColorBtn addTarget:self action:@selector(darkGrayBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_yellowColorBtn];
        
        _whiteColorBtn = [DrawPopBtn buttonWithType:UIButtonTypeRoundedRect];
        _whiteColorBtn.btnTag = @"white";
        [_whiteColorBtn setImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_whiteColorBtn addTarget:self action:@selector(whiteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:_whiteColorBtn];
        
        //初始线宽和颜色
        [self setPathBtnLayerWithTag:@"thin"];
        [self setColorBtnLayerWithTag:@"red"];
        
    }
    return self;
}

- (void)setDefault{
    
    [self setPathBtnLayerWithTag:@"thin"];
    [self setColorBtnLayerWithTag:@"red"];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewW = _mainView.frame.size.width;
    
    _thinLineBtn.frame = CGRectMake(0.5*(viewW - BtnWH*3 - padding*2), padding, BtnWH, BtnWH);
    _middleLineBtn.frame = CGRectMake(CGRectGetMaxX(_thinLineBtn.frame)+padding, padding, BtnWH, BtnWH);
    _strongLineBtn.frame = CGRectMake(CGRectGetMaxX(_middleLineBtn.frame)+padding, padding, BtnWH, BtnWH);
    
    _redColorBtn.frame = CGRectMake(0.5*(viewW - BtnWH*4 - padding*3), CGRectGetMaxY(_thinLineBtn.frame)+2*padding, BtnWH, BtnWH);
    _blueColorBtn.frame = CGRectMake(CGRectGetMaxX(_redColorBtn.frame)+padding, _redColorBtn.frame.origin.y, BtnWH, BtnWH);
    _blackColorBtn.frame = CGRectMake(CGRectGetMaxX(_blueColorBtn.frame)+padding, _redColorBtn.frame.origin.y, BtnWH, BtnWH);
    _brownColorBtn.frame = CGRectMake(CGRectGetMaxX(_blackColorBtn.frame)+padding, _redColorBtn.frame.origin.y, BtnWH, BtnWH);
    
    _purpleColorBtn.frame = CGRectMake(0.5*(viewW - BtnWH*4 - padding*3), CGRectGetMaxY(_redColorBtn.frame)+padding, BtnWH, BtnWH);
    _orangeColorBtn.frame = CGRectMake(CGRectGetMaxX(_purpleColorBtn.frame)+padding, CGRectGetMaxY(_redColorBtn.frame)+padding, BtnWH, BtnWH);
    _cyanColorBtn.frame = CGRectMake(CGRectGetMaxX(_orangeColorBtn.frame)+padding, CGRectGetMaxY(_redColorBtn.frame)+padding, BtnWH, BtnWH);
    _greenColorBtn.frame = CGRectMake(CGRectGetMaxX(_cyanColorBtn.frame)+padding, CGRectGetMaxY(_redColorBtn.frame)+padding, BtnWH, BtnWH);
    
    _magentaColorBtn.frame = CGRectMake(0.5*(viewW - BtnWH*4 - padding*3), CGRectGetMaxY(_purpleColorBtn.frame)+padding, BtnWH, BtnWH);
    _grayColorBtn.frame = CGRectMake(CGRectGetMaxX(_magentaColorBtn.frame)+padding, CGRectGetMaxY(_purpleColorBtn.frame)+padding, BtnWH, BtnWH);
    _yellowColorBtn.frame = CGRectMake(CGRectGetMaxX(_grayColorBtn.frame)+padding, CGRectGetMaxY(_purpleColorBtn.frame)+padding, BtnWH, BtnWH);
    _whiteColorBtn.frame = CGRectMake(CGRectGetMaxX(_yellowColorBtn.frame)+padding, CGRectGetMaxY(_purpleColorBtn.frame)+padding, BtnWH, BtnWH);
    
}

- (void)thinBtnClicked{
    self.btnClickedWithName(@"thinLine");
    [self setPathBtnLayerWithTag:@"thin"];
}
- (void)middleBtnClicked{
    self.btnClickedWithName(@"middleLine");
    [self setPathBtnLayerWithTag:@"middle"];
}
- (void)strongBtnClicked{
    self.btnClickedWithName(@"strongLine");
    [self setPathBtnLayerWithTag:@"strong"];
}

- (void)redBtnClicked{
    self.btnClickedWithName(@"redColor");
    [self setColorBtnLayerWithTag:@"red"];
}
- (void)blueBtnClicked{
    self.btnClickedWithName(@"blueColor");
    [self setColorBtnLayerWithTag:@"blue"];
}
- (void)blackBtnClicked{
    self.btnClickedWithName(@"blackColor");
    [self setColorBtnLayerWithTag:@"black"];
}
- (void)brownBtnClicked{
    self.btnClickedWithName(@"brownColor");
    [self setColorBtnLayerWithTag:@"brown"];
}

- (void)purpleBtnClicked{
    self.btnClickedWithName(@"purpleColor");
    [self setColorBtnLayerWithTag:@"purple"];
}
- (void)orangeBtnClicked{
    self.btnClickedWithName(@"orangeColor");
    [self setColorBtnLayerWithTag:@"orange"];
}
- (void)cyanBtnClicked{
    self.btnClickedWithName(@"cyanColor");
    [self setColorBtnLayerWithTag:@"cyan"];
}
- (void)greenBtnClicked{
    self.btnClickedWithName(@"greenColor");
    [self setColorBtnLayerWithTag:@"green"];
}

- (void)magentaBtnClicked{
    self.btnClickedWithName(@"magentaColor");
    [self setColorBtnLayerWithTag:@"magenta"];
}
- (void)grayBtnClicked{
    self.btnClickedWithName(@"grayColor");
    [self setColorBtnLayerWithTag:@"gray"];
}
- (void)darkGrayBtnClicked{
    self.btnClickedWithName(@"yellowColor");
    [self setColorBtnLayerWithTag:@"yellow"];
}
- (void)whiteBtnClicked{
    self.btnClickedWithName(@"whiteColor");
    [self setColorBtnLayerWithTag:@"white"];
}


//填充背景图片
-(UIImage*) createImageWithColor:(UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return theImage;
}

//button layer

- (void)setPathBtnLayerWithTag:(NSString *)tag{
    
    [_thinLineBtn.layer setBorderWidth:0];
    [_middleLineBtn.layer setBorderWidth:0];
    [_strongLineBtn.layer setBorderWidth:0];
    
    if ([tag isEqualToString:@"thin"]) {
        _thinLineBtn.layer.cornerRadius = BtnWH*0.5;
        [_thinLineBtn.layer setMasksToBounds:YES];
        [_thinLineBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_thinLineBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"middle"]){
        _middleLineBtn.layer.cornerRadius = BtnWH*0.5;
        [_middleLineBtn.layer setMasksToBounds:YES];
        [_middleLineBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_middleLineBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"strong"]){
        _strongLineBtn.layer.cornerRadius = BtnWH*0.5;
        [_strongLineBtn.layer setMasksToBounds:YES];
        [_strongLineBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_strongLineBtn.layer setBorderWidth:1];
    }
}

- (void)setColorBtnLayerWithTag:(NSString *)tag{
    
    [_redColorBtn.layer setBorderWidth:0];
    [_blueColorBtn.layer setBorderWidth:0];
    [_blackColorBtn.layer setBorderWidth:0];
    [_brownColorBtn.layer setBorderWidth:0];
    [_purpleColorBtn.layer setBorderWidth:0];
    [_orangeColorBtn.layer setBorderWidth:0];
    [_cyanColorBtn.layer setBorderWidth:0];
    [_greenColorBtn.layer setBorderWidth:0];
    [_magentaColorBtn.layer setBorderWidth:0];
    [_grayColorBtn.layer setBorderWidth:0];
    [_yellowColorBtn.layer setBorderWidth:0];
    [_whiteColorBtn.layer setBorderWidth:0];
    
    if ([tag isEqualToString:@"red"]) {
        _redColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_redColorBtn.layer setMasksToBounds:YES];
        [_redColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_redColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"blue"]){
        _blueColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_blueColorBtn.layer setMasksToBounds:YES];
        [_blueColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_blueColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"black"]){
        _blackColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_blackColorBtn.layer setMasksToBounds:YES];
        [_blackColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_blackColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"brown"]){
        _brownColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_brownColorBtn.layer setMasksToBounds:YES];
        [_brownColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_brownColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"purple"]){
        _purpleColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_purpleColorBtn.layer setMasksToBounds:YES];
        [_purpleColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_purpleColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"orange"]){
        _orangeColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_orangeColorBtn.layer setMasksToBounds:YES];
        [_orangeColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_orangeColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"cyan"]){
        _cyanColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_cyanColorBtn.layer setMasksToBounds:YES];
        [_cyanColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_cyanColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"green"]){
        _greenColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_greenColorBtn.layer setMasksToBounds:YES];
        [_greenColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_greenColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"magenta"]){
        _magentaColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_magentaColorBtn.layer setMasksToBounds:YES];
        [_magentaColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_magentaColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"gray"]){
        _grayColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_grayColorBtn.layer setMasksToBounds:YES];
        [_grayColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_grayColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"yellow"]){
        _yellowColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_yellowColorBtn.layer setMasksToBounds:YES];
        [_yellowColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_yellowColorBtn.layer setBorderWidth:1];
    }else if ([tag isEqualToString:@"white"]){
        _whiteColorBtn.layer.cornerRadius = BtnWH*0.5;
        [_whiteColorBtn.layer setMasksToBounds:YES];
        [_whiteColorBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_whiteColorBtn.layer setBorderWidth:1];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if (![touch.view isEqual:_mainView]) {
        self.dissmissView();
    }
    
}

@end
