//
//  LoginViewController.m
//  EAT WHAT!
//
//  Created by 易 仁 on 16/10/13.
//  Copyright © 2016年 University of Leeds. All rights reserved.
//

#import "LoginViewController.h"
#import <Masonry.h>
#import "ViewController.h"
@interface LoginViewController ()
@property (nonatomic, strong) UIButton * designDepButton;
@property (nonatomic, strong) UIButton * techDepButton;
@property (nonatomic, strong) UIButton * otherDepButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setupUI];
}

- (void) setupUI {
    [self.view addSubview:self.designDepButton];
    [self.view addSubview:self.techDepButton];
    [self.view addSubview:self.otherDepButton];
    
    [_designDepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (self.view.mas_centerX);
        make.size.mas_equalTo (CGSizeMake(200, 100));
        make.top.mas_equalTo(self.view).with.offset (100);
    }];
    
    [_techDepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (self.view.mas_centerX);
        make.size.mas_equalTo (CGSizeMake(200, 100));
        make.top.mas_equalTo(_designDepButton.mas_bottom).with.offset (100);
    }];
    
    [_otherDepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (self.view.mas_centerX);
        make.size.mas_equalTo (CGSizeMake(200, 100));
        make.top.mas_equalTo(_techDepButton.mas_bottom).with.offset (100);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginMethod: (UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    
    ViewController *VC = [[ViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


///////getter///////////
- (UIButton *)designDepButton {
    if (!_designDepButton) {
        _designDepButton = [[UIButton alloc]init];
        [_designDepButton addTarget:self action:@selector(loginMethod:) forControlEvents:UIControlEventTouchUpInside];
        _designDepButton.tag = 1;
        [_designDepButton setTitle:@"设计部" forState:UIControlStateNormal];
        [_designDepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _designDepButton.backgroundColor = [UIColor magentaColor];
        _designDepButton.clipsToBounds = YES;
        _designDepButton.layer.cornerRadius = 25;
    }
    return _designDepButton;
}

- (UIButton *)techDepButton {
    if (!_techDepButton) {
        _techDepButton = [[UIButton alloc]init];
        [_techDepButton addTarget:self action:@selector(loginMethod:) forControlEvents:UIControlEventTouchUpInside];
        _techDepButton.tag = 2;
        [_techDepButton setTitle:@"技术部" forState:UIControlStateNormal];
        [_techDepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _techDepButton.backgroundColor = [UIColor redColor];
        _techDepButton.clipsToBounds = YES;
        _techDepButton.layer.cornerRadius = 25;
    }
    return _techDepButton;
}

- (UIButton *)otherDepButton {
    if (!_otherDepButton) {
        _otherDepButton = [[UIButton alloc]init];
        [_otherDepButton addTarget:self action:@selector(loginMethod:) forControlEvents:UIControlEventTouchUpInside];
        _otherDepButton.tag = 3;
         [_otherDepButton setTitle:@"其他部门" forState:UIControlStateNormal];
        [_otherDepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _otherDepButton.backgroundColor = [UIColor grayColor];
        _otherDepButton.clipsToBounds = YES;
        _otherDepButton.layer.cornerRadius = 25;
    }
    return _otherDepButton;
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
