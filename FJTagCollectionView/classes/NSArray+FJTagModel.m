//
//  NSArray+FJTagModel.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSArray+FJTagModel.h"

@implementation NSArray (FJTagModel)

// 是否包含Tag名称
- (BOOL)containsTagName:(NSString *)tag {
    for (FJTagModel *tagModel in self) {
        if ([[tagModel tag] isEqualToString:tag]) {
            return YES;
        }
    }
    return NO;
}

// 是否包含TagModel (判断内存)
- (BOOL)containsTagModel:(FJTagModel *)tagModel {
    for (FJTagModel *tgModel in self) {
        if ([tgModel isEqual:tagModel]) {
            return YES;
        }
    }
    return NO;
}

// 是否包含TagModel (判断tag名称)
- (BOOL)containsTagModelThruTagName:(FJTagModel *)tagModel {
    for (FJTagModel *tgModel in self) {
        if ([[tgModel tag] isEqualToString:[tagModel tag]]) {
            return YES;
        }
    }
    return NO;
}

// 删除TagModel (判断内存)
- (void)removeTagModel:(FJTagModel *)tagModel {
    if ([self containsTagModel:tagModel]) {
        [(NSMutableArray*)self removeObject:tagModel];
    }
}

// 删除TagModel (判断名称)
- (void)removeTagModelThruTagName:(FJTagModel *)tagModel {
    for (int i = (int)[self count] - 1; i >=0; i--) {
        if ([[(FJTagModel *)[self objectAtIndex:i] tag] isEqualToString:[tagModel tag]]) {
            [(NSMutableArray*)self removeObjectAtIndex:i];
        }
    }
}

@end
