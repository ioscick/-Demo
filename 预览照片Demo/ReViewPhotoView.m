//
//  ReViewPhotoView.m
//  预览照片Demo
//
//  Created by shenliping on 16/11/14.
//  Copyright © 2016年 shenliping. All rights reserved.
//

#import "ReViewPhotoView.h"

@interface ReViewPhotoView ()
{
    CGFloat lastScare;
    CGFloat firstX;
    CGFloat firstY;
    CGRect imgFrame;
    CGAffineTransform transform;
}
@end

@implementation ReViewPhotoView

- (instancetype)initWithFrame:(CGRect)frame Photo:(UIImage *)photo {
    if (self = [super initWithFrame:frame]) {
        CGFloat scale = photo.size.width / self.frame.size.width;
        CGFloat height = photo.size.height / scale;
        
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - height)/2, self.frame.size.width, height)];
        imageView.image = photo;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        
        imgFrame = imageView.frame;
        transform = imageView.transform;
        lastScare = 1.0f;
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchChangeScale:)];
        [imageView addGestureRecognizer:pinchGesture];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
        [imageView addGestureRecognizer:panGesture];
        
        UITapGestureRecognizer *oneTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDisappear)];
        oneTapGesture.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:oneTapGesture];
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapResolve:)];
        doubleTapGesture.numberOfTapsRequired = 2;
        [imageView addGestureRecognizer:doubleTapGesture];
        
        [oneTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    }
    return self;
}

- (void)pinchChangeScale:(UIPinchGestureRecognizer *)pinch {
    UIImageView *imageView = (UIImageView *)pinch.view;
    if (pinch.state == UIGestureRecognizerStateBegan) {
        lastScare = 1.0;
    }
    CGFloat scare = 1 - (lastScare - pinch.scale);
    CGAffineTransform currentTransform = imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scare, scare);
    [imageView setTransform:newTransform];
    lastScare = pinch.scale;
}

- (void)move:(UIPanGestureRecognizer *)pan {
    CGPoint transpoint = [pan translationInView:self];
    UIImageView *imageView = (UIImageView *)pan.view;
    if (pan.state == UIGestureRecognizerStateBegan) {
        firstX = imageView.center.x;
        firstY = imageView.center.y;
    }
    if (lastScare == 1.0f) {
        return;
    }
    transpoint = CGPointMake(firstX+transpoint.x, firstY+transpoint.y);
    [imageView setCenter:transpoint];
}

- (void)tapDisappear {
    [self removeFromSuperview];
}

- (void)tapResolve:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    [imageView setTransform:transform];
    [imageView setFrame:imgFrame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
