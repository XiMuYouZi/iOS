

#import <Foundation/Foundation.h>
#import "BNRItem.h"
@class BNRItem;

@interface ItemStore : NSObject
@property (nonatomic ,readonly)NSArray *allItems;
+(instancetype)shareStore;
-(BNRItem *)createItem;
-(void)removeItem:(BNRItem*)item;
- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;
-(BOOL)saveChanges;

@end




