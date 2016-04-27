//
//  ShowBigImage.m
//  Cook
//
//  Created by 诸超杰 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "ShowBigImage.h"

static CGRect oldframe;
@implementation ShowBigImage

+ (void)showImage:(UIImageView *)avatarImageView {
    UIImage *image = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc] initWithFrame:SCREENBOUNDS];
    oldframe  = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1020;

   
    [window addSubview:backgroundView];
    [window addSubview:imageView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tap];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    [backgroundView addGestureRecognizer:pinch];
    
    [UIView animateWithDuration:0.3f animations:^{
        imageView.frame = CGRectMake(0, 0, SCREENWIDTH , image.size.height / image.size.width * SCREENWIDTH);
        imageView.center = backgroundView.center;
        backgroundView.alpha = 0.6;
    } completion:^(BOOL finished) {
        
    }];
 }

+  (void)pinchAction:(UIPinchGestureRecognizer *)pinch{
    UIView *backgroundView = pinch.view;
    UIImageView *imageView = (UIImageView *)[[UIApplication sharedApplication].keyWindow viewWithTag:1020];
    UIImage *image = imageView.image;
    //改变形变属性
    imageView.transform = CGAffineTransformScale(imageView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
    switch (pinch.state) {
        case UIGestureRecognizerStateEnded:
            imageView.frame = CGRectMake(0, 0, SCREENWIDTH , image.size.height / image.size.width * SCREENWIDTH);
            imageView.center = backgroundView.center;
            break;
            
        default:
            break;
    }
}

+ (void)hideImage:(UITapGestureRecognizer *)tap {
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[[UIApplication sharedApplication].keyWindow viewWithTag:1020];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [backgroundView removeFromSuperview];
    }];
}

@end
