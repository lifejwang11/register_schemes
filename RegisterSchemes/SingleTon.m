//
//  SingleBean.m
//  RegisterSchemes
//
//  Created by kaifabu on 2020/10/20.
//

#import <Foundation/Foundation.h>
#import "SingleTon.h"

@implementation SingleTon
static  SingleTon* instance;
 
-(instancetype)init{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        instance = [super init];
        if(nil != instance){
            instance.dict = nil;
        }
    });
    return instance;
}
 
+(SingleTon *) getInstance{
    if(nil == instance){
        instance = [[self alloc]init];
    }
    return instance;
}
 
@end
