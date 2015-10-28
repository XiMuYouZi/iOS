

#import <Foundation/Foundation.h>
#import "BNRItem.h"

@class BNRItem;

@interface ItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

// Notice that this is a class method and prefixed with a + instead of a -
+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;

- (BOOL)saveChanges;

- (NSArray *)allAssetTypes;

@end


