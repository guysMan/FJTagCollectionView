//
//  ViewController.m
//  FJTagCollectionView
//
//  Created by Jeff on 2017/5/23.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "ViewController.h"
#import "FJTagCollectionView.h"
#import "FJTagConfig.h"
#import "FJTagModel.h"

@interface ViewController ()

@property (nonatomic, strong) FJTagCollectionView *tagView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.25 alpha:1.0];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.text = @"Message";
    [lb sizeToFit];
    lb.center = self.view.center;
    
    FJTagConfig *config = [FJTagConfig new];
    config.enableMultiTap = YES;
    config.tagTextFont = [UIFont systemFontOfSize:12.0];
    config.tagTextColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    config.tagBackgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.98 alpha:1.0];
    config.tagBorderColor = [UIColor clearColor];
    config.tagBorderWidth = 0.5;
    config.tagCornerRadius = 2.0;
    config.itemMinWidth = 100.0;
    config.itemMinHeight = 26.0;
    config.paddingTop = 20.0;
    config.paddingLeft = 5.0;
    config.paddingBottom = 20.0;
    config.paddingRight = 5.0;
    config.itemHorizontalSpace = 18.0;
    config.itemVerticalSpace = 16.0;
    config.tagHighlightedTextFont = [UIFont systemFontOfSize:12.0];
    config.tagHighlightedTextColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    config.tagHighlightedBackgroundColor = [UIColor whiteColor];
    config.tagHighlightedBorderColor = [UIColor blackColor];
    config.selectedImage = @"icon_selected";
    config.selectedImageSize = CGSizeMake(12.0, 12.0);
    config.itemPaddingLeft = 5.0;
    config.itemPaddingRight = 5.0;
    config.debug = YES;
    
    
    [self.tagView addTags:@[[FJTagModel tagName:@"双肩包/背包"],[FJTagModel tagName:@"手提包"],[FJTagModel tagName:@"挎包"],[FJTagModel tagName:@"旅行包"],[FJTagModel tagName:@"钱包/卡包"]] config:config];
    [self.tagView refresh];
}

- (FJTagCollectionView *)tagView {
    if (_tagView == nil) {
        
        _tagView = [[FJTagCollectionView alloc] init];
        [_tagView setTagViewOrigin:CGPointMake(0, 30)];
        [self.view addSubview:_tagView];
        [_tagView setTagViewWidth:[UIScreen mainScreen].bounds.size.width];
        _tagView.tagMultiTappedBlock = ^(__kindof FJTagModel *tag, BOOL selected) {
            NSLog(@"%@ %@", tag, selected?@"选中":@"未选中");
        };
    }
    return _tagView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
