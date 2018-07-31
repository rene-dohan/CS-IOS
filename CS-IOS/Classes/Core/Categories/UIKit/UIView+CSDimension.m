//
// Created by Rene Dohan on 17/07/18.
//

#import "UIView+CSDimension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSAutoResizing.h"
#import "UIView+CSExtension.h"
#import "CSLang.h"

@implementation UIView (CSDimension)

- (CGSize)size {
    return self.frame.size;
}

- (instancetype)size:(CGSize)size {
    self.size = size;
    return self;
}

- (instancetype)setSize:(CGSize)size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    return self;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (instancetype)width:(CGFloat)width height:(CGFloat)height {
    [self size:CGSizeMake(width, height)];
    return self;
}

- (void)setWidth:(CGFloat)value {
    [self width:value];
}

- (instancetype)width:(CGFloat)value {
    CGRect frame = self.frame;
    frame.size.width = value;
    self.frame = frame;
    return self;
}

- (void)setWidthFromRight:(CGFloat)width {
    [self widthFromRight:width];
}

- (instancetype)widthFromRight:(CGFloat)width {
    CGFloat right = self.fromRight;
    self.width = width;
    self.fromRight = right;
    return self;
}


- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    [self height:height];
}

- (instancetype)height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    return self;
}

- (instancetype)matchParent {
    [self matchParentWidth];
    [self matchParentHeight];
    return self;
}

- (instancetype)matchParentWithMargin:(CGFloat)margin {
    return [[self matchParentWidthWithMargin:margin] matchParentHeightWithMargin:margin];
}

- (instancetype)matchParentWidth {
    return [self width:self.superview.width].centerInParentHorizontal.flexibleWidth;
}

- (instancetype)matchParentWidthWithMargin:(CGFloat)margin {
    return [[self.matchParentWidth left:margin] fromRightToWidth:margin];
}

- (instancetype)matchParentHeightWithMargin:(CGFloat)margin {
    return [[self.matchParentHeight top:margin] fromBottomToHeight:margin];
}

- (instancetype)matchParentHeight {
    return [self height:self.superview.height].centerInParentVertical.flexibleHeight;
}

- (instancetype)addWidth:(int)value {
    self.width += value;
    return self;
}

- (instancetype)addHeight:(int)value {
    self.height += value;
    return self;
}

- (instancetype)sizeFit {
    [self sizeToFit];
    return self;
}

- (instancetype)sizeFitHeight {
    CGSize newSize = [self sizeThatFits:CGSizeMake(self.width, MAXFLOAT)];
    return [self size:CGSizeMake(fmaxf(newSize.width, self.width), newSize.height)];
}

- (instancetype)fitSubviews {
    return [self size:self.calculateSizeFromSubviews];
}

- (CGSize)calculateSizeFromSubviews {
    var rect = CGRectZero;
    for (UIView *view in self.subviews) rect = CGRectUnion(rect, view.frame);
    return rect.size;
}

- (instancetype)contentPadding:(int)padding {
    [self.content left:padding top:padding];
    [[self addWidth:padding * 2] addHeight:padding * 2];
    return self;
}

- (instancetype)addMargin:(int)margin {
    self.left -= margin;
    self.top -= margin;
    [[self addWidth:margin * 2] addHeight:margin * 2];
    return self;
}
@end
