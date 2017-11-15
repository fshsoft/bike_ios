//
//  changeNumTool.m
//  蓝牙
//
//  Created by 雨停 on 2017/11/3.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "changeNumTool.h"

@implementation changeNumTool
+(NSString*)coverFromStringToHexStr:(NSString*)string
{
    NSString * hexStr = [NSString stringWithFormat:@"%@",
                         [NSData dataWithBytes:[string cStringUsingEncoding:NSUTF8StringEncoding]
                                        length:strlen([string cStringUsingEncoding:NSUTF8StringEncoding])]];
    
    for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">", nil])
        hexStr = [hexStr stringByReplacingOccurrencesOfString:toRemove withString:@""];
    return hexStr;
}



+(NSString*)coverFromHexStringToStr:(NSString*)hexStr
{
    if (([hexStr length] % 2) != 0)
        return nil;
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSInteger i = 0; i < [hexStr length]; i += 2) {
        
        NSString *hex = [hexStr substringWithRange:NSMakeRange(i, 2)];
        NSInteger decimalValue = 0;
        sscanf([hex UTF8String], "%x", &decimalValue);
        [string appendFormat:@"%c", decimalValue];
    }
    return string;
    
}


//  eg： NSString *hexString = @"3e435fab9c34891f"; //16进制字符串

+(NSData*)coverFromHexStrToData:(NSString*)hexString
{
    int j=0;
    Byte bytes[128];  ///3ds key的Byte 数组， 128位
    for(int i=0;i<[hexString length];i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        NSLog(@"int_ch=%d",int_ch);
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    return [[NSData alloc] initWithBytes:bytes length:128];
}


+(NSString*)coverFromStringToAsciiStr:(NSString*)string
{
    NSString *str = @"123456789ABCDEFG";
    const char *s = [str cStringUsingEncoding:NSASCIIStringEncoding];
    size_t len = strlen(s);
    
    NSMutableString *asciiCodes = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        [asciiCodes appendFormat:@"%02x ", (int)s[i]];
    }
    return asciiCodes;
    
}


+(NSString *)stringAppendSpace:(NSString *)string
{
    if(![string isEqualToString:@""])
    {
        NSMutableString *spaceString = [[NSMutableString alloc]init];
        if(string.length > 8)  //字符串个数大于8时
        {
            NSMutableArray *spaceIndexs = [NSMutableArray new];
            for (int index = 0; index < string.length; index++) {
                NSString *tmpStr = [string substringWithRange:NSMakeRange(index, 1)];
                if ([tmpStr isEqualToString:@" "]) {
                    [spaceIndexs addObject:[NSNumber numberWithInt:index]];
                }
            }
            
            int lastIndex = (int)[[spaceIndexs lastObject] integerValue]+1;
            [spaceString appendString:[string substringWithRange:NSMakeRange(0, lastIndex)]];
            NSMutableString   *newStr =[NSMutableString stringWithString:[string substringFromIndex:lastIndex]];
            if(newStr.length == 8)
            {
                [newStr appendString:@" "];
            }
            [spaceString appendString:newStr];
            return spaceString;
        }else if(string.length == 8){  //字符串个数为8时，添加空格
            [spaceString appendString:string];
            [spaceString appendString:@" "];
            return spaceString;
        }
    }
    return  string;
    
}


+(NSString*)coverFromHexDataToStr:(NSData*)hexData
{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[hexData bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [hexData length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
    
}


+(NSData*)coverFromStringToHexData:(NSString*)string
{
    return  [string dataUsingEncoding: NSUTF8StringEncoding];
}


+(void)coverFromBytesArrToData
{
    Byte byte[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:24];
    NSLog(@"字节数组转换的data 数据为: %@",adata);
}


+(void)coverFromBytesArrToHexStr
{
    NSString *aString = @"1234abcd";
    NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
    
    //    NSData* aData = [[NSData alloc] init];
    Byte *bytes = (Byte *)[aData bytes];
    
    /**
     
     注: bytes  即为字节数组  类似于 Byte bts[] = {1,2,3,4,5};
     
     **/
    
    NSLog(@"%s",bytes);
    
    NSString *hexStr=@"";
    for(int i=0;i<[aData length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    
    NSLog(@"bytes 的16进制数为:%@",hexStr);
    NSLog(@"data 的16进制数为:%@",aData);
    
}

+(NSString*)coverFromDataToHexStr:(NSData *)data
{
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    return [NSString stringWithString:hexString];
}

+(UInt64)coverFromHexStrToInt:(NSString *)hexStr
{
    UInt64 mac1 =  strtoul([hexStr UTF8String], 0, 16);
    return mac1;
}

+(NSString *)coverFromIntToHex:(NSInteger)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    
    if(str.length == 1){
        return [NSString stringWithFormat:@"0%@",str];
    }else{
        return str;
    }
    
}


+(NSData *) setId:(int)Id {
    //用4个字节接收
    Byte bytes[4];
    bytes[0] = (Byte)(Id>>24);
    bytes[1] = (Byte)(Id>>16);
    bytes[2] = (Byte)(Id>>8);
    bytes[3] = (Byte)(Id);
    NSData *data = [NSData dataWithBytes:bytes length:4];
    return data;
}

+(NSData*)coverToByteWithData:(int)timeInterval
{
    char *p_time = (char *)&timeInterval;
    char str_time[4] = {0};
    for(int i= 0 ;i < 4 ;i++)
    {
        str_time[i] = *p_time;
        p_time ++;
    }
    
    NSData* bodyData = [NSData dataWithBytes:str_time length:4];
    return bodyData;
}


+(int) setDa:(NSData*)intData
{
    int value = CFSwapInt32BigToHost(*(int*)([intData bytes]));//655650
    return value;
}


@end
