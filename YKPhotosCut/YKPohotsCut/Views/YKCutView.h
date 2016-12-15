//
//  YKCutView.h
//  BeautyArtifact
//
//  Created by 王豫凯 on 16/10/13.
//  Copyright © 2016年 谢建荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKCutView : UIView

@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIImageView *leftTopImage;
@property (nonatomic, strong) UIImageView *rightTopImage;
@property (nonatomic, strong) UIImageView *leftBottomImage;
@property (nonatomic, strong) UIImageView *rightBottomImage;
@property (nonatomic, strong) UIView *emptyView;

- (void)sizeFitFourCorner;

@end
