//
//  RegisterModule.m
//  RegisterSchemes
//
//  Created by kaifabu on 2020/10/16.
//

#import "RegisterModule.h"
#import "SingleTon.h"


@implementation RegisterModule
@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(render:callback:))
WX_EXPORT_METHOD(@selector(removeObj:callback:))
WX_EXPORT_METHOD(@selector(dismiss))


NSDictionary *info;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    if (self = [super init]) {
        /* 监听App停止运行事件，如果alert存在，调一下dismiss方法移除 */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"PDRCoreAppDidStopedKey" object:nil];
    }
    return self;
}

/**
 解析数据
 
 @param option 相关设置信息
 */
-(void)parseOption:(NSDictionary *)option {


}
//获取当前屏幕显示的UIViewController
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark - Export Method
- (void)render:(NSDictionary *)options callback:(WXModuleKeepAliveCallback)callback
{
    NSDictionary *test = SingleTon.getInstance.dict;
    callback(SingleTon.getInstance.dict,YES);
}

- (void)removeObj:(NSDictionary *)options callback:(WXModuleKeepAliveCallback)callback
{
    SingleTon.getInstance.dict = nil;
    callback(@"Success",YES);
}

- (void)dismiss
{
    
}

- (void)fileNotification:(NSNotification *)notifcation {
    info = notifcation.userInfo;
    // fileName是文件名称、filePath是文件存储在本地的路径
    // jfkdfj123a.pdf
 //   fileName= [info objectForKey:@"fileName"];
    // /private/var/mobile/Containers/Data/Application/83643509-E90E-40A6-92EA-47A44B40CBBF/Documents/Inbox/jfkdfj123a.pdf
//    filePath = [info objectForKey:@"filePath"];
    
 //   NSLog(@"fileName=%@---filePath=%@", info.fileName, info filePath);
}
@end

