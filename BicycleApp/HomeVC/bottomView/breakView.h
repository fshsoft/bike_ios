//
//  breakView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^photoselectBlock)();
typedef void (^cheakNumBlock)();
typedef void (^subMitBlock)();
@interface breakView : UIView
@property (weak, nonatomic) IBOutlet UILabel    * placholder;
@property (weak, nonatomic) IBOutlet UITextView * textView;
@property (weak, nonatomic) IBOutlet UILabel    * lenthCount;
@property (weak, nonatomic) IBOutlet UIButton   * photoSelect;
@property (weak, nonatomic) IBOutlet UIButton   * submitBtn;
@property (weak, nonatomic) IBOutlet UIButton   * cheakBtn;
@property (weak, nonatomic) IBOutlet UIButton   * bikeHeavy;
@property (weak, nonatomic) IBOutlet UIButton   * loseCode;
@property (weak, nonatomic) IBOutlet UIButton   * handCover;
@property (weak, nonatomic) IBOutlet UIButton   * loseBikebell;
@property (weak, nonatomic) IBOutlet UIButton   * bikeHead;
@property (weak, nonatomic) IBOutlet UIButton   * bikeFoot;
@property (weak, nonatomic) IBOutlet UIButton   * stopBad;
@property (weak, nonatomic) IBOutlet UIButton   * otherQuestion;
@property (nonatomic, copy)  photoselectBlock    photoselectBlock;
@property (copy ,nonatomic)  cheakNumBlock       cheakNumBlock;
@property (copy ,nonatomic)  subMitBlock         subMitBlock;
@end
