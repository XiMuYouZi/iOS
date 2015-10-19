
#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

/* {
   
    NSString * _itemName;
    NSString * _serialNumber;
    int _valueInDollars;
    NSDate *_dateCreate;
 
}
*/
@property BNRItem *itemName;
@property BNRItem *serialNumber;
@property int valueInDollars;
@property NSDate *dateCreate;

-(instancetype)initWithItemName:(NSString*)name   valueInDollars:(int)value   serialNumber:(NSString*)sNumber;
-(instancetype) initWithItemName:(NSString *)name ;
+(instancetype) randonItem;

/*
-(void)setItemName:(NSString *)str;
-(NSString *)itemName;

-(void)setSerialNumber:(NSString*)str;
-(NSString*)serialNumber;

-(void)setValueInDollars:(int)v;
-(int)valueInDollars;

-(NSDate *)dateCreated;
 */



@end
