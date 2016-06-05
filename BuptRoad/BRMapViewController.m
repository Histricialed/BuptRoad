//
//  BRMapViewController.m
//  BuptRoad
//
//  Created by 李志强 on 16/5/13.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRMapViewController.h"

@interface BRMapViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation BRMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地图";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65/255.0 green:244/255.0 blue:180/255.0 alpha:1.0];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:55/255.0 green:205/255.0 blue:151/255.0 alpha:1.0];
    self.imgView.userInteractionEnabled=YES;
    [self pinchAction];
    [self panAction];
    // Do any additional setup after loading the view from its nib.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"地图";
        UIImage *tabIcon = [UIImage imageNamed:@"icon_tabbar_map"];
        self.tabBarItem.image = tabIcon;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)panAction{
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
    [self.imgView addGestureRecognizer:pan];
}

-(void)panView:(UIPanGestureRecognizer *)pan{
    CGPoint p=[pan translationInView:pan.view];
    pan.view.transform=CGAffineTransformTranslate(pan.view.transform, p.x, p.y);
    [pan setTranslation:CGPointZero inView:pan.view];
}

-(void)pinchAction{
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchView:)];
    pinch.delegate=self;
    [self.imgView addGestureRecognizer:pinch];
}

-(void)pinchView:(UIPinchGestureRecognizer *)pin{
    pin.view.transform=CGAffineTransformScale(pin.view.transform, pin.scale, pin.scale);
    pin.scale=1;
}


-(void)swipeAction{
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    swipe.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.imgView addGestureRecognizer:swipe];
}

-(void)swipeView{
    NSLog(@"swipe");
}

-(void)longPressAction{
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView)];
    longPress.minimumPressDuration=0.5;
    longPress.allowableMovement=10;
    [self.imgView addGestureRecognizer:longPress];
}

-(void)longPressView{
    NSLog(@"longPress");
}

-(void)tapAction{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    //tap.delegate=self;
    self.imgView.userInteractionEnabled=YES;
    [self.imgView addGestureRecognizer:tap];
}

-(void)tapView{
    NSLog(@"tap");
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


@end
