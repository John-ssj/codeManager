//
//  SideBarView.m
//  LightMooc
//
//  Created by 魏大同 on 2017/12/26.
//  Copyright © 2017年 魏大同. All rights reserved.
//

#import "SideBarView.h"
#import "UIImage+ChangeColor.h"


@implementation SideBarView{
    int _draftPaperTag;
    int _tapeViewTag;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor colorWithRed:29/255.0 green:30/255.0 blue:33/255.0 alpha:1];
        _draftPaperTag = 0;
        _tapeViewTag = 0;
    
        _withdrawBtn = [SiderBtn buttonWithType:UIButtonTypeRoundedRect];
        [_withdrawBtn addTarget:self action:@selector(withDrawBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_withdrawBtn setTitle:@"撤回" forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:UIColorFromHex(SiderBarGreen) forState:UIControlStateHighlighted];
        UIImage *withdrawImg = [UIImage imageNamed:@"withdraw"];
        withdrawImg = [withdrawImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *inWithdrawImg = [UIImage imageNamed:@"inwithdraw"];
        inWithdrawImg = [inWithdrawImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_withdrawBtn setImage:withdrawImg forState:UIControlStateNormal];
        [_withdrawBtn setImage:inWithdrawImg forState:UIControlStateHighlighted];
        [self addSubview:_withdrawBtn];
        
        _cutBtn = [SiderBtn buttonWithType:UIButtonTypeRoundedRect];
        [_cutBtn addTarget:self action:@selector(cutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_cutBtn setTitle:@"剪除" forState:UIControlStateNormal];
        [_cutBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        UIImage *cutImg = [UIImage imageNamed:@"cut"];
        cutImg = [cutImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_cutBtn setImage:cutImg forState:UIControlStateNormal];
        [self addSubview:_cutBtn];
        
        _eraserBtn = [SiderBtn buttonWithType:UIButtonTypeRoundedRect];
        [_eraserBtn addTarget:self action:@selector(eraserBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_eraserBtn setTitle:@"橡皮" forState:UIControlStateNormal];
        [_eraserBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        UIImage *eraserImg = [UIImage imageNamed:@"eraser"];
        eraserImg = [eraserImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_eraserBtn setImage:eraserImg forState:UIControlStateNormal];
        [self addSubview:_eraserBtn];
        
        _pathBtn = [SiderBtn buttonWithType:UIButtonTypeRoundedRect];
        [_pathBtn addTarget:self action:@selector(pathBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_pathBtn setTitle:@"书写" forState:UIControlStateNormal];
        [_pathBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        UIImage *pathImg = [UIImage imageNamed:@"pencil"];
        pathImg = [pathImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_pathBtn setImage:pathImg forState:UIControlStateNormal];
        [self addSubview:_pathBtn];
        
        _lineAndWavyLineBtn = [SiderBtn buttonWithType:UIButtonTypeRoundedRect];
        [_lineAndWavyLineBtn addTarget:self action:@selector(lineAndWavyLineBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_lineAndWavyLineBtn setTitle:@"线条" forState:UIControlStateNormal];
        [_lineAndWavyLineBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        [_lineAndWavyLineBtn setTitleColor:UIColorFromHex(SiderBarGreen) forState:UIControlStateSelected];
        UIImage *lineAndWavyLineImg = [UIImage imageNamed:@"ruler"];
        lineAndWavyLineImg = [lineAndWavyLineImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_lineAndWavyLineBtn setImage:lineAndWavyLineImg forState:UIControlStateNormal];
        [self addSubview:_lineAndWavyLineBtn];
        
        _arrowBtn = [SiderBtn buttonWithType:UIButtonTypeRoundedRect];
        [_arrowBtn addTarget:self action:@selector(arrowBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_arrowBtn setTitle:@"箭头" forState:UIControlStateNormal];
        [_arrowBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        UIImage *arrowImg = [UIImage imageNamed:@"arrow"];
        arrowImg = [arrowImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_arrowBtn setImage:arrowImg forState:UIControlStateNormal];
        [self addSubview:_arrowBtn];
        
        _clearBtn = [SiderBtn buttonWithType:UIButtonTypeRoundedRect];
        [_clearBtn addTarget:self action:@selector(clearBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_clearBtn setTitle:@"清空" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        [_clearBtn setTitleColor:UIColorFromHex(SiderBarGreen) forState:UIControlStateHighlighted];
        UIImage *clearImg = [UIImage imageNamed:@"clearpage"];
        clearImg = [clearImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_clearBtn setImage:clearImg forState:UIControlStateNormal];
        UIImage *clearImg_sel = [UIImage imageNamed:@"clearpage_sel"];
        clearImg_sel = [clearImg_sel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_clearBtn setImage:clearImg_sel forState:UIControlStateHighlighted];
        [self addSubview:_clearBtn];
        
        
        _pointerBtn = [SiderBtn buttonWithType:UIButtonTypeRoundedRect];
        [_pointerBtn addTarget:self action:@selector(pointerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_pointerBtn setTitle:@"教鞭" forState:UIControlStateNormal];
        [_pointerBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        UIImage *pointerImg = [UIImage imageNamed:@"pointer"];
        pointerImg = [pointerImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_pointerBtn setImage:pointerImg forState:UIControlStateNormal];
        [self addSubview:_pointerBtn];
         
        
        _draftPaperBtn = [SiderBtn buttonWithType:UIButtonTypeRoundedRect];
        [_draftPaperBtn addTarget:self action:@selector(draftPaperBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_draftPaperBtn setTitle:@"草稿" forState:UIControlStateNormal];
        [_draftPaperBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        UIImage *draftImg = [UIImage imageNamed:@"draft"];
        draftImg = [draftImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_draftPaperBtn setImage:draftImg forState:UIControlStateNormal];
        [self addSubview:_draftPaperBtn];
        
        _logoIV = [[UIImageView alloc]init];
        _logoIV.image = [UIImage imageNamed:@"logo"];
        [self addSubview:_logoIV];
        
        _tapeBtn = [[SiderBtn alloc]init];
        [_tapeBtn addTarget:self action:@selector(tapeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_tapeBtn setTitle:@"录音" forState:UIControlStateNormal];
        [_tapeBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        UIImage *tapeImg = [UIImage imageNamed:@"tape"];
        tapeImg = [tapeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_tapeBtn setImage:tapeImg forState:UIControlStateNormal];
        [self addSubview:_tapeBtn];
        
        _qrcodeBtn = [[SiderBtn alloc] init];
        [_qrcodeBtn addTarget:self action:@selector(qrcodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_qrcodeBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_qrcodeBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"小qr-code"];
        [_qrcodeBtn setImage:[image imageChangeColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0]] forState:UIControlStateNormal];
        [self addSubview:_qrcodeBtn];
        
        _insertBtn = [[SiderBtn alloc] init];
        [_insertBtn addTarget:self action:@selector(insetBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_insertBtn setTitle:@"插入" forState:UIControlStateNormal];
        [_insertBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
        UIImage *insertBtnImage = [UIImage imageNamed:@"insert"];
        [_insertBtn setImage:[insertBtnImage imageChangeColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0]] forState:UIControlStateNormal];
        [self addSubview:_insertBtn];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat space = 0;
    CGFloat width = self.bounds.size.width - space;
    CGFloat height  = self.bounds.size.height;
    
    _logoIV.frame = CGRectMake(5, 10, 50, 50);
    _withdrawBtn.frame = CGRectMake(space, 7*padding, width, BtnH);
    _cutBtn.frame = CGRectMake(space, CGRectGetMaxY(_withdrawBtn.frame)+padding, width, BtnH);
    _eraserBtn.frame = CGRectMake(space, CGRectGetMaxY(_cutBtn.frame)+padding, width, BtnH);
    _pathBtn.frame = CGRectMake(space, CGRectGetMaxY(_eraserBtn.frame)+padding, width, BtnH);
    _lineAndWavyLineBtn.frame = CGRectMake(space, CGRectGetMaxY(_pathBtn.frame)+padding, width, BtnH);
    _arrowBtn.frame = CGRectMake(space, CGRectGetMaxY(_lineAndWavyLineBtn.frame)+padding, width, BtnH);
    _pointerBtn.frame = CGRectMake(space, CGRectGetMaxY(_arrowBtn.frame)+padding, width, BtnH);
    _clearBtn.frame = CGRectMake(space, CGRectGetMaxY(_pointerBtn.frame)+padding, width, BtnH);
    _draftPaperBtn.frame = CGRectMake(space, CGRectGetMaxY(_clearBtn.frame)+padding, width, BtnH);
    _tapeBtn.frame = CGRectMake(space, height-BtnH-padding, width, BtnH);
    _qrcodeBtn.frame = CGRectMake(space, CGRectGetMinY(_tapeBtn.frame)-padding-BtnH, width, BtnH);
    _insertBtn.frame = CGRectMake(space, CGRectGetMinY(_qrcodeBtn.frame)-padding-BtnH, width, BtnH);
    
}

#pragma mark BtnClicked方法

//子函数内顺序不可变
-(void)withDrawBtnClicked{
    [self.myDelegate SideBtnClickedWithTag:@"withdraw"];
}
-(void)cutBtnClicked{
    [self changeBtnImgWithTag:_cutBtn];
    [self.myDelegate SideBtnClickedWithTag:@"cut"];
}
-(void)eraserBtnClicked{
    [self changeBtnImgWithTag:_eraserBtn];
    [self.myDelegate SideBtnClickedWithTag:@"eraser"];
}
-(void)pathBtnClicked{
    [self changeBtnImgWithTag:_pathBtn];
    [self.myDelegate SideBtnClickedWithTag:@"path"];
    
}
-(void)arrowBtnClicked{
    [self changeBtnImgWithTag:_arrowBtn];
    [self.myDelegate SideBtnClickedWithTag:@"arrow"];
    
}

- (void)lineAndWavyLineBtnClicked
{
    [self changeBtnImgWithTag:_lineAndWavyLineBtn];
    [self.myDelegate SideBtnClickedWithTag:@"lineAndWavyLine"];
    _lineAndWavyLineBtn.selected = YES;
}



- (void)clearBtnClicked
{
    [self.myDelegate SideBtnClickedWithTag:@"clear"];
}

- (void)pointerBtnClicked
{
    [self changeBtnImgWithTag:_pointerBtn];
    [self.myDelegate SideBtnClickedWithTag:@"pointer"];
}

-(void)draftPaperBtnClicked{
    
    _draftPaperTag++;
    if (_draftPaperTag%2) {
        [self changeBtnImgWithTag:_draftPaperBtn];
    }else{
        [self changeBtnImgWithTag:nil];
    }
    
    [self.myDelegate SideBtnClickedWithTag:@"draft"];
}
-(void)tapeBtnClicked{
    
    [self.myDelegate SideBtnClickedWithTag:@"tape"];
}

- (void)qrcodeBtnClicked{
    
    [self.myDelegate SideBtnClickedWithTag:@"qrcode"];
}

- (void)insetBtnClicked
{
    [self.myDelegate SideBtnClickedWithTag:@"insert"];
}

- (void)hideQRButtonAndTapeButton{
    
    _qrcodeBtn.hidden = YES;
    _tapeBtn.hidden = YES;
    _insertBtn.hidden = YES;
}

- (void)showQRButtonAndTapeButton{
    
    _qrcodeBtn.hidden = NO;
    _tapeBtn.hidden = NO;
    _insertBtn.hidden = NO;
}

- (void)hideButton{
    
    _withdrawBtn.hidden = YES;
    _cutBtn.hidden = YES;
    _eraserBtn.hidden = YES;
    _pathBtn.hidden = YES;
    _arrowBtn.hidden = YES;
    _draftPaperBtn.hidden = YES;
    _clearBtn.hidden = YES;
    _pointerBtn.hidden = YES;
    _lineAndWavyLineBtn.hidden = YES;
    
    _qrcodeBtn.hidden = NO;
    _tapeBtn.hidden = NO;
    _insertBtn.hidden = NO;
}

- (void)showButton{
    
    _withdrawBtn.hidden = NO;
    _cutBtn.hidden = NO;
    _eraserBtn.hidden = NO;
    _pathBtn.hidden = NO;
    _arrowBtn.hidden = NO;
    _draftPaperBtn.hidden = NO;
    _clearBtn.hidden = NO;
    _pointerBtn.hidden = NO;
    _lineAndWavyLineBtn.hidden = NO;
    
    _qrcodeBtn.hidden = YES;
    _tapeBtn.hidden = YES;
    _insertBtn.hidden = YES;
}

- (void)changeBtnImgWithTag:(SiderBtn *)btn{
    
    UIImage *withdrawImg = [UIImage imageNamed:@"withdraw"];
    withdrawImg = [withdrawImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_withdrawBtn setImage:withdrawImg forState:UIControlStateNormal andImgName:@"withdraw"];
    [_withdrawBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
    
    UIImage *cutImg = [UIImage imageNamed:@"cut"];
    cutImg = [cutImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_cutBtn setImage:cutImg forState:UIControlStateNormal andImgName:@"cut"];
    [_cutBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
    
    UIImage *eraserImg = [UIImage imageNamed:@"eraser"];
    eraserImg = [eraserImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_eraserBtn setImage:eraserImg forState:UIControlStateNormal andImgName:@"eraser"];
    [_eraserBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
    
    UIImage *pathImg = [UIImage imageNamed:@"pencil"];
    pathImg = [pathImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_pathBtn setImage:pathImg forState:UIControlStateNormal andImgName:@"pencil"];
    [_pathBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
    
    UIImage *arrowImg = [UIImage imageNamed:@"arrow"];
    arrowImg = [arrowImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_arrowBtn setImage:arrowImg forState:UIControlStateNormal andImgName:@"arrow"];
    [_arrowBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
    
    UIImage *draftImg = [UIImage imageNamed:@"draft"];
    draftImg = [draftImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_draftPaperBtn setImage:draftImg forState:UIControlStateNormal andImgName:@"draft"];
    [_draftPaperBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
    
    UIImage *tapeImg = [UIImage imageNamed:@"tape"];
    tapeImg = [tapeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_tapeBtn setImage:tapeImg forState:UIControlStateNormal andImgName:@"tape"];
    [_tapeBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
    
    UIImage *pointerImg = [UIImage imageNamed:@"pointer"];
    pointerImg = [pointerImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_pointerBtn setImage:pointerImg forState:UIControlStateNormal andImgName:@"pointer"];
    [_pointerBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
    
    UIImage *lineAndWavyLineImg = [UIImage imageNamed:@"ruler"];
    lineAndWavyLineImg = [lineAndWavyLineImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_lineAndWavyLineBtn setImage:lineAndWavyLineImg forState:UIControlStateNormal andImgName:@"ruler"];
    [_lineAndWavyLineBtn setTitleColor:UIColorFromHex(SiderBarGlary) forState:UIControlStateNormal];
    if (btn != _lineAndWavyLineBtn) {
        _lineAndWavyLineBtn.selected = NO;
    }
    
    UIImage *btnImg = [UIImage imageNamed:[NSString stringWithFormat:@"in%@",btn.btnImgName]];
    btnImg = [btnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:btnImg forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromHex(SiderBarGreen) forState:UIControlStateNormal];
    
}

@end
