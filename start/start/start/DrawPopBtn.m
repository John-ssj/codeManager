//
//  DrawPopBtn.m
//  LightMooc
//
//  Created by 魏大同 on 2018/4/4.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import "DrawPopBtn.h"


@implementation DrawPopBtn

- (instancetype)initWithBtnTag:(NSString *)tag{
    if (self = [super init]) {
        self.btnTag = tag;
        self.backgroundColor =[UIColor clearColor];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    CGFloat padding = 10;
    CGFloat colorIXY = 2;
    CGFloat colorIWH = viewW - 4;
    
    
    if ([self.btnTag isEqualToString:@"strong"]) {
        self.imageView.frame = CGRectMake(0.5*padding, 0.5*padding, viewW - padding, viewH - padding);
        self.imageView.layer.cornerRadius = (viewW - padding)*0.5;
    }else if ([self.btnTag isEqualToString:@"middle"]){
        self.imageView.frame = CGRectMake(padding, padding, viewW - 2*padding, viewH - 2*padding);
        self.imageView.layer.cornerRadius = (viewW - 2*padding)*0.5;
    }else if ([self.btnTag isEqualToString:@"thin"]){
        self.imageView.frame = CGRectMake(1.5*padding, 1.5*padding, viewW - 3*padding, viewH - 3*padding);
        self.imageView.layer.cornerRadius = (viewW - 3*padding)*0.5;
    }else if ([self.btnTag isEqualToString:@"black"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"red"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"blue"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"green"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"yellow"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"magenta"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"orange"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"purple"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"brown"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"white"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else if ([self.btnTag isEqualToString:@"gray"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;;
    }else if ([self.btnTag isEqualToString:@"cyan"]){
        self.imageView.frame = CGRectMake(colorIXY, colorIXY, colorIWH, colorIWH);
        self.imageView.layer.cornerRadius = colorIWH*0.5;
    }else{
        
    }
}


@end
