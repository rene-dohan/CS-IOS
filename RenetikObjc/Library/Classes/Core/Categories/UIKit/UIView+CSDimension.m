//
// Created by Rene Dohan on 17/07/18.
//

#import "UIView+CSDimension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSAutoResizing.h"
#import "CSLang.h"
#import "NSException+CSExtension.h"

@implementation UIView (CSDimension)

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setWidth:(CGFloat)value {
    CGRect frame = self.frame;
    frame.size.width = value;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)value {
    CGRect frame = self.frame;
    frame.size.height = value;
    self.frame = frame;
}

- (CGSize)calculateSizeFromSubviews {
    var rect = CGRectZero;
    for (UIView *view in self.subviews) rect = CGRectUnion(rect, view.frame);
    return rect.size;
}

- (CGFloat)calculateHeightToFitWidth {
    CGSize newSize = [self sizeThatFits:CGSizeMake(self.width, MAXFLOAT)];
    return newSize.height;
}

- (instancetype)size:(CGSize)size {
    self.size = size;
    return self;
}

- (instancetype)frame:(CGRect)rect {
    self.frame = rect;
    return self;
}

- (instancetype)setSize:(CGSize)size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    return self;
}

- (instancetype)width:(CGFloat)width height:(CGFloat)height {
    [self size:CGSizeMake(width, height)];
    return self;
}

- (instancetype)sizeBySquare:(CGFloat)square {
    return [self width:square height:square];
}

- (instancetype)width:(CGFloat)value {
    self.width = value;
    return self;
}

- (instancetype)widthAsHeight {
    self.width = self.height;
    return self;
}

- (instancetype)height:(CGFloat)value {
    self.height = value;
    return self;
}

- (instancetype)hideByHeightIf:(BOOL)hide {
    if (hide) self.height = 0;
    return self;
}

- (instancetype)heightAsWidth {
    self.height = self.width;
    return self;
}

- (instancetype)addWidth:(CGFloat)value {
    self.width += value;
    return self;
}

- (instancetype)addHeight:(CGFloat)value {
    self.height += value;
    return self;
}

- (instancetype)removeWidth:(CGFloat)value {
    self.width -= value;
    return self;
}

- (instancetype)removeHeight:(CGFloat)value {
    self.height -= value;
    return self;
}

- (instancetype)resizeToFit {
    [self sizeToFit];
    return self;
}

- (instancetype)heightToFit {
    if (self.width <= 0) {
        @throw [NSException exceptionWithName:@"Width has to be set to calculate height"];
    }
    CGSize newSize = [self sizeThatFits:CGSizeMake(self.width, MAXFLOAT)];
    return [self height:newSize.height];
}

- (instancetype)widthToFit {
    NSAssert(self.height > 0, @"Height has to be set to calculate height");
    CGSize newSize = [self sizeThatFits:CGSizeMake(MAXFLOAT, self.height)];
    return [self width:newSize.width];
}

- (instancetype)resizeToFitSubviews {
    return [self size:self.calculateSizeFromSubviews];
}

- (instancetype)resizeByPadding:(CGFloat)padding {
    if (self.isFixedLeft) [self addRight:padding]; else [self addLeft:padding];
    if (self.isFixedTop) [self addBottom:padding]; else [self addTop:padding];
    if (self.isFixedRight) [self addLeft:padding]; else [self addRight:padding];
    if (self.isFixedBottom) [self addTop:padding]; else [self addBottom:padding];
    return self;
}

- (instancetype)addLeft:(CGFloat)value {
    self.left -= value;
    self.width += value;
    return self;
}

- (instancetype)addTop:(CGFloat)value {
    self.top -= value;
    self.height += value;
    return self;
}

- (instancetype)addRight:(CGFloat)value {
    self.width += value;
    return self;
}

- (instancetype)addBottom:(CGFloat)value {
    self.height += value;
    return self;
}

@end
