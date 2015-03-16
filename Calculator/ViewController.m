//
//  ViewController.m
//  Calculator
//
//  Created by zhaoyibo on 15/3/13.
//  Copyright (c) 2015年 zhaoyibo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize button,label,string,num1,num2,num3,num4,bGo;//string保存字符，显示数值。num1是存输入的数值，num2是存运算符前的数值，num3是运算结果，num4是判断进行何种运算

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //背景色
    [self.view setBackgroundColor:[UIColor colorWithRed:123.0f/255.f green:115.0f/255.f blue:99.0f/255.f alpha:1.0f]];
    
    CGSize mSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = mSize.width;
    CGFloat screenHeight = mSize.height;
    CGFloat btnY = screenHeight*0.4;
    CGFloat btnHeight = (screenHeight*0.6)/5;
    CGFloat btnWidth = screenWidth/4;
    bGo = false;
    
    UIColor *symbolNormalCol = [UIColor colorWithRed:249.f/255.0f green:147.f/255.0f blue:61.f/255.0f alpha:1.0f];
    UIColor *symbolSelectCol = [UIColor colorWithRed:198.f/255.0f green:116.f/255.0f blue:46.f/255.0f alpha:1.0f];
    
    UIColor *normalCol = [UIColor colorWithRed:224.f/255.0f green:224.f/255.0f blue:224.f/255.0f alpha:1.0f];
    UIColor *selectCol = [UIColor colorWithRed:178.f/255.0f green:178.f/255.0f blue:178.f/255.0f alpha:1.0f];
    
    UIColor *normalCol2 = [UIColor colorWithRed:214.f/255.0f green:214.f/255.0f blue:214.f/255.0f alpha:1.0f];
    UIColor *selectCol2 = [UIColor colorWithRed:169.f/255.0f green:169.f/255.0f blue:169.f/255.0f alpha:1.0f];
    
    //添加提示性文字
//    UIAlertView *alex=[[UIAlertView alloc]initWithTitle:@"使用说明" message:@"只支持两数的计算以及在此基础上的计算，不支持连算。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alex show];
    
    //创建标签
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, screenWidth-20, btnY-20)];
    [self.view addSubview:label];
    self.label.backgroundColor=[UIColor clearColor];//清空背景颜色
    self.label.textColor=[UIColor blackColor];//字体颜色
    self.label.textAlignment=NSTextAlignmentRight;//字体居右
    self.label.font=[UIFont systemFontOfSize:32.4];
    self.label.text=@"0";//初始为0
    
    
    //添加1-9数字
    NSArray *array=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    int n=0;
    for (int i=0; i<3; i++)
    {
        for (int j=0; j<3; j++)
        {
            self.button = [self createBtnWithTittle:[array objectAtIndex:n++]
                            FrameRect:CGRectMake(btnWidth*j, screenHeight-btnHeight*(i+2), btnWidth, btnHeight)
                            NormalColor:normalCol SelectColor:selectCol];
            [self.button addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }

    //单独添加0
    UIButton *button0 = [self createBtnWithTittle:@"0"
                                FrameRect:CGRectMake(0, screenHeight-btnHeight, btnWidth*2, btnHeight)
                                NormalColor:normalCol SelectColor:selectCol];
    //[button0 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button0 setContentEdgeInsets:UIEdgeInsetsMake(0, -btnWidth, 0, 0)];
    [button0 addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button0];
    
    //添加.
    UIButton *button4 = [self createBtnWithTittle:@"."
                                FrameRect:CGRectMake(btnWidth*2, screenHeight-btnHeight, btnWidth, btnHeight)
                                NormalColor:normalCol SelectColor:selectCol];
    [button4 addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];

    //添加运算符
    NSArray *array1=[NSArray arrayWithObjects:@"+",@"-",@"×",@"÷",nil];
    for (int i=0; i<4; i++)
    {
        UIButton *button1 = [self createBtnWithTittle:[array1 objectAtIndex:i]
                                FrameRect:CGRectMake(btnWidth*3, screenHeight-btnHeight*(i+2), btnWidth, btnHeight)
                                NormalColor:symbolNormalCol SelectColor:symbolSelectCol];
        [button1 setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitleColor: [UIColor colorWithRed:104.f/255.0f green:104.f/255.0f blue:104.f/255.0f alpha:1.0f] forState:UIControlStateSelected];
        [self.view addSubview:button1];
        [button1 addTarget:self action:@selector(two:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //添加=
    UIButton *button2 = [self createBtnWithTittle:@"="
                                FrameRect:CGRectMake(btnWidth*3, screenHeight-btnHeight, btnWidth, btnHeight)
                                NormalColor:symbolNormalCol SelectColor:symbolSelectCol];
    [button2 setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [button2 setTitleColor: [UIColor colorWithRed:104.f/255.0f green:104.f/255.0f blue:104.f/255.0f alpha:1.0f] forState:UIControlStateSelected];
    [button2 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    //添加清除键
    UIButton *button3 = [self createBtnWithTittle:@"AC"
                                        FrameRect:CGRectMake(0, btnY, btnWidth, btnHeight)
                                      NormalColor:normalCol2 SelectColor:selectCol2];
    [button3 addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    //添加 ＋－符号
    UIButton *button5 = [self createBtnWithTittle:@"＋／－"
                                        FrameRect:CGRectMake(btnWidth, btnY, btnWidth, btnHeight)
                                      NormalColor:normalCol2 SelectColor:selectCol2];
    [button5 addTarget:self action:@selector(three:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    //add % 符号
    UIButton *button6 = [self createBtnWithTittle:@"%"
                                        FrameRect:CGRectMake(btnWidth*2,btnY, btnWidth, btnHeight)
                                      NormalColor:normalCol2 SelectColor:selectCol2];
    [button6 addTarget:self action:@selector(three:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    
    //初始化可变字符串，分配内存
    self.string=[[NSMutableString alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)one:(id)sender
{
    //保证是符号时在输入数字时隐藏
    if ([self.string hasPrefix:@"+"]||[self.string hasPrefix:@"-"]||[self.string hasPrefix:@"×"]||[self.string hasPrefix:@"÷"])//判断是否为运算符
    {
        [self.string setString:@""];//字符串清零
    }
    NSString *aString = [sender currentTitle];
    
    if([aString isEqualToString:@"."])
    {
        NSRange range;
        range = [self.string rangeOfString:@"."];
        if(range.location != NSNotFound)
        {
            return;
        }
        else if([self.string isEqualToString:@""])
        {
            [self.string setString:@"0"];
        }
    }
    else if([aString isEqualToString:@"0"] && self.num1 == 0)
    {
        NSRange range;
        range = [self.string rangeOfString:@"."];
        if(range.location == NSNotFound)
        {
            self.label.text=@"0";//显示数值
            return;
        }
    }
    
    [self.string appendString:aString];//数字连续输入
    self.label.text=[NSString stringWithString:string];//显示数值
    self.num1=[self.label.text doubleValue];//保存输入的数值
    NSLog(@"%f",self.num1);
    
    bGo = false;
}

-(void)two:(id)sender
{
    if(bGo == false && self.num4 != 0)
    {
        [self go:sender];
        bGo = true;
    }
    [self.string setString:@""];//字符串清零
    [self.string appendString:[sender currentTitle]];
    //self.label.text=[NSString stringWithString:string];
    self.num3 = [self.label.text doubleValue];
    
    //判断输入是+号
    if ([self.string isEqualToString:@"+"])
    {
        self.num4=1;
    }
    //判断输入是-号
    else if([self.string isEqualToString:@"-"])
    {
        self.num4=2;
    }
    //判断输入是*号
    else if([self.string isEqualToString:@"×"])
    {
        self.num4=3;
    }
    //判断输入是/号
    else if([self.string isEqualToString:@"÷"])
    {
        self.num4=4;
    }
}

//数值取反和％
-(void)three:(id)sender
{
    NSString *symbolStr = [[NSString alloc] init];
    symbolStr =[sender currentTitle];
    if ([symbolStr isEqualToString:@"＋／－"])//hasPrefix:判断字符串以加号开头
    {
        self.num3= -1*[self.label.text doubleValue];
        self.label.text=[NSString stringWithFormat:@"%f",self.num3];//计算结果显示出来
        [self.string setString:@""];
    }
    else if([symbolStr isEqualToString:@"%"])
    {
        self.num3= 0.01*[self.label.text doubleValue];
        self.label.text=[NSString stringWithFormat:@"%f",self.num3];//计算结果显示出来
        [self.string setString:@""];
    }
}

//=运算
-(void)go:(id)sender
{
    bGo = true;
    if(self.num4==4 && self.num1==0)
    {
        self.label.text = [NSString stringWithFormat:@"不是数字"];
        [self.string setString:@""];//清空字符串
        self.num3=0;
        self.num2=0;
        self.num1=0;
        self.num4=0;
        return;
    }
    //判断输入是+号
    if (self.num4==1)
    {
        self.num3=self.num1+self.num3;//[self.label.text doubleValue]是每次后输入的数字
    }
    //判断输入是-号
    else if(self.num4==2)
    {
        self.num3=self.num3 - self.num1;
    }
    //判断输入是*号
    else if(self.num4==3)
    {
        self.num3=self.num3*self.num1;
    }
    //判断输入是/号
    else if(self.num4==4)
    {
        self.num3=self.num3/self.num1;
    }
    else
    {
        self.num3=self.num1;
    }
    
    self.label.text=[NSString stringWithFormat:@"%f",self.num3];//计算结果显示出来
    [self.string setString:@""];
}

//当按下清除建时，所有数据清零
-(void)clean:(id)sender{
    [self.string setString:@""];//清空字符串
    self.num3=0;
    self.num2=0;
    self.num1=0;
    self.num4=0;
    self.label.text=@"0";//保证下次输入时清零
    
}

-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIButton *)createBtnWithTittle:(NSString *)strTittle FrameRect:(CGRect)framerect NormalColor:(UIColor*)normalcolor SelectColor:(UIColor*)selectcolor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 1 });
    
    UIButton * mButton =[UIButton buttonWithType:UIButtonTypeCustom];
    
    //[mButton setBackgroundColor:[UIColor whiteColor]];
    [mButton setFrame:framerect];//按钮大小和位置
    [mButton setTitle:strTittle forState:UIControlStateNormal];//按钮文本
    [mButton setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    
    
    [mButton.layer setMasksToBounds:YES];
    [mButton.layer setBorderWidth:0.5];   //边框宽度
    [mButton.layer setBorderColor:colorref];//边框颜色
    
    [mButton setBackgroundImage: [self imageWithColor:normalcolor size:framerect.size] forState:UIControlStateNormal];
    [mButton setBackgroundImage: [self imageWithColor:selectcolor size:framerect.size] forState:UIControlStateSelected];
    return mButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
