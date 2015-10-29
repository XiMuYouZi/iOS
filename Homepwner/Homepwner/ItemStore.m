/*
#import "ItemStore.h"
#import "ImageStore.h"
@import CoreData;


//把变量privateitems放在类扩展中声明是为了保证该变量只能被这个类使用
@interface ItemStore()
@property (nonatomic)NSMutableArray *privateItems;
@property(nonatomic,strong)NSMutableArray *allAssetTypes;
@property(nonatomic,strong)NSManagedObjectContext *context;
@property(nonatomic,strong)NSManagedObjectModel *model;
@end


@implementation ItemStore

//获取应用沙盒的Documents目录的全路径
-(NSString *)itemArchivePath
{
    NSArray *documentDirectories=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                     NSUserDomainMask,YES );
    
    NSString *documentDirectory=[documentDirectories firstObject];
//    return [documentDirectory stringByAppendingString:@"item.archive"];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}


//把privateItems中所有的BNRItem对象都保存到core data中,保存成功就返回yes
-(BOOL)saveChanges
{
//    NSString * path=[self itemArchivePath];
//    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
    
//    之前ItemStore每次存储都会固化整个BNRItem数组，现在可以让ItemStore向NSManagedObjectContext对象发送save：消息，后者每次都只进行增量更新
    NSError * error;
    
//save:用法：Always verify that the context has uncommitted changes (using the hasChanges property) before invoking the save: method. Otherwise, Core Data may perform unnecessary work.
    BOOL successful=[self.context save:&error];
    if (!successful) {
        NSLog(@"error saving: %@",[error localizedDescription]);
        
    }
    return successful;
}



//从core data取回所有的BNRItem对象，按照orderingvaule升序排序，然后存入privateItems
-(void)loadAllItems
{
    if (!self.privateItems) {
        NSFetchRequest *request=[[NSFetchRequest alloc]init];
//        设置请求的实体是core data中存储的BNRItem,NSManagedObjectContext为context属性
        NSEntityDescription *e=[NSEntityDescription entityForName:@"BNRItem" inManagedObjectContext:self.context];
        request.entity=e;
        
//        按照orderingvaule升序排序
        NSSortDescriptor *sd=[NSSortDescriptor sortDescriptorWithKey:@"orderingVaule" ascending:YES];
        request.sortDescriptors=@[sd];
        
        
        NSError *error;
        
//        取回所有的BNRItem对象
        NSArray *result=[self.context executeFetchRequest:request error:&error];
        
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reson:%@",[error localizedDescription]];
        }
        
        
        self.privateItems=[[NSMutableArray alloc]initWithArray:result];
        
    }
}


实现itemstore里面的item位置互换功能(P445的代码写入是报错)
- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so you can re-insert it
    BNRItem *item = self.privateItems[fromIndex];
    
    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
    
}




//从Itermstore和ImageStore中删除相应的对象
-(void)removeItem:(BNRItem *)item
{
    //如果用户删除了BNRitem对象，那么也需要删除imagestore中对应的UIImage对象
    NSString *key=item.itemKey;
    [[ImageStore shareStore]deleteImageForKey:key];
    
//    删除ItemStore中的对象
    [self.privateItems removeObjectIdenticalTo:item];
//    从core data中也要删除对应的数据
    [self.context deleteObject:item];
}



//sharestore的初始值是nil，程序第一次运行会创建一个itemstore对象，并将对象的内存地址赋予sharestore
//当程序再次执行无论多少次，sharestore会一直指向最初的itemstore对象的地址，并且不断在原来的基础上存储新的值
+(instancetype)shareStore
{
    
    static ItemStore *shareStore =nil;
    if (!shareStore) {
        shareStore=[[self alloc]initPrivate];
    }
    return shareStore;
}


//如果调用系统的init方法，就抛出异常
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"use+[ItemStore shareStore" userInfo:nil];
    return nil;
}


//必须使用自定义的init方法
-(instancetype)initPrivate
{
    self=[super init];
    if (self) {
////        从指定路径中读取保存的BNRItem
//        NSString *path=[self itemArchivePath];
//        _privateItems=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        
////        如果没有保存过BNRItem,那就就初始化一个privateItems
//        if (!_privateItems) {
//            _privateItems=[[NSMutableArray alloc]init];
        
//        读取homepwner.xcdatamodel
        _model=[NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
        
//        设置SQLite的路径
        NSString *path=[self itemArchivePath];
        NSURL *storeURL=[NSURL fileURLWithPath:path];
        
        NSError *error=nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            @throw [NSException exceptionWithName:@"open filure" reason:[error localizedDescription] userInfo:nil];
        }
        
//        创建NSManagedObjectModelContext对象
//        先创建NSManagedObjectModel 对象，然后它来初始化NSPersistentStoreCoordinator对象，然后再用后者创建NSManagedObjectContext对象
        _context=[[NSManagedObjectContext alloc]init];
        _context.persistentStoreCoordinator=psc;
        
//        读取所有的BNRItem
        [self loadAllItems];
        
        }

    return self;
}

//覆盖allitem变量的取方法
-(NSArray *)allItems
{
    return self.privateItems;
}

//创建BNRItem对象，此时不能使用alloc来创建，需要使用NSManagedObjectContext对象插于一个针对BNRItem实体的新对象，并得到BNRItem对象
-(BNRItem *)createItem
{
//创建BNRItem对象的时候顺便加上orderingvaule
    double order;
    if ([self.allItems count]==0) {
        order=1.0;
    }else{
        order=[[self.privateItems lastObject]orderingValue]+1.0;
    }
    
    BNRItem *item=[NSEntityDescription insertNewObjectForEntityForName:@"BNRItem" inManagedObjectContext:self.context];
    item.orderingValue=order;
    [self.privateItems addObject:item];
    return item;
    
}

@end
*/








#import "ItemStore.h"
#import "BNRItem.h"
#import "ImageStore.h"
#import "AppDelegate.h"
@import CoreData;

@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic, strong) NSMutableArray *allAssetTypes;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

@end

@implementation ItemStore

+ (instancetype)sharedStore
{
    static ItemStore *sharedStore;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// If a programmer calls [[ItemStore alloc] init], let him
// know the error of his ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[ItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        // Read in Homepwner.xcdatamodeld
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        // Where does the SQLite file go?
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure"
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
        
        // Create the managed object context
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllItems];
    }
    return self;
}

- (NSString *)itemArchivePath
{
    // Make sure that the first argument is NSDocumentDirectory
    // and not NSDocumentationDirectory
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get the one document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

- (void)loadAllItems
{
    if (!self.privateItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"BNRItem"
                                             inManagedObjectContext:self.context];
        
        request.entity = e;
        
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        
        request.sortDescriptors = @[sd];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        self.privateItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (NSArray *)allItems
{
    return [self.privateItems copy];
}

- (BNRItem *)createItem
{
    double order;
    if ([self.allItems count] == 0) {
        order = 1.0;
    } else {
        order = [[self.privateItems lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %lu items, order = %.2f", (unsigned long)[self.privateItems count], order);
    
    BNRItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"BNRItem"
                                                  inManagedObjectContext:self.context];
    
    item.orderingValue = order;
    
    
    
//    创建新BNRItem的时候设置默认值
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    item.valueInDollars=[defaults integerForKey:NextItemValuePrefsKey];
    item.itemName=[defaults objectForKey:NextItemNamePrefsKey];
    NSLog(@"defaults=%@",[defaults dictionaryRepresentation]);
    
    
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    if (key) {
        [[ImageStore shareStore] deleteImageForKey:key];
    }
    
    [self.context deleteObject:item];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so you can re-insert it
    BNRItem *item = self.privateItems[fromIndex];
    
    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
    
    // Computing a new orderValue for the object that was moved
    double lowerBound = 0.0;
    
    // Is there an object before it in the array?
    if (toIndex > 0) {
        lowerBound = [self.privateItems[(toIndex - 1)] orderingValue];
    } else {
        lowerBound = [self.privateItems[1] orderingValue] - 2.0;
    }
    
    double upperBound = 0.0;
    
    // Is there an object after it in the array?
    if (toIndex < [self.privateItems count] - 1) {
        upperBound = [self.privateItems[(toIndex + 1)] orderingValue];
    } else {
        upperBound = [self.privateItems[(toIndex - 1)] orderingValue] + 2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    NSLog(@"moving to order %f", newOrderValue);
    item.orderingValue = newOrderValue;
}

- (NSArray *)allAssetTypes
{
    if (!_allAssetTypes) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"BNRAssetType"
                                             inManagedObjectContext:self.context];
        request.entity = e;
        
        NSError *error = nil;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        _allAssetTypes = [result mutableCopy];
    }
    
    // Is this the first time the program is being run?
    if ([_allAssetTypes count] == 0) {
        NSManagedObject *type;
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                             inManagedObjectContext:self.context];
        [type setValue:@"Furniture" forKey:@"label"];
        [_allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                             inManagedObjectContext:self.context];
        [type setValue:@"Jewelry" forKey:@"label"];
        [_allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                             inManagedObjectContext:self.context];
        [type setValue:@"Electronics" forKey:@"label"];
        [_allAssetTypes addObject:type];
        
    }
    return _allAssetTypes;
}

@end
