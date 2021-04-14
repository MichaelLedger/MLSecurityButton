//
//  ViewController.m
//  Sample
//
//  Created by Gavin Xiang on 2021/4/14.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupButton];
}

- (void)setupButton {
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    pushBtn.layer.borderWidth = 1.f;
    [pushBtn setTitle:@"Push" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    pushBtn.layer.cornerRadius = 5.f;
    pushBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 30, 10, 30);
    [self.view addSubview:pushBtn];
//    pushBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [pushBtn sizeToFit];
    pushBtn.center = self.view.center;
    pushBtn.disableQuickTap = YES;// Disable quick tap to enable security reponse function.
    pushBtn.minimumClickInterval = 3.f;// Custom minimum click time interval, default is 0.75.
    [pushBtn addTarget:self action:@selector(handleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleBtnClicked:(UIButton *)sender {
    NSLog(@"%s", __func__);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.f];
        [self.navigationController pushViewController:vc animated:YES];
    });
}

@end
