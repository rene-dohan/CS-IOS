//
//  Created by Rene Dohan on 5/9/12.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (CSExtension)

//- (ObjectType)objectAtIndexedSubscript:(NSUInteger)idx;

- (ObjectType)objectAs:(ObjectType)anObject;

- (BOOL)contains:(id)anObject;

- (NSUInteger)indexOf:(id)anObject;

- (ObjectType)at:(NSInteger)index;

- (ObjectType)get:(NSInteger)index;

- (BOOL)empty;

- (BOOL)hasItems;

- (ObjectType)last;

- (ObjectType)first;

- (ObjectType)second;

- (NSInteger)lastIndex;

- (NSInteger)size;

- (BOOL)equals:(NSArray *)array;

- (BOOL)set;
@end