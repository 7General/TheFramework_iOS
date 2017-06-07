//
//  httpUrlEncrypt.m
//  eTax
//
//  Created by TianGuang on 14-3-25.
//  Copyright (c) 2014年 YSYC. All rights reserved.
//

#import "httpUrlEncrypt.h"
#import "CommanFunc.h"
#import <CommonCrypto/CommonDigest.h>

@implementation httpUrlEncrypt

+(NSArray *)compareSortArray:(NSArray *)array{
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *resultArray = [array sortedArrayUsingComparator:sort];
    
    return resultArray;
}


+(NSDictionary *)UrlEncrypt:(NSDictionary *)dic {
    NSArray *keyArray =  [httpUrlEncrypt compareSortArray:[dic allKeys]];
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc]init];
    NSString *sigContent = @"";
    for(NSString *keys in keyArray){
        //NSData 加密优化处理
        BOOL isData = [dic[keys] isKindOfClass:[NSData class]]?YES:NO;
        
        if (isData) {
            NSData *value =dic[keys];
            [resultDictionary setObject:value forKey:keys];
        }else{
            
            //NSString *value = [Base64 encodeBase64String:dic[keys]];
            NSString * value = __BASE64(dic[keys]);
            value = [NSString stringWithFormat:@"%@",value];
            [resultDictionary setObject:value forKey:keys];
            sigContent = [NSString stringWithFormat:@"%@%@%@",sigContent,keys,value];
            
        }
        
    }
    
    sigContent = [self cov2MD5FromString:[sigContent stringByAppendingString:@"3A3KHDSDS"]];
    [resultDictionary setObject:sigContent forKey:@"sig"];
    
    return resultDictionary;
}

+(NSDictionary *)UrlEncryptForCloud:(NSDictionary *)dic{
    NSArray *keyArray =  [httpUrlEncrypt compareSortArray:[dic allKeys]];
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc]init];
    NSString *sigContent = @"";
    for(NSString *keys in keyArray){
//        NSString *value =[Base64 encodeBase64String:dic[keys]];
        NSString *value =__BASE64(dic[keys]);
        //url会自动将加密的‘＋’转换为‘ ’ 提前做替换转意
        //        value = [value stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                      NULL, /* allocator */
                                                                                      (CFStringRef)value,
                                                                                      NULL, /* charactersToLeaveUnescaped */
                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                      kCFStringEncodingUTF8));
        
        value = [NSString stringWithFormat:@"%@",value];
        [resultDictionary setObject:value forKey:keys];
        
        sigContent = [NSString stringWithFormat:@"%@%@%@",sigContent,keys,value];
        
    }
    
    sigContent = [self cov2MD5FromString:[sigContent stringByAppendingString:@"3A3KHDSDS"]];
    [resultDictionary setObject:sigContent forKey:@"sig"];
    
    return resultDictionary;
}

+ (NSString *)cov2MD5FromString:(NSString *)str {
    
    if(str == nil || [str length] == 0) {
        return nil;
    }
    
    const char *value = [str UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (unsigned int)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

@end
