//
//  YKPhotosCutView.h
//  BeautyArtifact
//
//  Created by 王豫凯 on 16/10/13.
//  Copyright © 2016年 谢建荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKPhotosCutView : UIView

// nav
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *cutBtn;
@property (strong, nonatomic) IBOutlet UIImageView *cutImage;
@property (strong, nonatomic) IBOutlet UILabel *navLb;


@property (strong, nonatomic) IBOutlet UIScrollView *bigScr;
@property (strong, nonatomic) IBOutlet UIView *smallShadow;
@property (strong, nonatomic) IBOutlet UIScrollView *smallScr;


@property (strong, nonatomic) IBOutlet UIButton *cutOkBtn;
@property (strong, nonatomic) IBOutlet UIButton *cutCancleBtn;



@end
