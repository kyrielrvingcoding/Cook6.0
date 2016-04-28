//
//  CYloginRegisterViewController.m
//  聪颖不聪颖
//
//  Created by 葛聪颖 on 15/9/27.
//  Copyright © 2015年 gecongying. All rights reserved.
//

#import "CYloginRegisterViewController.h"
#import "HyLoglnButton.h"
#import "CYLoginRegisterTextField.h"
#import "NetWorkrequestManage.h"
#import <CommonCrypto/CommonCrypto.h> //MD5加密文件
#import "UserInofManager.h"


@interface CYloginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingSpace;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UIView *LoginView;

@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *registButton;

//切换登录注册按钮
@property (weak, nonatomic) IBOutlet UIButton *LoginAndRegistBtn;
//注册TF
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *registPhonenumberTF;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *registPasswordTF;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *registNameTF;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *registNumberTF;

@property (weak, nonatomic) IBOutlet UIButton *numberButton;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, assign) int time;
@end

@implementation CYloginRegisterViewController
- (void)dealloc {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加毛玻璃
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];

    effectView.frame = SCREENBOUNDS;
    [_backGroundImageView addSubview:effectView];
    
    //添加登录按钮
//    HyLoglnButton *button = [[HyLoglnButton alloc] initWithFrame:CGRectMake(0, 0, 100 , 21)];
//    button.center = CGPointMake(self.LoginButton.frame.size.width / 2.0 - 50, self.LoginButton.frame.size.height / 2.0);
    HyLoglnButton *button = [[HyLoglnButton alloc] initWithFrame:self.LoginButton.frame];
    CGPoint point = CGPointMake(SCREENWIDTH / 2.0f, button.center.y);
    button.center = point;
    [self.LoginView addSubview:button];
    
    [button setBackgroundColor:[UIColor colorWithRed:136.0f / 255.0f green:186.0f / 255.0f blue:0 alpha:1]];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(LoginToViewController:) forControlEvents:(UIControlEventTouchUpInside)];

   //添加一个键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    //  将要隐藏的方法
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 切换登录、注册界面
- (IBAction)loginOrRegister:(UIButton *)button
{
    _registNameTF.hidden = NO;
    [_registButton setTitle:@"注册" forState:(UIControlStateNormal)];

    _phoneNumberTF.text = @"";
     _passwordTF.text = @"";
     _registNameTF.text = @"";
     _registNumberTF.text = @"";
     _registPasswordTF.text = @"";
    _registPhonenumberTF.text = @"";
    
    [_phoneNumberTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [_registNameTF resignFirstResponder];
    [_registNumberTF resignFirstResponder];
    [_registPasswordTF resignFirstResponder];
    [_registPhonenumberTF resignFirstResponder];
    
    // 修改约束
    if (self.leadingSpace.constant == 0) {
        self.leadingSpace.constant = - self.view.width;
//        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
        button.selected = YES;
    }else
    {
        self.leadingSpace.constant = 0;
//        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//登录按钮
- (void)LoginToViewController:(HyLoglnButton *)button {
    button.enabled = NO;
    NSString *MD5String = [self passwordByMD5:self.passwordTF.text];

    NSString *phoneNumber = self.phoneNumberTF.text;
    NSString *url = [NSString stringWithFormat:@"http://www.xdmeishi.com/index.php?m=mobile&c=index&a=login&account=%@&password=%@",phoneNumber, MD5String];
    [NetWorkrequestManage requestWithType:GET url:url parameters:nil finish:^(NSData *data) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //根据返回值进行判断
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([dataDict[@"result"] isEqualToString:@"ok"]) {
                [button ExitAnimationCompletion:^{
                    button.enabled = YES;
                    [self dismissViewControllerAnimated:YES completion:nil];
//                    NSLog(@"执行跳转指令%@",dataDict);
                    [UserInofManager conserveSessionID:dataDict[@"sessionId"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshLoginMessage" object:nil];
                }];
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width,self.view.frame.size.height / 2 , 300, 40)];
                label.backgroundColor = [UIColor colorWithRed:89 / 255.0 green:84 / 255.0 blue:70 / 255.0 alpha:1];
                label.font = [UIFont systemFontOfSize:20];
                label.layer.masksToBounds = YES;
                label.layer.cornerRadius = 20;
                label.textAlignment = NSTextAlignmentCenter;
                label.center = CGPointMake(SCREENWIDTH / 2.0f, SCREENHEIGHT / 2.0f);
                label.text = @"登录失败，请重新登录";
                label.alpha = 0;
                [self.view addSubview:label];
                [UIView animateWithDuration:1.0 animations:^{
                    label.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:1.0 animations:^{
                        label.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        [label removeFromSuperview];
                        button.enabled = YES;
                    }];
                }];

                [button ErrorRevertAnimationCompletion:^{
                    NSLog(@"登录失败");
                    //                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入信息有误" message:dataDict[@"description"] preferredStyle:(UIAlertControllerStyleAlert)];
//                    
//                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//                        
//                        [alert dismissViewControllerAnimated:YES completion:^{
//                            self.phoneNumberTF.text = @"";
//                            self.passwordTF.text = @"";
//                            
//                        }];
//                    }];
//                    [alert addAction:action];
//                    [self presentViewController:alert animated:YES completion:nil];
                }];
                
                
            }
        });
        
    

    } error:^(NSError *error) {
        
    }];

    
    
}

//注册按钮
- (IBAction)RegistToViewController:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (_registNameTF.hidden == YES) {
        _registNameTF.text = @"  ";
    }
    if ([_registPhonenumberTF.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入信息有误" message:@"请输入手机号" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:^{
                
                [self.registPhonenumberTF becomeFirstResponder];
                
            }];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else
    if ([_registPasswordTF.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入信息有误" message:@"请输入密码" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:^{
                [self.registNumberTF becomeFirstResponder];
                
            }];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else
    if ([_registNameTF.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入信息有误" message:@"请输入昵称" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:^{
                [self.registNameTF becomeFirstResponder];
                
            }];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else
    if ([_registNumberTF.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入信息有误" message:@"请输入验证码" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:^{
                [self.registNumberTF becomeFirstResponder];
                
            }];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        if (_registNameTF.hidden == YES) {
            
        } else {
        NSString *urlStr = [NSString stringWithFormat:@"http://www.xdmeishi.com/index.php?m=mobile&c=index&a=register&password=%@&account=%@&checkcode=%@&nickname=%@&invitationCode=",[self passwordByMD5:  _registPasswordTF.text],_registPhonenumberTF.text,_registNumberTF.text,[_registNameTF.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
        [NetWorkrequestManage requestWithType:GET url:urlStr parameters:nil finish:^(NSData *data) {
            NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];

            //根据返回的值来判断是否注册成功
            dispatch_async(dispatch_get_main_queue(), ^{
            button.enabled = NO;
            if ([dicData[@"result"] isEqualToString:@"error"]) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width,self.view.frame.size.height / 2 , 300, 40)];
                label.backgroundColor = [UIColor colorWithRed:89 / 255.0 green:84 / 255.0 blue:70 / 255.0 alpha:1];
                label.font = [UIFont systemFontOfSize:20];
                label.layer.masksToBounds = YES;
                label.layer.cornerRadius = 20;
                label.textAlignment = NSTextAlignmentCenter;
                label.center = CGPointMake(SCREENWIDTH / 2.0f, SCREENHEIGHT / 2.0f);
                label.text = dicData[@"description"];
                label.alpha = 0;
                [self.view addSubview:label];
                [UIView animateWithDuration:1.0 animations:^{
                    label.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:1.0 animations:^{
                        label.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        [label removeFromSuperview];
                        button.enabled = YES;
                    }];
                }];
                
            } else {
                button.enabled = YES;
                //跳转

                [UserInofManager conserveSessionID:dicData[@"sessionId"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshLoginMessage" object:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
                  });
        } error:^(NSError *error) {
            
        }];
        }
    }

}

//找回密码
- (void)findPassword {
    NSString *urlStr1 = [NSString stringWithFormat:@"http://www.xdmeishi.com/index.php?m=mobile&c=index&a=verifyCheckcode&checkcode=%@&account=%@",_registNumberTF, _registPhonenumberTF];
    [NetWorkrequestManage requestWithType:GET url:urlStr1 parameters:nil finish:^(NSData *data) {
        NSDictionary *dataDic  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        if ([dataDic[@"description"] isEqualToString:@"成功"]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *urlFindPassword = [NSString stringWithFormat:@"http://www.xdmeishi.com/index.php?m=mobile&c=index&a=changePwd&account=%@&key=%@&password=%@",_registPhonenumberTF, dataDic[@"data"], [self passwordByMD5:_registPasswordTF.text]];
                [NetWorkrequestManage requestWithType:GET url:urlFindPassword parameters:nil finish:^(NSData *data) {
                    //根据返回
                    NSDictionary *PasswordDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                    if ([PasswordDic[@"reslut"] isEqualToString:@"error"]) {
                        [self showlabel:PasswordDic[@"description"]];
                    } else {
                        [self showlabel:@"密码找回成功，请重新登录"];
                        [self loginOrRegister:_LoginAndRegistBtn];
                    }
                } error:^(NSError *error) {
                    
                }];
            });
            //执行下一个方法
        } else {
            [self showlabel:dataDic[@"description"]];
        }
    } error:^(NSError *error) {
        
    }];
}

- (void) showlabel:(NSString *)string {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width,self.view.frame.size.height / 2 , 300, 40)];
    label.backgroundColor = [UIColor colorWithRed:89 / 255.0 green:84 / 255.0 blue:70 / 255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:20];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 20;
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(SCREENWIDTH / 2.0f, SCREENHEIGHT / 2.0f);
    label.text = string;
    label.alpha = 0;
    [self.view addSubview:label];
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            label.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];

}
- (IBAction)getNumber:(id)sender {
    //获取验证码
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        return;
    }
    button.selected = YES;
    
    //验证号码是否正确
    BOOL isTrue = [self isPhonenumber:_registPhonenumberTF.text];
    _time = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeJump:) userInfo:nil repeats:YES];
    [_timer fire];
    if (isTrue) {
        NSString *strUrl = [NSString stringWithFormat:@"http://www.xdmeishi.com/index.php?m=mobile&c=index&a=checkcode&account=%@",_registPhonenumberTF.text];
        [NetWorkrequestManage requestWithType:GET url:strUrl parameters:nil finish:^(NSData *data) {
            
        } error:^(NSError *error) {
            
        }];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入的手机号码有误" message:@"请输入正确的手机号码" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)forgetPasswordBut:(UIButton *)sender {
       [self loginOrRegister:_LoginAndRegistBtn];
    _registNameTF.hidden = YES;
    [_registButton setTitle:@"找回密码" forState:(UIControlStateNormal)];

    

}

//键盘将要显示的方法
- (void)keyboardShow:(NSNotification *)noti {
    
}

//将密码装换成md5字符串
- (NSString *)passwordByMD5:(NSString *)MD5String{
    const char *MD5string = [MD5String UTF8String];
    unsigned char reust[CC_MD5_DIGEST_LENGTH];
    CC_MD5(MD5string, (CC_LONG)strlen(MD5string), reust);
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [str appendFormat:@"%02X",reust[i]];
    }
    //参数中只识别小写字母，大小写区分
    NSString *str1 = [str lowercaseString];
    
    return str1;
}

//判断输入时否是手机号码的正则的表达式
- (BOOL)isPhonenumber:(NSString *)phoneNumber {
    if (phoneNumber.length < 11) {
        return NO;
    } else {
        //移动手机号码正则表达式
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        //联通号码正则表达式
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        //电信号码正则表达式
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phoneNumber];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phoneNumber];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phoneNumber];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        } else {
            return NO;
        }
    }
}

//定时器方法
- (void)timeJump:(id)sender {
    if (_time == 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_numberButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        });
        _numberButton.selected = NO;
        [_timer invalidate];
        _timer = nil;
    } else {
    _time --;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_numberButton setTitle:[NSString stringWithFormat:@"%0.2d秒后重试",_time] forState:(UIControlStateNormal)];
        });
    }
}
@end
