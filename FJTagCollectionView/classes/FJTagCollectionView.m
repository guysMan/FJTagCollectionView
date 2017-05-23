//
//  FJTagCollectionView.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/7.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJTagCollectionView.h"
#import "FJTagConfig.h"
#import "FJTextButton.h"
#import "FJTagModel.h"
#import "NSArray+FJTagModel.h"
#import <BlocksKit/BlocksKit+UIKit.h>

@interface NSString (Extend)

// 计算单行宽度（字体）
- (CGFloat)singleWidthWithLabelFont:(UIFont *)font enableCeil:(BOOL)enableCeil;

// 计算字体渲染宽高（字体，行间距，字间距，换行模式）
- (CGSize)sizeWithFont:(UIFont*)font kern:(CGFloat)kern space:(CGFloat)space linebreakmode:(NSLineBreakMode)linebreakmode limitedlineHeight:(CGFloat)limitedlineHeight renderSize:(CGSize)renderSize;

@end


@implementation NSString (Extend)

// 计算单行宽度（字体）
- (CGFloat)singleWidthWithLabelFont:(UIFont *)font enableCeil:(BOOL)enableCeil {
    CGFloat singleWidth = [self sizeWithFont:font kern:0 space:0 linebreakmode:NSLineBreakByWordWrapping limitedlineHeight:0 renderSize:CGSizeMake(MAXFLOAT, 0)].width;
    if (enableCeil) {
        return ceil(singleWidth);
    }
    return singleWidth;
}

// 计算字体渲染宽高（字体，行间距，字间距，换行模式）
- (CGSize)sizeWithFont:(UIFont*)font kern:(CGFloat)kern space:(CGFloat)space linebreakmode:(NSLineBreakMode)linebreakmode limitedlineHeight:(CGFloat)limitedlineHeight renderSize:(CGSize)renderSize {
    if (self.length == 0) {
        return CGSizeZero;
    } else if (font == nil || ![font isKindOfClass:[UIFont class]]) {
        return CGSizeZero;
    } else{
        // 字体
        NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
        [attribute setObject:font forKey:NSFontAttributeName];
        
        // 行间距和换行模式
        NSMutableParagraphStyle *style = nil;
        if (space > 0 || linebreakmode > 0 || limitedlineHeight > 0) {
            style = [[NSMutableParagraphStyle alloc] init];
            if (space > 0) {
                style.lineSpacing = space;
            }
            if (linebreakmode > 0) {
                style.lineBreakMode = linebreakmode;
            }
            if (limitedlineHeight > 0) {
                style.minimumLineHeight = limitedlineHeight;
                style.maximumLineHeight = limitedlineHeight;
            }
            [attribute setObject:style forKey:NSParagraphStyleAttributeName];
        }
        
        // 字间距
        if (kern > 0) {
            [attribute setObject:@(kern) forKey:NSKernAttributeName];
        }
        
        // 尺寸
        CGSize size = [self boundingRectWithSize:renderSize
                                         options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil].size;
        return size;
    }
    return CGSizeZero;
}


@end


#define DefaultHeight (20.0)

@interface FJTagCollectionView()

@property (nonatomic, strong) FJTagConfig *innerTagConfig;
@property (nonatomic, strong) NSMutableArray<FJTagModel *> *innerTags;
@property (nonatomic, strong) NSArray<FJTagModel *> *innerSelectedTags;
@property (nonatomic, assign) CGFloat innerWidth;


@end


@implementation FJTagCollectionView

- (NSMutableArray<FJTagModel *> *)innerTags {
    if (_innerTags == nil) {
        _innerTags = (NSMutableArray<FJTagModel *> *)[[NSMutableArray alloc] init];
    }
    return _innerTags;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// 添加Tags
- (void)addTags:(NSArray<FJTagModel *> *)tags {
    [self addTags:tags config:nil];
}

// 添加Tags(Config)
- (void)addTags:(NSArray<FJTagModel *> *)tags config:(FJTagConfig*)config {
    [self addTags:tags config:config selectedTags:nil];
}

// 添加Tags(Config, SelectedTags)
- (void)addTags:(NSArray<FJTagModel *> *)tags config:(FJTagConfig*)config selectedTags:(NSArray<FJTagModel *> *)selectedTags {
    if (tags == nil || [tags count] == 0) {
        return;
    }
    
    [self.innerTags addObjectsFromArray:tags];
    self.innerSelectedTags = selectedTags;
    if (config != nil) {
        self.innerTagConfig = config;
    }
}

// 插入Tags
// 插入Tags
- (void)insertTag:(FJTagModel *)tag atIndex:(NSUInteger)index {
    [self insertTag:tag atIndex:index config:nil];
}

// 插入Tags(Config)
- (void)insertTag:(FJTagModel *)tag atIndex:(NSUInteger)index config:(FJTagConfig*)config {
    [_innerTags insertObject:tag atIndex:index];
    if (config != nil) {
        self.innerTagConfig = config;
    }
}

// 删除Tags(名称)
- (void)removeTag:(FJTagModel *)tag {
    [_innerTags removeObject:tag];
}

// 删除Tags(Index)
- (void)removeTagAt:(NSUInteger)index {
    [_innerTags removeObjectAtIndex:index];
}

// 删除所有Tags
- (void)removeAllTags {
    [_innerTags removeAllObjects];
}

// 设置Tag View的Origin位置
- (void)setTagViewOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

// 设置Tag View的宽
- (void)setTagViewWidth:(CGFloat)width {
    self.innerWidth = width;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, DefaultHeight);
}

// 更新Tag View的高
- (void)updateTagViewHeight:(CGFloat)height {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, height);
}

// 获取TagCollectionView的大小
- (CGSize)getTagViewSize {
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

// 获取所有Tags
- (NSArray<FJTagModel *> *)allTags {
    return _innerTags;
}

// 刷新UI
- (void)refresh {
    
    NSAssert(self.innerWidth >= 1.0, @"控件必须有一个宽度或高度");
    
    if (_innerTagConfig == nil) {
        self.innerTagConfig = [[FJTagConfig alloc] init];
    }
    
    // Clear UI
    for (UIButton *tagButton in [self subviews]) {
        [tagButton removeFromSuperview];
    }
    
    CGFloat orgX = _innerTagConfig.paddingLeft;
    CGFloat orgY = _innerTagConfig.paddingTop;
    CGFloat endX = self.innerWidth - _innerTagConfig.paddingRight;
    CGFloat eachX = orgX;
    CGFloat eachY = orgY;
    for (FJTagModel *tag in self.innerTags) {

        FJTextButton *btn = [self tagButton:tag];
        if (btn.frame.size.width + eachX > endX) {
            // 换行
            eachX = orgX;
            eachY = eachY + btn.bounds.size.height + _innerTagConfig.itemVerticalSpace;
            btn.frame = CGRectMake(eachX, eachY, btn.frame.size.width, btn.frame.size.height);
        }else{
            // 不换行
            btn.frame = CGRectMake(eachX, eachY, btn.frame.size.width, btn.frame.size.height);
        }
        [self addSubview:btn];
        eachX += btn.bounds.size.width + _innerTagConfig.itemHorizontalSpace;
    }
    [self updateTagViewHeight:(eachY + _innerTagConfig.itemMinHeight + _innerTagConfig.paddingBottom)];
    
    
    // Debug
    if (_innerTagConfig.debug) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.84 blue:0.38 alpha:1.0];
        
        UIView * v = [[UIView alloc] initWithFrame:CGRectMake(_innerTagConfig.paddingLeft, _innerTagConfig.paddingTop, self.bounds.size.width - _innerTagConfig.paddingLeft - _innerTagConfig.paddingRight, self.bounds.size.height - _innerTagConfig.paddingTop - _innerTagConfig.paddingBottom)];
        [self insertSubview:v atIndex:0];
        v.backgroundColor = [UIColor colorWithRed:0.0 green:0.73 blue:0.98 alpha:1.0];;
        
    }
}

- (FJTextButton*)tagButton:(FJTagModel *)tagModel {
    
    FJTextButton *button = [[FJTextButton alloc] initWithFrame:CGRectMake(0, 0, _innerTagConfig.itemMinWidth, _innerTagConfig.itemMinHeight)];
    button.tagModel = tagModel;
    if (self.innerSelectedTags == nil || [self.innerSelectedTags count] == 0 || ![self.innerSelectedTags containsTagModel:tagModel]) {
        [button setTitle:[tagModel tag] config:_innerTagConfig selected:NO];
    }else{
        [button setTitle:[tagModel tag] config:_innerTagConfig selected:YES];
    }

    CGFloat textWidth = [[tagModel tag] singleWidthWithLabelFont:_innerTagConfig.tagTextFont enableCeil:YES];
    CGFloat buttonWidth = textWidth + _innerTagConfig.itemPaddingLeft + _innerTagConfig.itemPaddingRight;
    if (buttonWidth >= self.innerWidth - _innerTagConfig.paddingLeft - _innerTagConfig.paddingRight) {
        button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, self.innerWidth - _innerTagConfig.paddingLeft - _innerTagConfig.paddingRight, button.frame.size.height);
    }else if (buttonWidth >= _innerTagConfig.itemMinWidth) {
        button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, buttonWidth, button.frame.size.height);
    }else {
        button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, _innerTagConfig.itemMinWidth, button.frame.size.height);
    }
    
    __weak typeof(self) weakSelf = self;
    [button bk_addEventHandler:^(FJTextButton *sender) {
        if (_innerTagConfig.enableMultiTap) {
            weakSelf.tagMultiTappedBlock == nil ? : weakSelf.tagMultiTappedBlock(sender.tagModel, [(FJTextButton*)sender selected]);
        }else{
            weakSelf.tagTappedBlock == nil ? : weakSelf.tagTappedBlock(sender.tagModel);
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    return button;
}

// 计算控件高度
+ (CGSize)calculateSize:(CGFloat)width tags:(NSArray<FJTagModel *> *)tags config:(FJTagConfig*)config {
    
    CGFloat orgX = config.paddingLeft;
    CGFloat orgY = config.paddingTop;
    CGFloat endX = width - config.paddingRight;
    CGFloat eachX = orgX;
    CGFloat eachY = orgY;
    for (FJTagModel *tag in tags) {
        
        CGFloat textWidth = [[tag tag] singleWidthWithLabelFont:config.tagTextFont enableCeil:YES];
        CGFloat buttonWidth = textWidth + config.itemPaddingLeft + config.itemPaddingRight;
        if (buttonWidth >= width) {
            buttonWidth = width - config.paddingLeft - config.paddingRight - 1.0;
        }else if (buttonWidth >= config.itemMinWidth) {
            
        }else {
            buttonWidth = config.itemMinWidth;
        }
        
        if (buttonWidth + eachX > endX) {
            // 换行
            eachX = orgX;
            eachY = eachY + config.itemMinHeight + config.itemVerticalSpace;
        }else{
            // 不换行
        }
        eachX += buttonWidth + config.itemHorizontalSpace;
    }
    return CGSizeMake(width, (eachY + config.itemMinHeight + config.paddingBottom));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

