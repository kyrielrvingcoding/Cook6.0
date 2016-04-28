//
//  CommnetButton.m
//  textField
//
//  Created by 诸超杰 on 16/4/27.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CommnetButton.h"
@implementation CommnetButton




- (instancetype)initWithSth {
    CommnetButton *button = [CommnetButton buttonWithType:UIButtonTypeCustom];
    button.textField = [[UITextField alloc] init];
    button.comment = [YYCommentControl yyCreatView];
    button.textField.inputAccessoryView = button.comment;
    [button addSubview:button.textField];

    
__weak typeof (button) wkButton = button;
    [button.comment setCancel:^{
        wkButton.comment.TextView.text = nil;
        [wkButton.comment.TextView resignFirstResponder];
        [wkButton.textField resignFirstResponder];
    
    }];
     
    [button.comment setSender:^(NSString * title)
     {

         wkButton.comment.TextView.text = nil;
         [wkButton.comment.TextView resignFirstResponder];
         [wkButton.textField resignFirstResponder];
     }];
    
    
    wkButton.block = ^ {
        [wkButton.textField becomeFirstResponder];
        [wkButton.comment.TextView becomeFirstResponder];
    };

    return button;
}

@end
