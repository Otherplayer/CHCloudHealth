//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by __无邪_ on 4/5/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHTextField.h"

@implementation CHTextField


//控制清除按钮的位置
-(CGRect)clearButtonRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x + bounds.size.width - 15 - 16, (bounds.origin.y + bounds.size.height - 16) / 2, 16, 16);
}

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width -30, bounds.size.height);//更好理解些
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    //return CGRectInset( bounds, 10 , 0 );
    CGRect inset = CGRectMake(bounds.origin.x +15, bounds.origin.y, bounds.size.width - 45, bounds.size.height);
    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width - 45, bounds.size.height);//更好理解些
    return inset;
}

////控制左视图位置
//- (CGRect)leftViewRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
//    return inset;
//    //return CGRectInset(bounds,50,0);
//}

////控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect{
//    //    [super drawPlaceholderInRect:rect];
//    [[UIColor orangeColor] setFill];
//    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
//    //    paragraphStyle.lineHeightMultiple = rect.size.height/2;
//    paragraphStyle.minimumLineHeight = rect.size.height/1.5;
//    paragraphStyle.maximumLineHeight = rect.size.height;
//    NSDictionary*attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
//                               NSForegroundColorAttributeName:[UIColor color_b3b3b3],
//                               NSParagraphStyleAttributeName:paragraphStyle};
//    [[self placeholder] drawInRect:rect withAttributes:attribute];
//}

@end
