//
//  YKPhotoCutController.m
//  BeautyArtifact
//
//  Created by 王豫凯 on 16/10/13.
//  Copyright © 2016年 王豫凯. All rights reserved.
//

#import "YKPhotoCutController.h"
#import "YKPhotosCutView.h"
#import "YKCutView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define _750scale(scale) (((kWidth) * scale) / (750.0))     // 以@2x为比例的适配

@interface YKPhotoCutController ()<UIScrollViewDelegate>

@end

@implementation YKPhotoCutController
{
    NSMutableArray *_cutPhotoArr;    // 这个是用来切photo的数组
    YKPhotosCutView *_mainView;
    YKCutView *_cutView;
    UIButton *_markBtn;
    UIView *_shadowView;
    CAShapeLayer *_fillLayer;
    int _moveCorner;   // 判断是第几个角(若无则为0)
    
    NSInteger _tag;
    
    CGFloat _startX;
    CGFloat _startY;
    CGFloat _endX;
    CGFloat _endY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)config
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    _cutPhotoArr = [NSMutableArray array];
    [_cutPhotoArr addObjectsFromArray:_photoArr];
    
    _mainView = [(NSArray *)[[NSBundle mainBundle] loadNibNamed:@"YKPhotosCutView" owner:self options:nil] firstObject];
    _mainView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_mainView];
    [_mainView.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_mainView.cutBtn addTarget:self action:@selector(cutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_mainView.cutCancleBtn addTarget:self action:@selector(cutCancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_mainView.cutOkBtn addTarget:self action:@selector(cutOkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_mainView.okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _fillLayer = [CAShapeLayer layer];
    _fillLayer.hidden = YES;
    [self.view.layer addSublayer:_fillLayer];
    
    // 显示大小滑动条图片
    [self creatBigPicAndSmallPic];
    [self creatShadow];
}

- (void)creatBigPicAndSmallPic
{
    // 创建大小滑动图
    for (int i = 0; i < _cutPhotoArr.count; i++) {
        UIImage *origenImage = _cutPhotoArr[i];
        // 小图
        UIImageView *smallImage = [[UIImageView alloc] initWithFrame:CGRectMake(i * (10 + 58) + 10, 10, 58, 58)];
        smallImage.image = origenImage;
        smallImage.contentMode =  UIViewContentModeScaleAspectFill;
        smallImage.clipsToBounds  = YES;
        smallImage.tag = 100 + i;
        [_mainView.smallScr addSubview:smallImage];
        
        UIButton *smallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        smallBtn.frame = smallImage.frame;
        smallBtn.tag = 500 + i;
        smallBtn.layer.borderWidth = 0;
        smallBtn.layer.borderColor = [UIColor redColor].CGColor;
        if (i == 0) {
            _tag = 0;
            _markBtn = smallBtn;
            smallBtn.layer.borderWidth = 0.7;
        }
        [smallBtn addTarget:self action:@selector(smallBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.smallScr addSubview:smallBtn];
        
        
        // 每张大图下面都是一个scr
        UIScrollView *indexScr = [[UIScrollView alloc] initWithFrame:CGRectMake(i * kWidth, 0, kWidth, kHeight - 64 * 2)];
        indexScr.showsVerticalScrollIndicator = NO;
        indexScr.showsHorizontalScrollIndicator = NO;
        indexScr.scrollEnabled = NO;
        indexScr.tag = 200 + i;
        
        [_mainView.bigScr addSubview:indexScr];
        
        //设置UIScrollView的滚动范围和图片的真实尺寸一致
        indexScr.contentSize = CGSizeMake(kWidth + 10, origenImage.size.height * (kWidth + 10) / origenImage.size.width);
        //设置实现缩放
        //设置代理scrollview的代理对象
        indexScr.delegate= self;
        //设置最大伸缩比例
        indexScr.maximumZoomScale = 2.0;
        //设置最小伸缩比例
        indexScr.minimumZoomScale = 1;
        
        UIImageView *bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, indexScr.frame.size.width, origenImage.size.height * kWidth / origenImage.size.width)];
        bigImage.image = origenImage;
        [indexScr addSubview:bigImage];
        
        // 设置大小scr属性
        _mainView.smallScr.showsHorizontalScrollIndicator = NO;
        _mainView.bigScr.showsHorizontalScrollIndicator = NO;
        _mainView.bigScr.scrollEnabled = NO;
        if (_cutPhotoArr.count - 1 == i) {
            _mainView.smallScr.contentSize = CGSizeMake(CGRectGetMaxX(smallImage.frame) + 10, 0);
        }
        
    }
    _mainView.bigScr.contentSize = CGSizeMake(kWidth * _cutPhotoArr.count, 0);
    _mainView.bigScr.backgroundColor = [UIColor blackColor];
    _mainView.bigScr.pagingEnabled = YES;
}

- (UIImageView *)smallScrWithtag:(NSInteger)tag
{
    // 分别输出4个tab
    switch (tag) {
        case 0:
            return [_mainView.smallScr viewWithTag:100 + tag];
            break;
        case 1:
            return [_mainView.smallScr viewWithTag:100 + tag];
            break;
        case 2:
            return [_mainView.smallScr viewWithTag:100 + tag];
            break;
        case 3:
            return [_mainView.smallScr viewWithTag:100 + tag];
            break;
        case 4:
            return [_mainView.smallScr viewWithTag:100 + tag];
            break;
        case 5:
            return [_mainView.smallScr viewWithTag:100 + tag];
            break;
        case 6:
            return [_mainView.smallScr viewWithTag:100 + tag];
            break;
        case 7:
            return [_mainView.smallScr viewWithTag:100 + tag];
            break;
        case 8:
            return [_mainView.smallScr viewWithTag:100 + tag];
            break;
            
        default:
            break;
    }
    return nil;
}

// 方便调用子tab
- (UIScrollView *)bigScrWithtag:(NSInteger)tag
{
    // 分别输出4个tab
    switch (tag) {
        case 0:
            return [_mainView.bigScr viewWithTag:200 + tag];
            break;
        case 1:
            return [_mainView.bigScr viewWithTag:200 + tag];
            break;
        case 2:
            return [_mainView.bigScr viewWithTag:200 + tag];
            break;
        case 3:
            return [_mainView.bigScr viewWithTag:200 + tag];
            break;
        case 4:
            return [_mainView.bigScr viewWithTag:200 + tag];
            break;
        case 5:
            return [_mainView.bigScr viewWithTag:200 + tag];
            break;
        case 6:
            return [_mainView.bigScr viewWithTag:200 + tag];
            break;
        case 7:
            return [_mainView.bigScr viewWithTag:200 + tag];
            break;
        case 8:
            return [_mainView.bigScr viewWithTag:200 + tag];
            break;
            
        default:
            break;
    }
    return nil;
}

// 点击小图片
- (void)smallBtnClick:(UIButton *)sender
{
    NSInteger indexNum = sender.tag - 500;
    _mainView.bigScr.contentOffset = CGPointMake(indexNum * kWidth, 0);
    _markBtn.layer.borderWidth = 0;
    sender.layer.borderWidth = 0.7;
    _markBtn = sender;
    _tag = sender.tag - 500;
}

#pragma mark - 裁剪点击
- (void)cutBtnClick
{
    if (_cutView) {
        _cutView.hidden = NO;
    } else {
        _cutView = [[YKCutView alloc] initWithFrame:CGRectMake(0, 0, kWidth - 15, kWidth - 15)];
        _cutView.emptyView.userInteractionEnabled = NO;
        _cutView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
        [self.view addSubview:_cutView];
    }
    _mainView.smallScr.hidden = YES;
    _mainView.smallShadow.hidden = YES;
    _mainView.backBtn.hidden = YES;
    _mainView.okBtn.hidden = YES;
    _mainView.cutBtn.hidden = YES;
    _mainView.cutImage.hidden = YES;
    
    _mainView.navLb.hidden = NO;
    _mainView.cutCancleBtn.hidden = NO;
    _mainView.cutOkBtn.hidden = NO;
    _shadowView.hidden = NO;
    _shadowView.userInteractionEnabled = NO;
    _fillLayer.hidden = NO;   // 阴影背景
    [self changeShadowWithFrame];
    
    UIScrollView *scr = [self bigScrWithtag:_tag];
    scr.scrollEnabled = YES;
}

// 取消裁剪
- (void)cutCancleBtnClick
{
    _mainView.smallScr.hidden = NO;
    _mainView.smallShadow.hidden = NO;
    _mainView.backBtn.hidden = NO;
    _mainView.okBtn.hidden = NO;
    _mainView.cutBtn.hidden = NO;
    _mainView.cutImage.hidden = NO;
    
    _mainView.navLb.hidden = YES;
    _mainView.cutCancleBtn.hidden = YES;
    _mainView.cutOkBtn.hidden = YES;
    _shadowView.hidden = YES;
    _cutView.hidden = YES;
    _fillLayer.hidden = YES;
    
    UIScrollView *scr = [self bigScrWithtag:_tag];
    scr.scrollEnabled = NO;
}

// 确定裁剪
- (void)cutOkBtnClick
{
    UIImage *currectImage = _cutPhotoArr[_tag];
    UIImage *newImage = [self screenView:self.view];
    currectImage = newImage;
    [_cutPhotoArr replaceObjectAtIndex:_tag withObject:newImage];
    UIImageView *smallImg = [self smallScrWithtag:_tag];
    smallImg.image = newImage;
    
    UIScrollView *scr = [self bigScrWithtag:_tag];
    UIImageView *bigImg = (UIImageView *)scr.subviews[0];
    bigImg.image = newImage;
    
    // 将切过的scr改变frame为正方形,且显示在中间
    scr.frame = CGRectMake(scr.frame.origin.x, scr.frame.origin.y, kWidth, kWidth);
    scr.center = CGPointMake(scr.frame.origin.x + kWidth / 2, _mainView.bigScr.center.y - _750scale(20));
    scr.contentSize = CGSizeMake(kWidth + 10, kWidth + 10);
    scr.backgroundColor = [UIColor blackColor];
    bigImg.frame = CGRectMake(0, 0, kWidth, kWidth);
    
    [self cutCancleBtnClick];
}

#pragma mark - 截取
- (UIImage*)screenView:(UIView *)view{
    CGRect rect = CGRectMake(0, 0, kWidth, kHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect newRect = CGRectMake(_cutView.frame.origin.x + 2 + 8, _cutView.frame.origin.y + 2 + 8, _cutView.frame.size.width - 4 - 16, _cutView.frame.size.height - 4 - 16);
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect(img.CGImage, newRect)];
}

- (void)creatShadow
{
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64 * 2)];
    _shadowView.hidden = YES;
    [self.view addSubview:_shadowView];
}

- (void)changeShadowWithFrame
{
    //中间镂空的矩形框
    CGRect myRect = CGRectMake(_cutView.frame.origin.x + 8, _cutView.frame.origin.y + 8, _cutView.frame.size.width - 16, _cutView.frame.size.height - 16);
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 64, kWidth, _shadowView.frame.size.height) cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:myRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    _fillLayer.path = path.CGPath;
    _fillLayer.fillRule = kCAFillRuleEvenOdd;//中间镂空的关键点 填充规则
    _fillLayer.fillColor = [UIColor blackColor].CGColor;
    _fillLayer.opacity = 0.75;
    [self.view bringSubviewToFront:_cutView];
}

#pragma mark - 确定保存图片
- (void)okBtnClick
{
    if (self.delegate) {
        [self.delegate getBackCutPhotos:_cutPhotoArr];
    }
    [self backBtnClick];
}

#pragma mark - 截取框移动
// 触碰时的坐标,来判断是否是4个角
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    _moveCorner = [self judgeIsFourCornerTouch:touchPoint];
}

// 移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    CGFloat origenX = _cutView.frame.origin.x;
    CGFloat origenY = _cutView.frame.origin.y;
    CGFloat origenW = _cutView.frame.size.width;
    CGFloat origentH = _cutView.frame.size.height;
    
    //以前的point
    CGPoint preP = [touch previousLocationInView:self.view];
    //x轴偏移的量
    CGFloat offsetX = touchPoint.x - preP.x;
    //Y轴偏移的量
    CGFloat offsetY = touchPoint.y - preP.y;
    
    switch (_moveCorner) {
        case 1:
        {
            
            if (origenX - touchPoint.x > 0 && origenY - touchPoint.y > 0) {
                touchPoint.y = origenY + touchPoint.x - origenX;
            } else if (origenX - touchPoint.x < 0 && origenY - touchPoint.y < 0) {
                touchPoint.y = origenY + touchPoint.x - origenX;
            } else {
                return;
            }
            
            // 做限制判断
            if (touchPoint.x < 0) {
                touchPoint.x = 0;
                return;
            }
            if (touchPoint.y < 64) {
                touchPoint.y = 64;
                return;
            }
            
            _cutView.frame = CGRectMake(touchPoint.x, touchPoint.y, origenX - touchPoint.x + origenW , origenY - touchPoint.y + origentH);
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
        case 2:
        {
            if (touchPoint.x - (origenX + origenW)> 0 && touchPoint.y - origenY < 0) {
                touchPoint.y = origenY - (touchPoint.x - origenX - origenW);
            } else if (touchPoint.x - (origenX + origenW) < 0 && touchPoint.y - origenY > 0) {
                touchPoint.y = origenY - (touchPoint.x - origenX - origenW);
            } else {
                return;
            }
            
            // 做限制判断
            if (touchPoint.x > kWidth) {
                touchPoint.x = kWidth;
                return;
            }
            if (touchPoint.y < 64) {
                touchPoint.y = 64;
                return;
            }
            
            _cutView.frame = CGRectMake(origenX, touchPoint.y, touchPoint.x - origenX, origentH - (touchPoint.y - origenY));
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
        case 3:
        {
            if (touchPoint.x - origenX > 0 && touchPoint.y - (origenY + origentH) < 0) {
                touchPoint.y = origenY + origentH - (touchPoint.x - origenX);
            } else if (touchPoint.x - origenX < 0 && touchPoint.y - (origenY + origentH) > 0) {
                touchPoint.y = origenY + origentH - (touchPoint.x - origenX);
            } else {
                return;
            }
            
            // 做限制判断
            if (touchPoint.x < 0) {
                touchPoint.x = 0;
                return;
            }
            if (touchPoint.y > kHeight - 64) {
                touchPoint.y = kHeight - 64;
                return;
            }
            
            _cutView.frame = CGRectMake(touchPoint.x, origenY, (origenX - touchPoint.x) + origenW, touchPoint.y - origenY);
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
        case 4:
        {
            if (touchPoint.x - origenX > 0 && touchPoint.y - origenY > 0) {
                touchPoint.y = origenY + touchPoint.x - origenX;
            } else if (touchPoint.x - origenX < 0 && touchPoint.y - origenY < 0) {
                touchPoint.y = origenY + touchPoint.x - origenX;
            } else {
                return;
            }
            
             // 做限制判断
            if (touchPoint.x > kWidth) {
                touchPoint.x = kWidth;
                return;
            }
            if (touchPoint.y > kHeight - 64) {
                touchPoint.y = kHeight - 64;
                return;
            }
            
            _cutView.frame = CGRectMake(origenX, origenY, touchPoint.x - origenX, touchPoint.y - origenY);
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
            case 5:
        {
            
            CGFloat finalX = origenX;
            CGFloat finalY = origenY;
            
            finalX = origenX + offsetX;
            finalY = origenY + offsetY;
            
            if (finalX < 0) {
                finalX = 0;
            }
            if (finalY < 64) {
                finalY = 64;
            }
            if (finalX > kWidth - _cutView.frame.size.width) {
                finalX = kWidth - _cutView.frame.size.width;
            }
            if (finalY > kHeight - 64- _cutView.frame.size.width) {
                finalY = kHeight - 64- _cutView.frame.size.width;
            }
            
            _cutView.frame = CGRectMake(finalX, finalY, _cutView.frame.size.width, _cutView.frame.size.height);
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
            
        default:
            break;
    }
}

// 结束触碰
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _moveCorner = 0;
}

// 获得4个角的坐标
- (CGPoint)getFirstCorner
{
    return CGPointMake(_cutView.frame.origin.x, _cutView.frame.origin.y);
}

- (CGPoint)getSecondCorner
{
    return CGPointMake(CGRectGetMaxX(_cutView.frame), CGRectGetMinY(_cutView.frame));
}

- (CGPoint)getThirdCorner
{
    return CGPointMake(CGRectGetMinX(_cutView.frame), CGRectGetMaxY(_cutView.frame));
}

- (CGPoint)getFourthCorner
{
    return CGPointMake(CGRectGetMaxX(_cutView.frame), CGRectGetMaxY(_cutView.frame));
}

// 判断是否位于四个角的触摸
- (int)judgeIsFourCornerTouch:(CGPoint)point
{
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    if (x > [self getFirstCorner].x - 50 && x < [self getFirstCorner].x + 50 && y > [self getFirstCorner].y - 50 && y < [self getFirstCorner].y + 50) {
        return 1;
    } else if (x > [self getSecondCorner].x - 50 && x < [self getSecondCorner].x + 50 && y > [self getSecondCorner].y - 50 && y < [self getSecondCorner].y + 50) {
        return 2;
    } else if (x > [self getThirdCorner].x - 50 && x < [self getThirdCorner].x + 50 && y > [self getThirdCorner].y - 50 && y < [self getThirdCorner].y + 50) {
        return 3;
    } else if (x > [self getFourthCorner].x - 50 && x < [self getFourthCorner].x + 50 && y > [self getFourthCorner].y - 50 && y < [self getFourthCorner].y + 50) {
        return 4;
    } else if (x > [self getFirstCorner].x + 50 && y > [self getFirstCorner].y + 50 && x < [self getSecondCorner].x - 50 && y < [self getFourthCorner].y - 50) {
        return 5;
    };
    return 0;
}

//告诉scrollview要缩放的是哪个子控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
     return scrollView.subviews[0];
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
