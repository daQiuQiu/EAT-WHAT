//
//  ViewController.m
//  EAT WHAT!
//
//  Created by 易 仁 on 16/9/8.
//  Copyright © 2016年 University of Leeds. All rights reserved.
//

#import "ViewController.h"
#import <POP.h>
#import "Masonry.h"
#import "PresentingAnimationController.h"
#import "DismissingAnimationController.h"
#import "DetailViewController.h"
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
@interface ViewController ()
@property (nonatomic, strong) UILabel *foodLabel;
@property (nonatomic, strong) UILabel *foodLabel1;
@property (nonatomic, strong) UILabel *foodLabel2;
@property (nonatomic, strong) UILabel *foodLabel3;
@property (nonatomic, strong) UILabel *foodLabel4;
@property (nonatomic, strong) UILabel *foodLabel5;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *rotateView;
@property (nonatomic, strong) UIImageView  *bgImageView;
@property (nonatomic, strong) NSMutableArray  *foodArray;
@property (nonatomic, strong) UIButton     *startButton;
@property (nonatomic, assign) BOOL     isStart;
@property (nonatomic, assign) CGRect  oriFrame;
@property (nonatomic, strong) UIVisualEffectView *blurView;
//@property (nonatomic, strong) UITapGestureRecognizer *tap;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isStart = YES;
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
//    [self startAnimationWithLabel:self.foodLabel];
//    [self startPopAnimation];
    [self getbackImage];
    NSArray *Array = @[@1,@2,@3,@4,@5,@6];
    self.foodArray = [[NSMutableArray alloc]initWithArray:Array];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.blurView removeFromSuperview];
//    [self startPopAnimation];
}

- (void) getbackImage {
    NSArray *adImageArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    int tag = arc4random() % 12+1;
    self.bgImageView.image = [UIImage imageNamed:adImageArray[tag]];
}

- (void)makeConstraints {
    [self.bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.rotateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.view).with.offset (100);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    [self.foodLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.rotateView);
        make.centerX.mas_equalTo (self.rotateView);
        make.size.mas_equalTo (CGSizeMake(50, 50));
    }];
    
    [self.foodLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.foodLabel.mas_bottom).with.offset(25);
        make.right.mas_equalTo (self.rotateView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.foodLabel2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.foodLabel3.mas_top).with.offset(-25);
        make.right.mas_equalTo (self.rotateView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.foodLabel3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rotateView);
        make.bottom.mas_equalTo (self.rotateView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.foodLabel4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.foodLabel3.mas_top).with.offset(-25);
        make.left.mas_equalTo (self.rotateView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.foodLabel5 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.foodLabel.mas_bottom).with.offset(25);
        make.left.mas_equalTo (self.rotateView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.bgImageView).with.offset (20);
        make.centerX.mas_equalTo (self.bgImageView);
    }];
    
    [self.startButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (self.bgImageView);
        make.bottom.mas_equalTo (self.bgImageView).with.offset(-50);
        make.size.mas_equalTo (CGSizeMake(100, 20));
    }];

}

- (void) setupUI {
    [self.view addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.titleLabel];
    [self.bgImageView addSubview:self.startButton];
    [self.bgImageView addSubview:self.rotateView];
    [self.rotateView addSubview:self.foodLabel];
    [self.rotateView addSubview:self.foodLabel1];
    [self.rotateView addSubview:self.foodLabel2];
    [self.rotateView addSubview:self.foodLabel3];
    [self.rotateView addSubview:self.foodLabel4];
    [self.rotateView addSubview:self.foodLabel5];
    
    [self makeConstraints];
}

- (void) startPopAnimation {
    if (_isStart == YES) {
        POPBasicAnimation *ani = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        
        ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        ani.delegate = self;
        
        //        ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        ani.duration = 10.0;
        ani.fromValue = @(0);
        //    CGFloat d = M_PI * 12.0;
        ani.toValue = @(M_PI*12);
        [self.rotateView.layer pop_addAnimation:ani forKey:@"rotation"];
        
        [self performSelector:@selector(startRandomFood) withObject:nil afterDelay:1.7];
        _isStart = !_isStart;
    }
    else {
        POPBasicAnimation *endAni = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        
        endAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        endAni.delegate = self;
        
        //        ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        endAni.duration = 3.0;
        endAni.fromValue = @(0);
        //    CGFloat d = M_PI * 12.0;
        endAni.toValue = @(-M_PI*2);
        [self.rotateView.layer pop_addAnimation:endAni forKey:@"rotation"];
        
        [self performSelector:@selector(endAnimation) withObject:nil afterDelay:1.0];
        _isStart = !_isStart;

    }
    
}

- (void) startRandomFood {
    
    NSInteger count = [_foodArray count];
    int removeTga = arc4random() % count;
    NSInteger removedTag = [_foodArray[removeTga] integerValue];
    switch (removedTag) {
        case 1:{
            [UIView animateWithDuration:0.3 animations:^{
                self.foodLabel.alpha = 0;
                
            }];
            break;
        }
        case 2:{
            [UIView animateWithDuration:0.3 animations:^{
                self.foodLabel1.alpha = 0;
                
            }];
            break;
        }
        case 3:{
            [UIView animateWithDuration:0.3 animations:^{
                self.foodLabel2.alpha = 0;
                
            }];
            break;
        }
        case 4:{
            [UIView animateWithDuration:0.3 animations:^{
                self.foodLabel3.alpha = 0;
                
            }];
            break;
        }
        case 5:{
            [UIView animateWithDuration:0.3 animations:^{
                self.foodLabel4.alpha = 0;
                
            }];
            break;
        }
        case 6:{
            [UIView animateWithDuration:0.3 animations:^{
                self.foodLabel5.alpha = 0;
                
            }];
            break;
        }
        default:
            break;
    }
    [_foodArray removeObjectAtIndex:removeTga];
    if ([_foodArray count] == 1) {
        return;
    }else {
        NSLog(@"count = %lu",(unsigned long)[_foodArray count]);
        [self performSelector:@selector(startRandomFood) withObject:nil afterDelay:1.7];
    }
    
}

- (void) endAnimation {
    if ([_foodArray count] == 1) {
        [self makeConstraints];
        [UIView animateWithDuration:1.0f animations:^{
            
            [self.view layoutIfNeeded];
        }];
            }

    [self performSelector:@selector(resetShow) withObject:nil afterDelay:1.1];
    
   
}

- (void) resetShow {
    NSArray *Array = @[@1,@2,@3,@4,@5,@6];
    self.foodArray = [[NSMutableArray alloc]initWithArray:Array];
    [UIView animateWithDuration:0.3 animations:^{
        self.foodLabel.alpha = 1;
        self.foodLabel1.alpha = 1;
        self.foodLabel2.alpha = 1;
        self.foodLabel3.alpha = 1;
        self.foodLabel4.alpha = 1;
        self.foodLabel5.alpha = 1;
    }];
    [_startButton setTitle:@"Start" forState:UIControlStateNormal];
}

#pragma mark - pop delegate
- (void)pop_animationDidReachToValue:(POPAnimation *)anim {
    if ([_foodArray count] == 1&&_isStart == NO) {
        [_startButton setTitle:@"Reset" forState:UIControlStateNormal];
        NSInteger last = [_foodArray.firstObject integerValue];
        switch (last) {
            case 1:{
                self.oriFrame = self.foodLabel.frame;
                [self.foodLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo (CGSizeMake(150, 150));
                    make.center.mas_equalTo(self.rotateView);
                }];
                [UIView animateWithDuration:1.0f animations:^{
                    
                    [self.view layoutIfNeeded];
                }];
                break;
            }
            case 2:{
                self.oriFrame = self.foodLabel1.frame;
                [self.foodLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo (CGSizeMake(150, 150));
                    make.center.mas_equalTo(self.rotateView);
                }];
                [UIView animateWithDuration:1.0f animations:^{
                   
                    [self.view layoutIfNeeded];
                }];
                break;
            }
            case 3:{
                self.oriFrame = self.foodLabel2.frame;
                [self.foodLabel2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo (CGSizeMake(150, 150));
                    make.center.mas_equalTo(self.rotateView);
                }];
                [UIView animateWithDuration:1.0 animations:^{
                   
                    [self.view layoutIfNeeded];
                }];
                break;
            }
            case 4:{
                self.oriFrame = self.foodLabel3.frame;
                [self.foodLabel3 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo (CGSizeMake(150, 150));
                    make.center.mas_equalTo(self.rotateView);
                }];
                [UIView animateWithDuration:1.0 animations:^{
                    
                    [self.view layoutIfNeeded];
                }];
                break;
            }
            case 5:{
                self.oriFrame = self.foodLabel4.frame;
                [self.foodLabel4 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo (CGSizeMake(150, 150));
                    make.center.mas_equalTo(self.rotateView);
                }];
                [UIView animateWithDuration:1.0 animations:^{
                    
                    [self.view layoutIfNeeded];
                }];
                break;
            }
            case 6:{
                self.oriFrame = self.foodLabel5.frame;
                [self.foodLabel5 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo (CGSizeMake(150, 150));
                    make.center.mas_equalTo(self.rotateView);
                }];
                [UIView animateWithDuration:1.0 animations:^{
                    
                    [self.view layoutIfNeeded];
                }];
                break;
            }
            
            default:
                break;
        }
    }
}

- (void) pushToDetail {
    if ([_foodArray count] == 1&&_isStart == NO) {
        NSLog(@"111");
        [self.bgImageView addSubview:self.blurView];
        DetailViewController *detailVC = [[DetailViewController alloc]init];
        detailVC.tag = [[self.foodArray firstObject]integerValue];
        detailVC.transitioningDelegate = self;
        detailVC.modalPresentationStyle = UIModalPresentationCustom;
        [self.navigationController presentViewController:detailVC animated:YES completion:nil];
    }else {
        NSLog(@"!!! bool = %d, count =  %lu",_isStart,(unsigned long)[self.foodArray count]);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setter method

-(UILabel *)foodLabel {
    if (!_foodLabel) {
        _foodLabel = [[UILabel alloc]init];
        _foodLabel.textColor = [UIColor whiteColor];
//        _foodLabel.center = self.view.center;
        _foodLabel.text = @"小面";
        _foodLabel.clipsToBounds = YES;
        _foodLabel.layer.cornerRadius = 25;
        _foodLabel.layer.borderWidth = 2;
        _foodLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _foodLabel.textAlignment = NSTextAlignmentCenter;
        _foodLabel.adjustsFontSizeToFitWidth = YES;
        _foodLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToDetail)];

        [_foodLabel addGestureRecognizer:tap];
//        [_foodLabel sizeToFit];
    }
    return _foodLabel;
}

-(UILabel *)foodLabel1 {
    if (!_foodLabel1) {
        _foodLabel1 = [[UILabel alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToDetail)];

        [_foodLabel1 addGestureRecognizer:tap];
        _foodLabel1.textColor = [UIColor whiteColor];
        _foodLabel1.clipsToBounds = YES;
        _foodLabel1.layer.cornerRadius = 25;
        _foodLabel1.layer.borderWidth = 2;
        _foodLabel1.layer.borderColor = [UIColor whiteColor].CGColor;
//        _foodLabel1.center = self.view.center;
        _foodLabel1.userInteractionEnabled = YES;
        _foodLabel1.text = @"冒菜";
        _foodLabel1.textAlignment = NSTextAlignmentCenter;
        _foodLabel1.adjustsFontSizeToFitWidth = YES;
//        [_foodLabel1 sizeToFit];
    }
    return _foodLabel1;
}

-(UILabel *)foodLabel2 {
    if (!_foodLabel2) {
        
        _foodLabel2 = [[UILabel alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToDetail)];

        [_foodLabel2 addGestureRecognizer:tap];
        _foodLabel2.textColor = [UIColor whiteColor];
        _foodLabel2.clipsToBounds = YES;
        _foodLabel2.layer.cornerRadius = 25;
        _foodLabel2.layer.borderWidth = 2;
        _foodLabel2.layer.borderColor = [UIColor whiteColor].CGColor;
        _foodLabel2.userInteractionEnabled = YES;
//        _foodLabel2.center = self.view.center;
        _foodLabel2.text = @"杨国福";
        _foodLabel2.textAlignment = NSTextAlignmentCenter;
        _foodLabel2.adjustsFontSizeToFitWidth = YES;
    }
    return _foodLabel2;
}

-(UILabel *)foodLabel3 {
    if (!_foodLabel3) {
        _foodLabel3 = [[UILabel alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToDetail)];

        [_foodLabel3 addGestureRecognizer:tap];
        _foodLabel3.textColor = [UIColor whiteColor];
        _foodLabel3.userInteractionEnabled = YES;
//        _foodLabel3.center = self.view.center;
        _foodLabel3.clipsToBounds = YES;
        _foodLabel3.layer.cornerRadius = 25;
        _foodLabel3.layer.borderWidth = 2;
        _foodLabel3.layer.borderColor = [UIColor whiteColor].CGColor;
        _foodLabel3.text = @"烧腊";
        _foodLabel3.textAlignment = NSTextAlignmentCenter;
        _foodLabel3.adjustsFontSizeToFitWidth = YES;
//        [_foodLabel3 sizeToFit];
    }
    return _foodLabel3;
}

-(UILabel *)foodLabel4 {
    if (!_foodLabel4) {
        _foodLabel4 = [[UILabel alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToDetail)];

        [_foodLabel4 addGestureRecognizer:tap];
        _foodLabel4.textColor = [UIColor whiteColor];
        _foodLabel4.userInteractionEnabled = YES;
        _foodLabel4.clipsToBounds = YES;
        _foodLabel4.layer.cornerRadius = 25;
        _foodLabel4.layer.borderWidth = 2;
        _foodLabel4.layer.borderColor = [UIColor whiteColor].CGColor;
//        _foodLabel4.center = self.view.center;
        _foodLabel4.text = @"素菜";
        _foodLabel4.textAlignment = NSTextAlignmentCenter;
        _foodLabel4.adjustsFontSizeToFitWidth = YES;
//        [_foodLabel4 sizeToFit];
    }
    return _foodLabel4;
}

-(UILabel *)foodLabel5 {
    if (!_foodLabel5) {
        _foodLabel5 = [[UILabel alloc]init];
        _foodLabel5.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToDetail)];
        [_foodLabel5 addGestureRecognizer:tap];
        _foodLabel5.textColor = [UIColor whiteColor];
        _foodLabel5.clipsToBounds = YES;
        _foodLabel5.layer.cornerRadius = 25;
        _foodLabel5.layer.borderWidth = 2;
        _foodLabel5.layer.borderColor = [UIColor whiteColor].CGColor;
        _foodLabel5.adjustsFontSizeToFitWidth = YES;
//        _foodLabel5.center = self.view.center;
        _foodLabel5.text = @"外卖";
        _foodLabel5.textAlignment = NSTextAlignmentCenter;
//        [_foodLabel5 sizeToFit];
    }
    return _foodLabel5;
}

-(UIView *)rotateView {
    if (!_rotateView) {
        _rotateView = [[UIView alloc]initWithFrame:CGRectMake(100, 50, 200, 200)];
        _rotateView.backgroundColor = [UIColor clearColor];
        
    }
    return _rotateView;
}

-(UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.text = @"新番技术部中午吃什么！";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [[UIButton alloc]init];
        [_startButton setTitle:@"Start" forState:UIControlStateNormal];
//        [_startButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        _startButton.clipsToBounds = YES;
        _startButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _startButton.layer.borderWidth = 2;
        _startButton.layer.cornerRadius = 10;
        [_startButton  addTarget:self action:@selector(startPopAnimation) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _startButton;
}

- (UIVisualEffectView *)blurView {
    if (!_blurView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        _blurView.frame = self.view.bounds;
        _blurView.alpha = 0.7f;
    }
    return _blurView;
}

#pragma mark - UIViewControllerTransitionDelegate -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[PresentingAnimationController alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    [self.blurView removeFromSuperview];
    return [[DismissingAnimationController alloc] init];
}



@end
