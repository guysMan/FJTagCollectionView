//
//  FJTagModel.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface FJTagModel : JSONModel

// 造FJTagModel
+ (FJTagModel*)tagName:(NSString *)tagName;

// 子类继承实现
- (NSString *)tag;

@end


@protocol FJTagModel <NSObject>

@end
