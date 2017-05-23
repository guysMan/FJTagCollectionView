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

// 是否包含TagModel
- (BOOL)containsTagModel:(FJTagModel *)tagModel;

// 删除TagModel
- (void)removeTagModel:(FJTagModel *)tagModel;

@end
