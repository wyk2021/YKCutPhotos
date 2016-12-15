//
//  ViewController.m
//  YKPhotosCut
//
//  Created by 王豫凯 on 2016/12/15.
//  Copyright © 2016年 王豫凯. All rights reserved.
//

#import "ViewController.h"
#import "YKPhotoCutController.h"

@interface ViewController ()<YKCutPhotoDelegate>

@end

@implementation ViewController
{
    NSMutableArray *_imageArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    if (_imageArray) {
        [_imageArray removeAllObjects];
        _selectBtn1.selected = NO;
        _selectBtn2.selected = NO;
        _selectBtn3.selected = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _imageArray = [NSMutableArray array];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cutPhotos:)];
    _origenImg1.userInteractionEnabled = YES;
    [_origenImg1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cutPhotos:)];
    _origenImg2.userInteractionEnabled = YES;
    [_origenImg2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cutPhotos:)];
    _origenImg3.userInteractionEnabled = YES;
    [_origenImg3 addGestureRecognizer:tap3];
}

- (void)cutPhotos:(UITapGestureRecognizer *)sender
{
    if (sender.view == _origenImg1) {
        if (_selectBtn1.selected) {
            _selectBtn1.selected = NO;
            [_imageArray removeObject:_origenImg1.image];
        } else {
            _selectBtn1.selected = YES;
            [_imageArray addObject:_origenImg1.image];
        }
    } else if (sender.view == _origenImg2) {
        if (_selectBtn2.selected) {
            _selectBtn2.selected = NO;
            [_imageArray removeObject:_origenImg2.image];
        } else {
            _selectBtn2.selected = YES;
            [_imageArray addObject:_origenImg2.image];
        }
    } else {
        if (_selectBtn3.selected) {
            _selectBtn3.selected = NO;
            [_imageArray removeObject:_origenImg3.image];
        } else {
            _selectBtn3.selected = YES;
            [_imageArray addObject:_origenImg3.image];
        }
    }
}

#pragma mark - 关键在这两个方法
// 裁剪时要传递需裁剪图片的数组进去
// 代理回来被裁剪后的图片的数组

// 裁剪
- (IBAction)gotoCutPhotos:(id)sender {
    YKPhotoCutController *cutVC = [[YKPhotoCutController alloc] init];
    cutVC.photoArr = _imageArray;
    cutVC.delegate = self;
    [self.navigationController pushViewController:cutVC animated:YES];
}

// 剪切后图片的代理回调
- (void)getBackCutPhotos:(NSArray *)photosArr
{
    _cutImage1.image = nil;
    _cutImage2.image = nil;
    _cutImage3.image = nil;
    
    // 赋值新剪切的图片
    for (int i = 0; i < photosArr.count; i ++) {
        switch (i) {
            case 0:
                _cutImage1.image = photosArr[i];
                break;
            case 1:
                _cutImage2.image = photosArr[i];
                break;
            case 2:
                _cutImage3.image = photosArr[i];
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
