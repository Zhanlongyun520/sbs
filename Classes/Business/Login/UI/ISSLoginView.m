//
//  ISSLoginView.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSLoginView.h"
#import "Masonry.h"
#import "ISSLoginUserModel.h"

@interface ISSLoginView()<UITextFieldDelegate>
{
    UIView      * backgroundView;
    UILabel     * phoneLabel;
    UILabel     * verifyLabel;
    UIImageView * logoIV;

    UIImageView * userIV;
    UIImageView * passwordIV;
    UIImageView * userLine;
    UIImageView * passwordLine;
    
    UIView      * bottomLine;
    
}

@end

@implementation ISSLoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addLoginUI];
    }
    return self;
}

#pragma mark - Cusitom Function

- (void)addLoginUI
{
    self.backgroundColor = ISSColorWhite;
    
    logoIV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 128)/2, 64, 128, 115)];
    logoIV.image = [UIImage imageNamed:@"loginlogo"];
    [self addSubview:logoIV];
    
    userIV = [[UIImageView alloc]initWithFrame:CGRectMake(42, logoIV.bottom + 40, 18, 18)];
    userIV.image = [UIImage imageNamed:@"loginuser-blue"];
    [self addSubview:userIV];
    
    [self addSubview:self.phoneTextField];

    userLine = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(32), _phoneTextField.bottom, kScreenWidth - ALD(64), 1.5)];
    userLine.backgroundColor = ISSColorNavigationBar;
    [self addSubview:userLine];

    passwordIV = [[UIImageView alloc]initWithFrame:CGRectMake(42, userLine.bottom + 28, 18, 18)];
    passwordIV.image = [UIImage imageNamed:@"loginpassword-gray"];
    [self addSubview:passwordIV];

    [self addSubview:self.verifyTextField];

    passwordLine = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(32), _verifyTextField.bottom, kScreenWidth - ALD(64), 1.5)];
    passwordLine.backgroundColor = ISSColorNavigationBar;
    [self addSubview:passwordLine];
    
//    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _verifyTextField.bottom, kScreenWidth, 0.5)];
//    bottomLine.backgroundColor = ISSColorSeparatorLine;
//    [self addSubview:bottomLine];
//
    [self addSubview:self.loginBtn];
    
    _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkButton.selected = YES;
    [_checkButton setImage:[UIImage imageNamed:@"login-checkbox"] forState:UIControlStateNormal];
    [_checkButton setImage:[UIImage imageNamed:@"login-checkbox-select"] forState:UIControlStateSelected];
    [_checkButton addTarget:self action:@selector(checkMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_checkButton];
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@44);
        make.left.equalTo(self.loginBtn);
        make.top.equalTo(self.loginBtn.mas_bottom);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor grayColor];
    label.text = @"记住用户名和密码";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_checkButton);
        make.left.equalTo(_checkButton.mas_right);
        make.right.equalTo(@0);
    }];
    
    NSString *name = [ISSLoginUserModel getAccountName];
    NSString *password = [ISSLoginUserModel getAccountPassword];
    if (name && password) {
        self.phoneTextField.text = name;
        self.verifyTextField.text = password;
    } else {
        [self.phoneTextField becomeFirstResponder];
    }
}


- (void)allTFResignFirstResponder
{
    [self.phoneTextField resignFirstResponder];
    [self.verifyTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
//    self.loginBtn.enabled = NO;
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        userIV.image = [UIImage imageNamed:@"loginuser-blue"];
        userLine.backgroundColor = ISSColorNavigationBar;
        passwordIV.image = [UIImage imageNamed:@"loginpassword-gray"];
        passwordLine.backgroundColor = ISSColorSeparatorLine;
    }
    if (textField == self.verifyTextField) {
        userIV.image = [UIImage imageNamed:@"loginuser-gray"];
        userLine.backgroundColor = ISSColorSeparatorLine;
        passwordIV.image = [UIImage imageNamed:@"loginpassword--blue"];
        passwordLine.backgroundColor = ISSColorNavigationBar;

    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    if (textField == self.phoneTextField) {
//        if ([string length] > 0) {
//            if (textField.text.length >= 11) {
//                return NO;
//            }
//        }
//    }
//
//    if (textField == self.verifyTextField) {
//        if ([string length] > 0) {
//            if (textField.text.length >= 6) {
//                return NO;
//            }
//        }
//    }
    
//    if (string.length > 0 ) {
//        if (self.phoneTextField.text.length >0 && self.verifyTextField.text.length > 0) {
//            self.loginBtn.enabled = YES;
//        }
//    }else{
//        if (textField.text.length <= 1) {
//            if (self.phoneTextField.text.length <= 11 && self.verifyTextField.text.length <= 1) {
//                self.loginBtn.enabled = NO;
//            }
//        }
//    }
    
    return YES;
}

#pragma mark - Setter And Getter

- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(userIV.right + 20, logoIV.bottom + 20, kScreenWidth - 84 - userIV.width, ALD(54))];
        _phoneTextField.font = ISSFont18;
        _phoneTextField.textColor = ISSColorDardGray2;
//        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;//无小数点
        _phoneTextField.placeholder = @"账号";
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}


- (UITextField *)verifyTextField
{
    if (_verifyTextField == nil) {
        _verifyTextField = [[UITextField alloc] initWithFrame:CGRectMake(passwordIV.right + 20, userLine.bottom + 10, kScreenWidth - 84 - passwordIV.width, ALD(54))];
        _verifyTextField.font = ISSFont18;
//        _verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
        _verifyTextField.placeholder = @"密码";
        _verifyTextField.secureTextEntry = YES;
        _verifyTextField.textColor = ISSColorDardGray2;
        _verifyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verifyTextField.delegate = self;
    }
    return _verifyTextField;
}

- (UIButton *)loginBtn
{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setFrame:CGRectMake(ALD(32), ALD(30) + passwordLine.bottom, kScreenWidth - ALD(64), ALD(44))];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:ISSColorWhite forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:ISSFont15];
        [_loginBtn setBackgroundImage:[ISSUtilityMethod createImageWithColor:ISSColorNavigationBar] forState:UIControlStateDisabled];
        [_loginBtn setBackgroundImage:[ISSUtilityMethod createImageWithColor:ISSColorNavigationBar] forState:UIControlStateNormal];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 4;
//        _loginBtn.enabled = NO;
        _loginBtn.adjustsImageWhenHighlighted = NO;
    }
    return _loginBtn;
}

- (void)checkMethod {
    _checkButton.selected = !_checkButton.isSelected;
}

@end
