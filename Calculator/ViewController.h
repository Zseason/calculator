//
//  ViewController.h
//  Calculator
//
//  Created by zhaoyibo on 15/3/13.
//  Copyright (c) 2015年 zhaoyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYMBOL_PLUS     @"+"
#define SYMBOL_MINUS    @"-"
#define SYMBOL_MUL      @"×"
#define SYMBOL_DIVISION @"÷"
#define SYMBOL_EQUAL    @"="
#define SYMBOL_PERCENT  @"%"
#define SYMBOL_CONTARY  @"+/-"



@interface ViewController : UIViewController
@property(retain,nonatomic)UIButton *button;
@property(retain,nonatomic)UILabel *label;
@property(retain,nonatomic)NSMutableString *string;
@property(assign,nonatomic)double num1,num2,num3,num4;
@property(assign,nonatomic)float screenWidth,screenHeight,btnY;
@property(assign,nonatomic)bool bGo,bAddSymbol,bClean;
@property(strong,nonatomic) UIButton *m_BtnClean;

-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
-(UIButton *)createBtnWithTittle:(NSString *)strTittle FrameRect:(CGRect)framerect NormalColor:(UIColor*)normalcolor SelectColor:(UIColor*)selectcolor;

@end

