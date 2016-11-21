//
//  ReViewPhotoView.h
//  预览照片Demo
//
//  Created by shenliping on 16/11/14.
//  Copyright © 2016年 shenliping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^longPressBlock)(UIImage *image);
@interface ReViewPhotoView : UIView

- (instancetype)initWithFrame:(CGRect)frame Photo:(UIImage *)photo;

@property (copy, nonatomic) longPressBlock longpressblock;

@end
