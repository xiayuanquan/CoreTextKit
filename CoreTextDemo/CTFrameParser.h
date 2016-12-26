//
//  CTFrameParser.h
//  CoreTextDemo
//
//  Created by 夏远全 on 16/12/25.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"

@class CTFrameParserConfig;
@interface CTFrameParser : NSObject

/**
 *  给内容设置配置信息
 *
 *  @param content 内容
 *  @param config  配置信息
 *
 */
+(CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;

/**
 *  配置信息格式化
 *
 *  @param config 配置信息
 */
+(NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;


//=======================================================================================================//


/**
 *  给内容设置配置信息
 *
 *  @param content 内容
 *  @param config  配置信息
 */
+(CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config;

/**
 *  给内容设置配置信息
 *
 *  @param path   模板文件路径
 *  @param config 配置信息
 */
+(CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config;

@end
