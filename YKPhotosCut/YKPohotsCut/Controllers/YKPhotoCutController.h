//
//  YKPhotoCutController.h
//  BeautyArtifact
//
//  Created by 王豫凯 on 16/10/13.
//  Copyright © 2016年 谢建荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YKCutPhotoDelegate <NSObject>

- (void)getBackCutPhotos:(NSArray *)photosArr;

@end

@interface YKPhotoCutController : UIViewController

@property (nonatomic, strong) NSArray *photoArr;   // 需要切图的image数组
@property (nonatomic, weak) id<YKCutPhotoDelegate>delegate;   // 返回全部切好的image数组

@end
