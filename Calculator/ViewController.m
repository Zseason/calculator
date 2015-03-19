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
//string保存字符，显示数值。num1是存输入的数值，num2是存运算符前的数值，num3是运算结果，num4是判断进行何种运算
//bGo 是否做＝运算；bAddSymbol是否添加运算符号, bClean为是否删除
@synthesize button,label,string,num1,num2,num3,num4,bGo,bAddSymbol,bClean,m_BtnClean,screenWidth,screenHeight,btnY;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //背景色
    [self.view setBackgroundColor:[UIColor colorWithRed:31.f/255.f green:32.f/255.f blue:34.f/255.f alpha:1.0f]];
    
    CGSize mSize = [[UIScreen mainScreen] bounds].size;
    screenWidth = mSize.width;
    screenHeight = mSize.height;
    btnY = screenHeight*0.3;
    CGFloat btnHeight = (screenHeight*0.7)/5;
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
    self.label=[[UILabel alloc]init];
    [self.view addSubview:label];
    
    self.label.backgroundColor=[UIColor clearColor];//清空背景颜色
    self.label.textColor=[UIColor whiteColor];//字体颜色
    self.label.textAlignment=NSTextAlignmentRight;//字体居右
    self.label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60];
    [self.label setLineBreakMode:NSLineBreakByTruncatingHead];//前面部分文字以……方式省略,显示尾部文字内容。
    [self setOutPut:@"0"];
    
    //添加1-9数字
    NSArray *array=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@".", nil];
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
    UIButton *button0 = [self createBtnWithTittle:[array objectAtIndex:n++]
                                FrameRect:CGRectMake(0, screenHeight-btnHeight, btnWidth*2, btnHeight)
                                NormalColor:normalCol SelectColor:selectCol];
    //[button0 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button0 setContentEdgeInsets:UIEdgeInsetsMake(0, -btnWidth, 0, 0)];
    [button0 addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button0];
    
    //添加.
    UIButton *button4 = [self createBtnWithTittle:[array objectAtIndex:n++]
                                FrameRect:CGRectMake(btnWidth*2, screenHeight-btnHeight, btnWidth, btnHeight)
                                NormalColor:normalCol SelectColor:selectCol];
    [button4 addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];

    //添加运算符
    NSArray *array1=[NSArray arrayWithObjects:SYMBOL_PLUS,SYMBOL_MINUS,SYMBOL_MUL,SYMBOL_DIVISION,nil];
    for (int i=0; i<4; i++)
    {
        UIButton *button1 = [self createBtnWithTittle:[array1 objectAtIndex:i]
                                FrameRect:CGRectMake(btnWidth*3, screenHeight-btnHeight*(i+2), btnWidth, btnHeight)
                                NormalColor:symbolNormalCol SelectColor:symbolSelectCol];
        [button1 setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitleColor: [UIColor colorWithRed:104.f/255.0f green:104.f/255.0f blue:104.f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
        
        button1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50];
        [button1 setContentEdgeInsets:UIEdgeInsetsMake(-btnHeight*0.1, 0, 0, 0)];
        [self.view addSubview:button1];
        [button1 addTarget:self action:@selector(two:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //添加=
    UIButton *button2 = [self createBtnWithTittle:SYMBOL_EQUAL
                                FrameRect:CGRectMake(btnWidth*3, screenHeight-btnHeight, btnWidth, btnHeight)
                                NormalColor:symbolNormalCol SelectColor:symbolSelectCol];
    [button2 setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [button2 setTitleColor: [UIColor colorWithRed:104.f/255.0f green:104.f/255.0f blue:104.f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    button2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50];
    [button2 setContentEdgeInsets:UIEdgeInsetsMake(-btnHeight*0.1, 0, 0, 0)];
    [button2 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    //添加清除键
    UIButton *button3 = [self createBtnWithTittle:@"AC"
                                        FrameRect:CGRectMake(0, btnY, btnWidth, btnHeight)
                                      NormalColor:normalCol2 SelectColor:selectCol2];
    [button3 addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    self.m_BtnClean = button3;
    
    //添加 ＋－符号
    UIButton *button5 = [self createBtnWithTittle:SYMBOL_CONTARY
                                        FrameRect:CGRectMake(btnWidth, btnY, btnWidth, btnHeight)
                                      NormalColor:normalCol2 SelectColor:selectCol2];
    [button5 addTarget:self action:@selector(three:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    //add % 符号
    UIButton *button6 = [self createBtnWithTittle:SYMBOL_PERCENT
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
    if ([self.string hasPrefix:SYMBOL_PLUS]||[self.string hasPrefix:SYMBOL_MINUS]||[self.string hasPrefix:SYMBOL_MUL]||[self.string hasPrefix:SYMBOL_DIVISION])//判断是否为运算符
    {
        [self.string setString:@""];//字符串清零
    }
    NSString *aString = [sender currentTitle];
    
    //输入的事小数点.,在字符串中找到点，停止输入第二个点， 如果字符串时空的，修正字符串为@“0”
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
        //显示的0 不是0. 不会连续输入多个0
        NSRange range;
        range = [self.string rangeOfString:@"."];
        if(range.location == NSNotFound)
        {
            [self setOutPut:@"0"];
            return;
        }
    }
    
    [self.string appendString:aString];//数字连续输入
    [self setOutPut:[NSString stringWithString:string]];
    self.num1=[self.label.text doubleValue];//保存输入的数值
    NSLog(@"%f",self.num1);
    
    //新的运算，需要覆盖之前的运算结果，用于开启新的运算
    //bGo == true && self.num4!=0 表示已经做了＝运算，尚未输入新的符号运算
    if(bGo == true && self.num4!=0 && bAddSymbol == false)
    {
        self.num4 = 0;
    }
    bGo = false;
    [m_BtnClean setTitle:@"C" forState:UIControlStateNormal];//按钮文本
    bClean = false;
}

-(void)two:(id)sender
{
    //bGo == false && self.num4!=0 表示尚未做＝运算，尚未输入新的符号运算，用作连续加减乘除
    if(bGo == false && self.num4 != 0 && bAddSymbol)
    {
        [self go:sender];
    }
    [self.string setString:@""];//字符串清零
    [self.string appendString:[sender currentTitle]];
    //self.label.text=[NSString stringWithString:string];
    self.num3 = [self.label.text doubleValue];
    
    //判断输入是+号
    if ([self.string isEqualToString:SYMBOL_PLUS])
    {
        self.num4=1;
    }
    //判断输入是-号
    else if([self.string isEqualToString:SYMBOL_MINUS])
    {
        self.num4=2;
    }
    //判断输入是*号
    else if([self.string isEqualToString:SYMBOL_MUL])
    {
        self.num4=3;
    }
    //判断输入是/号
    else if([self.string isEqualToString:SYMBOL_DIVISION])
    {
        self.num4=4;
    }
    bAddSymbol = true;
}

//数值取反和％
-(void)three:(id)sender
{
    NSString *symbolStr = [[NSString alloc] init];
    symbolStr =[sender currentTitle];
    double tempNum;
    if ([symbolStr isEqualToString:SYMBOL_CONTARY])
    {
        tempNum= -1*[self.label.text doubleValue];
    }
    else if([symbolStr isEqualToString:SYMBOL_PERCENT])
    {
        tempNum= 0.01*[self.label.text doubleValue];
    }
    else
    {
        return;
    }
    
    NSString *sstring = [NSString stringWithFormat:@"%.14f",tempNum];
    sstring = [self stringMethod:sstring];
    if(sstring.length>25)
    {
        sstring = [NSString stringWithFormat:@"%.14e",tempNum];
        sstring = [self stringEMethod:sstring];
    }
    [self setOutPut:sstring];
    [self.string setString:@""];
    
    if(bGo)
    {
        self.num3 = tempNum;
    }
    else
    {
        self.num1 = tempNum;
    }
}

//=运算
-(void)go:(id)sender
{
    bGo = true;
    bAddSymbol =false;
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
    
    //运算结果是整数
    if(floor(self.num3)==self.num3)
    {
        if(self.num3 > 1000000000)
        {
            NSString *str = [self stringEMethod:[NSString stringWithFormat:@"%.14e", self.num3]];
            [self setOutPut:str];
        }
        else
        {
            [self setOutPut:[NSString stringWithFormat:@"%d", (int)self.num3]];
        }
    }
    else
    {
        NSString *sstring = [NSString stringWithFormat:@"%.14f",self.num3];
        sstring = [self stringMethod:sstring];
        if(sstring.length>25)
        {
            sstring = [self stringEMethod:sstring];
            sstring = [NSString stringWithFormat:@"%.14e",self.num3];
        }
        [self setOutPut:sstring];
    }
    
    [self.string setString:@""];
    
    NSLog(@"height = %.2f", self.label.frame.size.height);
}

//去除小数位多余的0
-(NSString *)stringMethod:(NSString *)str{
 
    NSUInteger length = str.length;
    
    NSRange range;
    range = [str rangeOfString:@"."];
    if(range.location == NSNotFound)
    {
        return str;
    }
    else
    {
        for(int i=0; i< (length-range.location); i++)
        {
            NSString * tempstring = [str substringWithRange:NSMakeRange(length-2-i, 1)];
            if(![tempstring isEqualToString:@"0"])
            {
                if([tempstring isEqualToString:@"."])
                {
                    i++;
                }
                str = [str substringWithRange:NSMakeRange(0, length-1-i)];
                break;
            }
        }
    }
    return str;
}

//去除科学计数法小数位多余的0
-(NSString *)stringEMethod:(NSString *)str{
    
    NSUInteger length = str.length;
    
    NSRange range;
    range = [str rangeOfString:@"e"];
    if(range.location == NSNotFound)
    {
        return str;
    }
    
    NSString *estr = [str substringWithRange:NSMakeRange(range.location, length-range.location)];
    NSString *tempstr = [str substringWithRange:NSMakeRange(0, range.location)];
    tempstr = [self stringMethod:tempstr];
    str = tempstr;
    str = [str stringByAppendingString:estr];
    return str;
}



-(void)setOutPut:(NSString *)str
{
    if([str isEqualToString:@"inf"])
    {
        [self setOutPut:@"不是数字"];//保证下次输入时清零
        [self.string setString:@""];//清空字符串
        self.num3=0;
        self.num2=0;
        self.num1=0;
        self.num4=0;
        bGo = false;
        bAddSymbol = false;
        return;
    }
    float posY = 5;
    float frameWidth = screenWidth-20;
    NSUInteger length = str.length;
    if(length <=9)
    {
        self.label.font=[UIFont systemFontOfSize:60];
        [self.label setFrame:(CGRectMake(10, btnY-60-posY, frameWidth, 60))];
    }
    else
    {
        self.label.minimumScaleFactor = 0.35;
        self.label.adjustsFontSizeToFitWidth = YES;
    }
    self.label.text=str;//计算结果显示出来
}


//当按下清除建时，所有数据清零
-(void)clean:(id)sender{
    if(!bClean)
    {
        [m_BtnClean setTitle:@"AC" forState:UIControlStateNormal];//按钮文本
        bClean = true;
        [self setOutPut:@"0"];
        [self setNum1:0];
        [self.string setString:@""];//数字连续输入
    }
    else
    {
        [self.string setString:@""];//清空字符串
        self.num3=0;
        self.num2=0;
        self.num1=0;
        self.num4=0;
        bGo = false;
        bAddSymbol = false;
        [self setOutPut:@"0"];//保证下次输入时清零
    }
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
    CGColorRef colorref = CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 146.f/255.f, 147.f/255.f, 150.f/255.f, 1 });
    
    UIButton * mButton =[UIButton buttonWithType:UIButtonTypeCustom];
    
    //[mButton setBackgroundColor:[UIColor whiteColor]];
    [mButton setFrame:framerect];//按钮大小和位置
    [mButton setTitle:strTittle forState:UIControlStateNormal];//按钮文本
    mButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40];
    //mButton.titleLabel.font = [UIFont systemFontOfSize:28];
    [mButton setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];

    [mButton.layer setMasksToBounds:YES];
    [mButton.layer setBorderWidth:0.5];   //边框宽度
    [mButton.layer setBorderColor:colorref];//边框颜色
    
    [mButton setBackgroundImage: [self imageWithColor:normalcolor size:framerect.size] forState:UIControlStateNormal];
    [mButton setBackgroundImage: [self imageWithColor:selectcolor size:framerect.size] forState:UIControlStateHighlighted];
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

- (void)dealloc
{
    
}

@end
