//
//  ViewController.m
//  TTTAttributedLabel
//
//  Created by chanpinzhongxin on 2018/3/9.
//  Copyright © 2018年 chanpinzhongxin. All rights reserved.
//

#import "ViewController.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH                   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT                  [[UIScreen mainScreen] bounds].size.height
#define DaoXiang                       @"对这个世界如果你有太多的抱怨\n跌倒了就不敢继续往前走\n为什么人要这么的脆弱 堕落\n请你打开电视看看\n多少人为生命在努力勇敢的走下去\n我们是不是该知足 珍惜一切 就算没有拥有\n还记得你说家是唯一的城堡\n随着稻香河流继续奔跑\n微微笑 小时候的梦我知道\n不要哭让萤火虫带着你逃跑\n乡间的歌谣永远的依靠\n回家吧 回到最初的美好 \n随著稻香河流继续奔跑 @hehehe @12344  #这是一个话题#  https://www.baidu.com  18766661627";
@interface ViewController ()<TTTAttributedLabelDelegate>
@property(nonatomic,strong)TTTAttributedLabel *aLable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLabelTitle];
    
    
    //价格显示
    UILabel * strikeLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 30, 100, 30))];
    strikeLabel.backgroundColor = [UIColor greenColor];
    NSString *textStr = [NSString stringWithFormat:@"￥%.2f元",123.0];
    
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                 NSFontAttributeName:[UIFont systemFontOfSize:16.0],
                                 NSForegroundColorAttributeName:[UIColor redColor],
                                 };
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    
    // 赋值
    strikeLabel.attributedText = attribtStr;
    
    [self.view addSubview:strikeLabel];
    // Do any additional setup after loading the view, typically from a nib.
}

- (TTTAttributedLabel *)aLable
{
    if (!_aLable)
    {
        _aLable = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 200)];
        _aLable.backgroundColor = [UIColor grayColor];
        _aLable.lineBreakMode = NSLineBreakByTruncatingTail;
        _aLable.numberOfLines = 0;
        _aLable.delegate = self;
        _aLable.lineSpacing = 10;
        //要放在`text`, with either `setText:` or `setText:afterInheritingLabelAttributesAndConfiguringWithBlock:前面才有效
        _aLable.enabledTextCheckingTypes = NSTextCheckingTypePhoneNumber|NSTextCheckingTypeAddress|NSTextCheckingTypeLink;
        //链接正常状态文本属性
         _aLable.linkAttributes = @{NSForegroundColorAttributeName:[UIColor purpleColor],NSUnderlineStyleAttributeName:@(1)};
        //链接高亮状态文本属性
        _aLable.activeLinkAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSUnderlineStyleAttributeName:@(1)};
        
    }
    return _aLable;
}
#pragma mark --- 文本赋值
- (void)setLabelTitle
{
    NSString *text = DaoXiang;
    __block CGSize size;
    
//     [text stringByReplacingOccurrencesOfString:@"18766561627" withString:@"电话" options:NSLiteralSearch range:[]]
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange         = [[mutableAttributedString string] rangeOfString:@"对这个世界如果你有太多的抱怨"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange strokeColorRange1 = [[mutableAttributedString string] rangeOfString:@"跌倒了就不敢继续往前走"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange strikeRange       = [[mutableAttributedString string] rangeOfString:@"什么人要这么的脆弱 堕落"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fillColorRange    = [[mutableAttributedString string] rangeOfString:@"请你打开电视看看"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange shadowRange       = [[mutableAttributedString string] rangeOfString:@"为生命在努力勇敢的走下去"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange obliquenessRange  = [[mutableAttributedString string] rangeOfString:@"还记得你说家是唯一的城堡"
                                                                            options:NSCaseInsensitiveSearch];
        
        
        UIEdgeInsets fillPadding  = UIEdgeInsetsMake(0, 0, 0, 0);
        
        
        
        
        // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:16];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        
        if (font) {
            
            {
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange];
                //文字颜色
                [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
                                                value:[UIColor redColor]
                                                range:fontRange];
                CFRelease(font);
                
                
            }
            
            {
                //NSStrokeColorAttributeName设置文字描边颜色，需要和NSStrokeWidthAttributeName设置描边宽度，这样就能使文字空心
                //文字描边颜色
                [mutableAttributedString addAttribute:NSStrokeColorAttributeName
                                                value:[UIColor blueColor]
                                                range:strokeColorRange1];
                //文字描边宽度
                [mutableAttributedString addAttribute:NSStrokeWidthAttributeName
                                                value:@(2.0)
                                                range:strokeColorRange1];
                
            }
            
            {
                //删除样式
                [mutableAttributedString addAttribute:kTTTStrikeOutAttributeName
                                                value:@YES
                                                range:strikeRange];
                
                //加上下划线
                [mutableAttributedString addAttribute:NSUnderlineStyleAttributeName
                                                value:[NSNumber numberWithInt:3]
                                                range:strikeRange];
                [mutableAttributedString addAttribute:NSUnderlineColorAttributeName
                                                value:[UIColor greenColor]
                                                range:strikeRange];
            }
            
            {
                //背景色
                [mutableAttributedString addAttribute:kTTTBackgroundFillColorAttributeName
                                                value:[UIColor purpleColor]
                                                range:fillColorRange];
                //控制背景色范围
                [mutableAttributedString addAttribute:kTTTBackgroundFillPaddingAttributeName
                                                value:[NSNumber valueWithUIEdgeInsets:fillPadding]
                                                range:fillColorRange];
                //控制背景色（文字边框）的圆角
                [mutableAttributedString addAttribute:kTTTBackgroundCornerRadiusAttributeName
                                                value:@(4)
                                                range:fillColorRange];
                
                //文字边框颜色
                [mutableAttributedString addAttribute:kTTTBackgroundStrokeColorAttributeName
                                                value:[UIColor purpleColor]
                                                range:fillColorRange];
            }
            
            {
                //无效
                NSShadow *shadow = [[NSShadow alloc] init];
                [shadow setShadowColor:[UIColor redColor]];
                [shadow setShadowBlurRadius:4.0];
                [shadow setShadowOffset:CGSizeMake(2, 2)];
                //阴影
                [mutableAttributedString addAttribute:NSShadowAttributeName
                                                value:shadow
                                                range:shadowRange];
            }
            
            {
                //无效
                //斜体
                //NSObliquenessAttributeName 设置字体倾斜度，取值为 NSNumber（float），正值右倾，负值左倾
                [mutableAttributedString addAttribute:NSObliquenessAttributeName
                                                value:@(5.0)
                                                range:obliquenessRange];
            }
        }
        
        //高度计算
        size = [TTTAttributedLabel sizeThatFitsAttributedString:mutableAttributedString
                                                withConstraints:CGSizeMake(SCREEN_WIDTH - 20, CGFLOAT_MAX)
                                         limitedToNumberOfLines:0];
        return mutableAttributedString;
    }];
    
    NSRange boldRange1 = [text rangeOfString:@"随著稻香河流继续奔跑" options:NSCaseInsensitiveSearch];
    [self.aLable addLinkToURL:[NSURL URLWithString:@"http://y.qq.com/portal/song/003aAYrm3GE0Ac.html"]
                    withRange:boldRange1];
    
    NSRange boldRange2 = [text rangeOfString:@"这是一个话题" options:NSCaseInsensitiveSearch];
    [self.aLable addLinkToURL:[NSURL URLWithString:@"http://y.qq.com/portal/song/003aAYrm3GE0Ac.html"]
                    withRange:boldRange2];
    //电话号码可以自动识别，也可以这样添加
    //    NSRange phoneRange = [text rangeOfString:phoneNum options:NSCaseInsensitiveSearch];
    //    [self.aLable addLinkToPhoneNumber:phoneNum withRange:phoneRange];
    
    NSRange addressRange = [text rangeOfString:@"微微笑 小时候的梦我知道" options:NSCaseInsensitiveSearch];
    [self.aLable addLinkToAddress:@{@"detailAdd":@"幸福街122号",@"lontitude":@"110.011111",@"latitude":@"30.1234"}
                        withRange:addressRange];
    
    self.aLable.frame = CGRectMake(10, 64, SCREEN_WIDTH - 20, size.height);
    
    [self.view addSubview:self.aLable];
    
   
}

#pragma mark --- 点击链接代理TTTAttributedLabelDelegate
//数据探测器会自动探测到链接，邮件地址等。下面代理，就可以实现点击链接的回调。
#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"linkClick");
//    [[UIApplication sharedApplication] openURL:url];
}
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents
{
    NSLog(@"addressClick");
    NSLog(@"detailAdd:%@,lontitude:%f,latitude:%f",addressComponents[@"detailAdd"],
          [addressComponents[@"lontitude"] floatValue],
          [addressComponents[@"latitude"] floatValue]);
}
- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    NSLog(@"phoneClick");
    NSString *num = [NSString stringWithFormat:@"tel:%@",phoneNumber];
    //    NSString *num = [NSString stringWithFormat:@"telprompt://%@",number];
    //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
//    UIApplication *application = [UIApplication sharedApplication];
//    AppDelegate *delegate = (AppDelegate *)application.delegate;
//    UIWindow *window = delegate.window;
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
//                                                                   message:[NSString stringWithFormat:@"是否拨打 %@",phoneNumber]
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消"
//                                                           style:UIAlertActionStyleCancel
//                                                         handler:^(UIAlertAction * _Nonnull action) {}];
//    
//    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定"
//                                                         style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction * _Nonnull action) {
//                                                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
//                                                       }];
//    [alert addAction:actionCancel];
//    [alert addAction:actionDone];
//    
//    [window.rootViewController presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
