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
    [self.navigationController.view addSubview:review];
    review.longpressblock =^(UIImage *blockimage) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *savephotoAction = [UIAlertAction actionWithTitle:@"保存到本地" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), NULL);
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVc addAction:savephotoAction];
        [alertVc addAction:cancelAction];
        [self.navigationController presentViewController:alertVc animated:YES completion:^{
            
        }];
  
    };
}

// 指定回调方法
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"保存成功");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
