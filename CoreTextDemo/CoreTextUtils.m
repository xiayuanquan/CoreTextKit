//
//  CoreTextUtils.m
//  CoreTextDemo
//
//  Created by 夏远全 on 16/12/26.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import "CoreTextUtils.h"

@implementation CoreTextUtils

//检测点击位置是否在链接上
+(CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data{
    
    CTFrameRef textFrame = data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) return nil;
    CFIndex count = CFArrayGetCount(lines);
    CoreTextLinkData *foundLink = nil;
    
    //获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    //翻转坐标系
    CGAffineTransform tranform = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    tranform = CGAffineTransformScale(tranform, 1.f, -1.f);
    for (int i=0; i<count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        //获取每一行的CGRect信息
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, tranform);
        
        if (CGRectContainsPoint(rect, point)) {
            //将点击的坐标转换成相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x-CGRectGetMinX(rect), point.y-CGRectGetMinY(rect));
            
            //获得当前点击坐标对应的字符串偏移
            CFIndex idx = CTLineGetStringIndexForPosition(line, relativePoint);
            
            //判断这个偏移是否在我们的链接列表中
            foundLink = [self linkAtIndex:idx linkArray:data.linkArray];
            
            return foundLink;
        }
    }
    return nil;
}

//获取每一行的CGRect信息
+(CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y, width, height);
}

//判断这个偏移是否在我们的链接列表中
+(CoreTextLinkData *)linkAtIndex:(CFIndex)i linkArray:(NSArray *)linkArray{
    
    CoreTextLinkData *link = nil;
    for (CoreTextLinkData *data in linkArray) {
        if (NSLocationInRange(i, data.range)) {
            link = data;
            break;
        }
    }
    return link;
}

@end
