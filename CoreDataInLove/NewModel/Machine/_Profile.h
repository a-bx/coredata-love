// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Profile.h instead.

#import <CoreData/CoreData.h>


extern const struct ProfileAttributes {
	__unsafe_unretained NSString *name;
} ProfileAttributes;

extern const struct ProfileRelationships {
} ProfileRelationships;

extern const struct ProfileFetchedProperties {
} ProfileFetchedProperties;




@interface ProfileID : NSManagedObjectID {}
@end

@interface _Profile : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProfileID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;






@end

@interface _Profile (CoreDataGeneratedAccessors)

@end

@interface _Profile (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
