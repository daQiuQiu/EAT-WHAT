//
//  DetailViewController.m
//  EAT WHAT!
//
//  Created by 易 仁 on 16/9/26.
//  Copyright © 2016年 University of Leeds. All rights reserved.
//

#import "DetailViewController.h"
#import <Masonry.h>
@interface DetailViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel     *label;
@property (strong, nonatomic) NSArray     *picArray;
@property (strong, nonatomic) NSArray     *foodArray;
@property (strong, nonatomic) NSString    *imageName;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor redColor];
    self.picArray = @[@1,@2,@3,@4,@5,@6];
    self.foodArray = @[@"重庆小面",@"蜀地冒菜",@"杨国富",@"楼下烧腊",@"铭圣素菜",@"叫外卖拉"];
    [self setupUI];
    
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popViewController)];
    [self.view addGestureRecognizer:tap];
}

- (void) setupUI {
    [self.view addSubview:self.imageView];
    [self.imageView addSubview:self.label];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (self.view);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (self.imageView).with.offset (30);
        make.right.mas_equalTo (self.imageView).with.offset (-30);
        make.top.mas_equalTo (self.imageView).with.offset (30);
        make.height.mas_equalTo (50);
    }];
    
    [self getPic];
}

- (void) getPic {
    
    self.imageName = [NSString stringWithFormat:@"D%d",(int)[self.picArray[_tag-1] integerValue]];
    self.imageView.image = [UIImage imageNamed:self.imageName];
    self.label.text = self.foodArray[_tag-1];
    NSLog(@"tag = %ld %@",(long)_tag,self.imageName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) popViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setter method
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
//        _imageView.backgroundColor = [UIColor yellowColor];
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.font = [UIFont boldSystemFontOfSize:30];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"冒菜";
    }
    return _label;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
