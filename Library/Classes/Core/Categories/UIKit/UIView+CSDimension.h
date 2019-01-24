//
// Created by Rene Dohan on 17/07/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSDimension)

- (instancetype)size:(CGSize)size;

- (instancetype)setSize:(CGSize)size;

- (instancetype)width:(CGFloat)width height:(CGFloat)height;

- (void)setWidth:(CGFloat)width;

- (instancetype)width:(CGFloat)value;

- (instancetype)widthAsHeight;

- (void)setHeight:(CGFloat)height;

- (instancetype)height:(CGFloat)height;

- (instancetype)heightAsWidth;

- (instancetype)addWidth:(CGFloat)value;

- (instancetype)addHeight:(CGFloat)value;

- (instancetype)sizeFit;

- (instancetype)sizeFitHeight;

- (instancetype)fitSubviews;

- (instancetype)contentMarging:(CGFloat)padding;

- (instancetype)contentMargingVertical:(CGFloat)padding;

- (instancetype)contentMargingHorizontal:(CGFloat)padding;

- (instancetype)padding:(CGFloat)padding;

- (instancetype)addLeft:(NSInteger)value;

- (instancetype)addTop:(NSInteger)value;

- (instancetype)addRight:(NSInteger)value;

- (instancetype)addBottom:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END
