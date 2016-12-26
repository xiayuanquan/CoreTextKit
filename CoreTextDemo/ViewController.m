//
//  ViewController.m
//  CoreTextDemo
//
//  Created by 夏远全 on 16/12/25.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "CTDispalyView.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CTFrameParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建画布
    CTDispalyView *dispaleView = [[CTDispalyView alloc] initWithFrame:self.view.bounds];
    dispaleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dispaleView];
    
    //设置配置信息
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = dispaleView.width;
    

    //获取模板文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JsonTemplate" ofType:@"json"];
    
    //创建绘制数据实例
    CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
    dispaleView.data = data;
    dispaleView.height = data.height;
    dispaleView.backgroundColor = [UIColor yellowColor];
}

@end
