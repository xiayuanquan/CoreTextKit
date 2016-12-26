//
//  CTDispalyView.m
//  CoreTextDemo
//
//  Created by 夏远全 on 16/12/25.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import "CTDispalyView.h"
#import "CoreTextImageData.h"

//导入CoreText系统框架
#import <CoreText/CoreText.h>

@interface CTDispalyView ()<UIGestureRecognizerDelegate>
@property (strong,nonatomic)UIImageView *tapImgeView;
@property (strong,nonatomic)UIView *coverView;
@end

@implementation CTDispalyView

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvents];
    }
    return self;
}

//添加点击手势
-(void)setupEvents{
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapGestureDetected:)];
    tapRecognizer.delegate = self;
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled = YES;
}


//增加UITapGestureRecognizer的回调函数
-(void)userTapGestureDetected:(UITapGestureRecognizer *)recognizer{
    
    CGPoint point = [recognizer locationInView:self];
    for (CoreTextImageData *imagData in self.data.imageArray) {
        
        //翻转坐标系，因为ImageData中的坐标是CoreText的坐标系
        CGRect imageRect = imagData.imagePostion;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        
        //检测点击位置Point是否在rect之内
        if (CGRectContainsPoint(rect, point)) {
            
            //在这里处理点击后的逻辑
            [self showTapImage:[UIImage imageNamed:imagData.name]];
            break;
        }
    }
}

//显示图片
-(void)showTapImage:(UIImage *)tapImage{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //图片
    _tapImgeView = [[UIImageView alloc] initWithImage:tapImage];
    _tapImgeView.frame = CGRectMake(0, 0, 300, 200);
    _tapImgeView.center = keyWindow.center;
    
    
    //蒙版
    _coverView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)]];
    _coverView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    _coverView.userInteractionEnabled = YES;
    
    [keyWindow addSubview:_coverView];
    [keyWindow addSubview:_tapImgeView];
}

-(void)cancel{
    [_tapImgeView removeFromSuperview];
    [_coverView removeFromSuperview];
}


//重写drawRect方法
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
 
    //1.获取当前绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.旋转坐坐标系(默认和UIKit坐标是相反的)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.data) {
        
        CTFrameDraw(self.data.ctFrame, context);
        for (CoreTextImageData *imageData in self.data.imageArray) {
            
            UIImage *image = [UIImage imageNamed:imageData.name];
            CGContextDrawImage(context, imageData.imagePostion, image.CGImage);
        }
    }
}

@end
