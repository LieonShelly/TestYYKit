//
//  NSString+AES128.h
//  Bank
//
//  Created by Koh Ryu on 16/5/31.
//  Copyright © 2016年 ChangHongCloudTechService. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

- (NSString *)AES128EncryptWithKey:(NSString *)key andIv:(NSString *)ivKey;
- (NSString *)AES128DecryptWithKey:(NSString *)key andIv:(NSString *)ivStr;

@end
