//
//  YKCutView.m
//  BeautyArtifact
//
//  Created by 王豫凯 on 16/10/13.
//  Copyright © 2016年 谢建荣. All rights reserved.
//

#import "YKCutView.h"

@implementation YKCutView

- (void)drawRect:(CGRect)rect {
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config
{
    // 增加
    self.backgroundColor = [UIColor clearColor];
    
    _emptyView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, self.frame.size.width - 16, self.frame.size.height - 16)];
    _emptyView.backgroundColor = [UIColor clearColor];
    _emptyView.layer.borderColor = [UIColor whiteColor].CGColor;
    _emptyView.layer.borderWidth = 1;
    [self addSubview:_emptyView];
    
    // 4个角
    _leftTopImage = [[UIImageView alloc] initWithFrame:CGRectMake( - 1.5 + 8,  - 1.5 + 8 , 15, 15)];
    _leftTopImage.image = [UIImage imageNamed:@"cutLeftTop"];
    [self addSubview:_leftTopImage];
    
    _rightTopImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width -13.5 - 8,  - 1.5 + 8, 15, 15)];
    _rightTopImage.image = [UIImage imageNamed:@"cutRightTop"];
    [self addSubview:_rightTopImage];
    
    _leftBottomImage = [[UIImageView alloc] initWithFrame:CGRectMake( - 1.5 + 8, self.frame.size.height - 13.5 - 8, 15, 15)];
    _leftBottomImage.image = [UIImage imageNamed:@"cutLeftBottom"];
    [self addSubview:_leftBottomImage];
    
    _rightBottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 13.5 - 8, self.frame.size.height - 13.5 - 8, 15, 15)];
    _rightBottomImage.image = [UIImage imageNamed:@"cutRightBottom"];
    [self addSubview:_rightBottomImage];
}

- (void)sizeFitFourCorner
{
    _leftTopImage.frame = CGRectMake( - 1.5 + 8,  - 1.5 + 8 , 15, 15);
    _rightTopImage.frame = CGRectMake(self.frame.size.width -13.5 - 8,  - 1.5 + 8, 15, 15);
    _leftBottomImage.frame = CGRectMake( - 1.5 + 8, self.frame.size.height - 13.5 - 8, 15, 15);
    _rightBottomImage.frame = CGRectMake(self.frame.size.width - 13.5 - 8, self.frame.size.height - 13.5 - 8, 15, 15);
    _emptyView.frame = CGRectMake(8, 8, self.frame.size.width - 16, self.frame.size.height - 16);
}


@end
