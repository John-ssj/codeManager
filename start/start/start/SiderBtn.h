//
//  SiderBtn.h
//  LightMooc
//
//  Created by 魏大同 on 2018/3/23.
//  Copyright © 2018年 魏大同. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SiderBtn : UIButton

@property (nonatomic, copy) NSString *btnImgName;

- (void)setImage:(UIImage *)image forState:(UIControlState)state andImgName:(NSString *)imgName;

@end
