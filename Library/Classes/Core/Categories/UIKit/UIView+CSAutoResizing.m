//
// Created by Rene Dohan on 17/07/18.
//

#import "UIView+CSAutoResizing.h"
#import "CSCocoaLumberjack.h"

@implementation UIView (CSAutoResizing)

- (instancetype)flexibleWidthHeight {
    self.flexibleWidth.flexibleHeight;
    return self;
}

- (instancetype)flexibleWidth {
    self.autoresizingMask |= UIViewAutoresizingFlexibleWidth;
    return self;
}

- (instancetype)fixedWidth {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleWidth;
    return self;
}

- (instancetype)flexibleHeight {
    self.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
    return self;
}

- (instancetype)fixedHeight {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleHeight;
    return self;
}

- (instancetype)flexibleLeft {
    self.autoresizingMask |= UIViewAutoresizingFlexibleLeftMargin;
    return self;
}

- (instancetype)flexibleTop {
    self.autoresizingMask |= UIViewAutoresizingFlexibleTopMargin;
    return self;
}

- (instancetype)flexibleRight {
    self.autoresizingMask |= UIViewAutoresizingFlexibleRightMargin;
    return self;
}

- (instancetype)flexibleBottom {
    self.autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
    return self;
}

- (instancetype)flexibleLeftTop {
    return self.flexibleLeft.flexibleTop;
}

- (instancetype)fixedLeft {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleLeftMargin;
    return self;
}

- (instancetype)fixedTop {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleTopMargin;
    return self;
}

- (instancetype)fixedRight {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleRightMargin;
    return self;
}

- (instancetype)fixedBottom {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleBottomMargin;
    return self;
}

- (BOOL)isFixedLeft {
    return (self.autoresizingMask & UIViewAutoresizingFlexibleLeftMargin) != 0;
}

- (BOOL)isFixedTop {
    return (self.autoresizingMask & UIViewAutoresizingFlexibleTopMargin) != 0;
}

- (BOOL)isFixedRight {
    return (self.autoresizingMask & UIViewAutoresizingFlexibleRightMargin) != 0;
}

- (BOOL)isFixedBottom {
    return (self.autoresizingMask & UIViewAutoresizingFlexibleBottomMargin) != 0;
}

@end