//
//  FJTextButton.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/10.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJTagConfig.h"
#import "FJTagModel.h"

@interface FJTextButton : UIButton

@property (nonatomic, strong) FJTagModel *tagModel;

- (void)setTitle:(NSString *)title config:(FJTagButtonConfig *)config selected:(BOOL)selected;

- (BOOL)selected;

@end
