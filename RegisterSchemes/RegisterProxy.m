//
//  RegisterProxy.m
//  RegisterSchemes
//
//  Created by kaifabu on 2020/10/19.
//

#import <Foundation/Foundation.h>
#import "RegisterProxy.h"
#import "WXSDKEngine.h"
#import "SingleTon.h"

@implementation RegisterProxy


-(void)onCreateUniPlugin{
    NSLog(@"TestPlugin 有需要初始化的逻辑可以放这里！");
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"TestPlugin 有需要didFinishLaunchingWithOptions可以放这里！");
    return YES;
}
/*
- (BOOL)application:(UIApplication * _Nullable)app openURL:(NSURL * _Nonnull)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> * _Nullable)options {
    if (url) {
        NSString *fileName = url.lastPathComponent; // 从路径中获得完整的文件名（带后缀）
        // path 类似这种格式：file:///private/var/mobile/Containers/Data/Application/83643509-E90E-40A6-92EA-47A44B40CBBF/Documents/Inbox/jfkdfj123a.pdf
        NSString *path = url.absoluteString; // 完整的url字符串
        path = [self URLDecodedString:path]; // 解决url编码问题
        
        NSMutableString *string = [[NSMutableString alloc] initWithString:path];
        
        if ([path hasPrefix:@"file://"]) { // 通过前缀来判断是文件
            // 去除前缀：/private/var/mobile/Containers/Data/Application/83643509-E90E-40A6-92EA-47A44B40CBBF/Documents/Inbox/jfkdfj123a.pdf
            [string replaceOccurrencesOfString:@"file://" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, path.length)];
            
            // 此时获取到文件存储在本地的路径，就可以在自己需要使用的页面使用了
            NSDictionary *dict = @{@"fileName":fileName,
                                   @"filePath":string};
            SingleTon.getInstance.dict = dict;
            return YES;
        }
    }
    return YES;
}
*/

- (BOOL)application:(UIApplication *_Nullable)application openURL:(NSURL *_Nullable)url sourceApplication:(NSString *_Nullable)sourceApplication annotation:(id _Nonnull )annotation{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    if (url != nil) {
        NSString *path = [url absoluteString];
        path = [path stringByRemovingPercentEncoding];
        NSMutableString *string = [[NSMutableString alloc] initWithString:path];
        if ([path hasPrefix:@"file:///private"]) {
            [string replaceOccurrencesOfString:@"file:///private" withString:@"" options:NSCaseInsensitiveSearch
     range:NSMakeRange(0, path.length)];
        }
        NSArray *tempArray = [string componentsSeparatedByString:@"/"];
        NSString *fileName = tempArray.lastObject;
        NSString *sourceName = @"";
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",sourceName,fileName]];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSLog(@"文件已存在");
       //     [SVProgressHUD showErrorWithStatus:@"文件已存在"];
            return YES;
        }
   //     [MRTools creatFilePathInManager:sourceName];
        BOOL isSuccess = [fileManager copyItemAtPath:string toPath:filePath error:nil];
        if (isSuccess == YES) {
            NSDictionary *dict = @{@"filePath":filePath,@"fileName":fileName};
            SingleTon.getInstance.dict = dict;
            NSLog(@"拷贝成功");
        //    [SVProgressHUD showSuccessWithStatus:@"文件拷贝成功"];
        } else {
            NSLog(@"拷贝失败");
       //     [SVProgressHUD showErrorWithStatus:@"文件拷贝失败"];
        }
    }
    NSLog(@"application:openURL:options:");
    return  YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    if (url != nil) {
        NSString *path = [url absoluteString];
        path = [path stringByRemovingPercentEncoding];
        NSMutableString *string = [[NSMutableString alloc] initWithString:path];
        if ([path hasPrefix:@"file:///private"]) {
            [string replaceOccurrencesOfString:@"file:///private" withString:@"" options:NSCaseInsensitiveSearch
     range:NSMakeRange(0, path.length)];
        }
        NSArray *tempArray = [string componentsSeparatedByString:@"/"];
        NSString *fileName = tempArray.lastObject;
        NSString *sourceName = @"";
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",sourceName,fileName]];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSLog(@"文件已存在");
       //     [SVProgressHUD showErrorWithStatus:@"文件已存在"];
            return YES;
        }
   //     [MRTools creatFilePathInManager:sourceName];
        BOOL isSuccess = [fileManager copyItemAtPath:string toPath:filePath error:nil];
        if (isSuccess == YES) {
            NSDictionary *dict = @{@"filePath":filePath,@"fileName":fileName};
            SingleTon.getInstance.dict = dict;
            NSLog(@"拷贝成功");
        //    [SVProgressHUD showSuccessWithStatus:@"文件拷贝成功"];
        } else {
            NSLog(@"拷贝失败");
       //     [SVProgressHUD showErrorWithStatus:@"文件拷贝失败"];
        }
    }
    NSLog(@"application:openURL:options:");
    return  YES;
}

// 当文件名为中文时，解决url编码问题
- (NSString *)URLDecodedString:(NSString *)str {
NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSLog(@"decodedString = %@",decodedString);
    return decodedString;
}
@end
