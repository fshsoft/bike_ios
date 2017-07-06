//
//  PaySelect.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/10.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaySelect : NSObject
- (void)weChatPayButtonAction;
-(void)Order;
- (void)getWeChatPayWithOrderName:(NSString *)name
                            price:(NSString*)price;
- (void)doAlipayPayAppID:(NSString *)appID  Price:(NSString *)price orderNum:(NSString *)ordernum orderTime:(NSString *)ordertime PrivateKey:(NSString *)privateKey Body:(NSString *)body subJect:(NSString *)subject;
@end
