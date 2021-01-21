//
//  SiderBtn.m
//  LightMooc
//
//  Created by 魏大同 on 2018/3/23.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import "SiderBtn.h"

@implementation SiderBtn


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 设置按钮的其他属性
        self.btnImgName = [NSString string];
        [self setBackgroundColor:[UIColor clearColor]];
        self.tintColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    CGFloat padding = 2;
    CGFloat topSpace = 8;
    
    self.imageView.frame = CGRectMake(padding, topSpace, viewH-2*topSpace, viewH-2*topSpace);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + padding, 0, viewW - self.imageView.frame.size.width - 3 * padding,viewH);
    //self.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightHeavy];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state andImgName:(NSString *)imgName{
    [super setImage:image forState:state];
    self.btnImgName = imgName;
}




@end
