//
//  ViewController.m
//  CircleView
//
//  Created by 孙斌 on 2018/6/28.
//  Copyright © 2018年 孙斌. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CAShapeLayer *frontCircle = [CAShapeLayer layer];  // 进度条圆弧
    CAShapeLayer *backCircle = [CAShapeLayer layer]; //进度条底
    [self.circleView.layer addSublayer:backCircle];
    [self.circleView.layer addSublayer:frontCircle];
    
    // 画底
    UIBezierPath *backPath = [UIBezierPath bezierPathWithArcCenter:self.circleView.center radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    backCircle.lineWidth = 12;  // 线条宽度
    backCircle.strokeColor = [[UIColor grayColor] CGColor]; // 边缘线的颜色
    backCircle.fillColor = [[UIColor clearColor] CGColor];  // 闭环填充的颜色
    backCircle.lineCap = @"round";  // 边缘线的类型
    backCircle.path = backPath.CGPath; // 从贝塞尔曲线获取到形状
    
    // 画刻度
    UIBezierPath *frontPath = [UIBezierPath bezierPathWithArcCenter:self.circleView.center radius:100 startAngle:M_PI endAngle:M_PI*2 clockwise:YES];
    frontCircle.lineWidth = 12;
    frontCircle.strokeColor = [[UIColor blueColor] CGColor];
    frontCircle.fillColor = [[UIColor clearColor] CGColor];
    frontCircle.lineCap = @"round";
    frontCircle.path = frontPath.CGPath;
    
    // 动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.duration = 1; // 动画时长
    animation.fromValue = @0; // 开始值
    frontCircle.strokeEnd = 1;
    // 给layer添加动画
    [frontCircle addAnimation:animation forKey:nil];
    
    // 小圆点
    UIView *roundView = [[UIView alloc] init];
    roundView.frame = CGRectMake(50, 50, 8, 8);
    roundView.layer.masksToBounds = YES;
    roundView.layer.cornerRadius = 4;
    roundView.backgroundColor = [UIColor whiteColor];
    [self.circleView addSubview:roundView];
    
    // 小圆点动画
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation1.duration = 1;
    // 小圆点的路径与进度条弧度一样
    animation1.path = frontPath.CGPath;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    [roundView.layer addAnimation:animation1 forKey: nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
