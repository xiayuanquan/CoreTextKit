//
//  CoreTextUtils.h
//  CoreTextDemo
//
//  Created by 夏远全 on 16/12/26.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextLinkData.h"
#import "CoreTextData.h"

@interface CoreTextUtils : NSObject

/**
 *  检测点击位置是否在链接上
 *
 *  @param view  点击区域
 *  @param point 点击坐标
 *  @param data  数据源
 */
+(CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;


@end
