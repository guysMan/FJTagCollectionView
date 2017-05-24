//
//  FJTagModel.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJTagModel.h"

@interface FJTagModel()

@property (nonatomic, copy) NSString *name;
@property (copy, nonatomic) NSString *pName;

@end

@implementation FJTagModel

// 造FJTagModel
+ (FJTagModel*)tagName:(NSString *)tagName {
    FJTagModel *tagModel = [[FJTagModel alloc] init];
    tagModel.name = tagName;
    return tagModel;
}

- (NSString *)tag {
    if (self.name == nil) {
        assert(@"请实现FJTagModel继承类的tag方法，返回tag名称");
    }
    return self.name;
}

- (NSString *)pTag {
    if (self.pName == nil) {
        assert(@"请实现FJTagModel继承类的pTag方法，返回pTag名称");
    }
    return self.pName;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
