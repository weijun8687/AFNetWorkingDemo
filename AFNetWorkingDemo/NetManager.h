//
//  NetManager.h
//  AFNetWorkingDemo
//
//  Created by WJ on 17/2/23.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

+ (instancetype)share;

- (void)post;

- (void)postImage;
@end
