//
//  ViewController.m
//  UIKitDynamics
//
//  Created by jinou on 16/11/24.
//  Copyright © 2016年 ComponentsAndFrameworks. All rights reserved.
//

#import "ViewController.h"

typedef void(^attachBlock)(CGPoint point);

@interface ViewController ()<UICollisionBehaviorDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *labe2;
@property (strong, nonatomic) IBOutlet UILabel *labe3;
@property (strong, nonatomic) IBOutlet UILabel *labe4;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (copy, nonatomic) attachBlock attblock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [self gravityBehavior];
    [self collisionBehavior];
    [self attachmentbehavior];
}

-(void)gravityBehavior
{
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.label,self.labe2]];
    [gravity setAngle:0.5 * M_PI magnitude:1];//角坐标顺时针为正方向，作用力度，1表示等于地心引力
    [self.animator addBehavior:gravity];
}

-(void)collisionBehavior
{
    UICollisionBehavior *collition = [[UICollisionBehavior alloc] initWithItems:@[self.label,self.labe2]];
    collition.collisionMode = UICollisionBehaviorModeEverything;//有三种模式
    collition.translatesReferenceBoundsIntoBoundary = YES;//设置superview的边界为碰撞边界
    collition.collisionDelegate = self;
    [self.animator addBehavior:collition];
}

-(void)attachmentbehavior
{
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.label attachedToAnchor:self.labe3.center];
    [self.animator addBehavior:attachment];
    __weak typeof(id) weakAttach = attachment;
    self.attblock = ^(CGPoint point){
        [weakAttach setAnchorPoint:point];
    };
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches.allObjects lastObject];
    CGPoint point = [touch locationInView:self.view];
    self.labe3.center = point;
    self.attblock(point);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
