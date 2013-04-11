// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Profile.m instead.

#import "_Profile.h"

const struct ProfileAttributes ProfileAttributes = {
	.name = @"name",
};

const struct ProfileRelationships ProfileRelationships = {
};

const struct ProfileFetchedProperties ProfileFetchedProperties = {
};

@implementation ProfileID
@end

@implementation _Profile

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Profile" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Profile";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Profile" inManagedObjectContext:moc_];
}

- (ProfileID*)objectID {
	return (ProfileID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;











@end
