//
//  changeNumTool.h
//  蓝牙
//
//  Created by 雨停 on 2017/11/3.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface changeNumTool : NSObject
/**  Hex  表示十六进制 **/

/**
 *   将 NSString 字符串 转化为 16 进制字符串  @"abcde" --> @"0a1234 0b23454"
 */
+(NSString*)coverFromStringToHexStr:(NSString*)string;


/**
 *  将 16 进制字符串 转化为 NString 字符串  @"0a1234 0b23454" -- > @"abcde"
 */

+(NSString*)coverFromHexStringToStr:(NSString*)hexStr;

/**
 *  将 16 进制字符串 转化为 NSData   此处注意的是: 传入的字符串转为 128位 字符 不足位的补了数字  如果需要对应位  截取位置即可   @"0a1234 0b23454" -- > <0a1234 0b23454>
 */

+(NSData*)coverFromHexStrToData:(NSString*)hexStr;

/**
 *   将字符串 转化为 对应的  ASCII 字符串
 */

+(NSString*)coverFromStringToAsciiStr:(NSString*)string;


/**
 *  将字符串8个字符之后添加空格
 */
+(NSString *)stringAppendSpace:(NSString *)string;


/**
 *  将 16 进制 NSData 转化为 NSString 字符串  <0a1234 0b23454> --> @"0a1234 0b23454"
 */
+(NSString*)coverFromHexDataToStr:(NSData*)hexData;


/**
 *  将 NSString  转化为 NSData @"abcde" --> <0a1234 0b23454>
 */
+(NSData*)coverFromStringToHexData:(NSString*)string;

/**
 *  将 NSData 转化为  16进制字符串   <0x00adcc asdfgwerf asdddffdfd> --> @"0x00adccasdfgwerfasdddffdfd"
 */

+(NSString*)coverFromDataToHexStr:(NSData*)data;


/**
 *  将 byte 数组 -- > NSData  Byte bytes[] --> <0a1234 0b23454>
 */
+(void)coverFromBytesArrToData;

/**
 *  将 byte 数组 -- > 16 进制字符串 Byte bytes[] --> @"0a1234 0b23454"
 */
+(void)coverFromBytesArrToHexStr;



/**
 *  16 进制字符串 -- > 10 进制数字   @"0F" --> 15   @"10" -- > 16
 */
+(UInt64)coverFromHexStrToInt:(NSString*)hexStr;


/**
 *  10进制  --- > 16 进制字符串  15 ---> @"0F"
 */
+(NSString*)coverFromIntToHex:(NSInteger)tmpid;


/**
 *  将 int 类型 --> NSData 4 个字节接收
 */
+(NSData *) setId:(int)Id;

/**
 *  NSData  --> int  4 个字节接收表示
 */
+(int) setDa:(NSData*)intData;


/**
 *  将时间戳 int ---> 4 个字节的 Data 数据
 */
+(NSData*) coverToByteWithData:(int)timeInterval;


@end
