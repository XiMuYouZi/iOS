
#import <Foundation/Foundation.h>

@interface BNRItem : NSObject<NSCoding>

@property NSString *itemName;
@property NSString *serialNumber;
@property int valueInDollars;
@property NSDate *dateCreate;
@property (nonatomic,copy)NSString *itemKey;

-(instancetype)initWithItemName:(NSString*)name   valueInDollars:(int)value   serialNumber:(NSString*)sNumber;
-(instancetype) initWithItemName:(NSString *)name ;
+(instancetype) randonItem;



@end
