//
//  ViewController.m
//  预览照片Demo
//
//  Created by shenliping on 16/11/14.
//  Copyright © 2016年 shenliping. All rights reserved.
//

#import "ViewController.h"
#import "ReViewPhotoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 200, 200)];
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReviewImage:)]];
    imageView.image = [UIImage imageNamed:@"photo.jpeg"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)tapReviewImage:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    UIImage *image = imageView.image;
    ReViewPhotoView *review = [[ReViewPhotoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) Photo:image];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.duration = 0.5;
    [review.layer addAnimation:transition forKey:nil];
    [self.view.window addSubview:review];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
