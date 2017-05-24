//
//  NSArray+FJTagModel.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJTagModel.h"

@interface NSArray (FJTagModel)

// 是否包含Tag名称
- (BOOL)containsTagName:(NSString *)tag;

// 是否包含TagModel (判断内存)
- (BOOL)containsTagModel:(FJTagModel *)tagModel;

// 是否包含TagModel (判断tag名称)
- (BOOL)containsTagModelThruTagName:(FJTagModel *)tagModel;

// 删除TagModel (判断内存)
- (void)removeTagModel:(FJTagModel *)tagModel;

// 删除TagModel (判断名称)
- (void)removeTagModelThruTagName:(FJTagModel *)tagModel;

@end
