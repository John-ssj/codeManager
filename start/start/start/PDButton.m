//
//  PDButton.m
//  LightMooc
//
//  Created by pdd on 2018/10/11.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import "PDButton.h"

@interface PDButton()

@property (nonatomic, assign)CGRect imageViewFrame;
@property (nonatomic, assign)CGRect titleLableFrame;

@end

@implementation PDButton

- (void)setImageViewFrame:(CGRect)imageViewFrame titleLabelFrame:(CGRect)titleLabelFrame{
    
    _imageViewFrame = imageViewFrame;
    _titleLableFrame = titleLabelFrame;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = _imageViewFrame;
    self.titleLabel.frame = _titleLableFrame;
}
@end
