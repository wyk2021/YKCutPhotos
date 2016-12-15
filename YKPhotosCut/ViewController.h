//
//  ViewController.h
//  YKPhotosCut
//
//  Created by 王豫凯 on 2016/12/15.
//  Copyright © 2016年 王豫凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *origenImg1;
@property (strong, nonatomic) IBOutlet UIImageView *origenImg2;
@property (strong, nonatomic) IBOutlet UIImageView *origenImg3;

@property (strong, nonatomic) IBOutlet UIButton *selectBtn1;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn2;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn3;

@property (strong, nonatomic) IBOutlet UIImageView *cutImage1;
@property (strong, nonatomic) IBOutlet UIImageView *cutImage2;
@property (strong, nonatomic) IBOutlet UIImageView *cutImage3;

@end
