//
//  FJTagConfig.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/10.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJTagConfig.h"

@implementation FJTagButtonConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tagTextColor                    = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.tagBackgroundColor              = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.tagBorderColor                  = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.tagHighlightedTextColor         = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.tagHighlightedBackgroundColor   = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        self.tagHighlightedBorderColor       = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.tagTextFont                     = [UIFont systemFontOfSize:12.0];
        self.tagHighlightedTextFont          = [UIFont systemFontOfSize:12.0];
        self.tagBorderWidth                  = 0.5;
        self.tagCornerRadius                 = 4.0;
        self.enableMultiTap                  = NO;
        
    }
    return self;
}

@end

@implementation FJTagConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.paddingTop           = 10.0;
        self.paddingLeft          = 10.0;
        self.paddingBottom        = 10.0;
        self.paddingRight         = 10.0;
        self.itemHorizontalSpace  = 5.0;
        self.itemVerticalSpace    = 5.0;
        self.itemMinWidth         = 40.0;
        self.itemMinHeight        = 24.0;
        self.itemPaddingLeft      = 5.0;
        self.itemPaddingRight     = 5.0;
    }
    return self;
}

@end
