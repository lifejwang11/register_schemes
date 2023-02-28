//
//  SingleBean.h
//  RegisterSchemes
//
//  Created by kaifabu on 2020/10/20.
//
#import <Foundation/Foundation.h>
 
@interface SingleTon : NSObject
+ (SingleTon*) getInstance;
 
@property (nonatomic,strong) NSDictionary *dict;
@end
