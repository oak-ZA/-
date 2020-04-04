//
//  ZATableView.m
//  ProtocolTest
//
//  Created by 张奥 on 2020/4/3.
//  Copyright © 2020 张奥. All rights reserved.
//

#import "ZATableView.h"
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
@implementation ZATableView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *view = [super hitTest:point withEvent:event];
    CGRect viewPonit = [self convertRect:CGRectMake(0, 0, SCREEN_Width, 250.f) toView:view];
    if (point.y < 0) {
        if (point.x > viewPonit.size.width || point.y > -viewPonit.size.height) {
            return nil;
        }
    }
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
