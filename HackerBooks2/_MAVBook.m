// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVBook.m instead.

#import "_MAVBook.h"

const struct MAVBookAttributes MAVBookAttributes = {
	.isFavorite = @"isFavorite",
	.title = @"title",
};

const struct MAVBookRelationships MAVBookRelationships = {
	.annotations = @"annotations",
	.authors = @"authors",
	.coverPhoto = @"coverPhoto",
	.pdf = @"pdf",
	.tags = @"tags",
};

@implementation MAVBookID
@end

@implementation _MAVBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Book";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc_];
}

- (MAVBookID*)objectID {
	return (MAVBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"isFavoriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFavorite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic isFavorite;

- (BOOL)isFavoriteValue {
	NSNumber *result = [self isFavorite];
	return [result boolValue];
}

- (void)setIsFavoriteValue:(BOOL)value_ {
	[self setIsFavorite:@(value_)];
}

- (BOOL)primitiveIsFavoriteValue {
	NSNumber *result = [self primitiveIsFavorite];
	return [result boolValue];
}

- (void)setPrimitiveIsFavoriteValue:(BOOL)value_ {
	[self setPrimitiveIsFavorite:@(value_)];
}

@dynamic title;

@dynamic annotations;

- (NSMutableSet*)annotationsSet {
	[self willAccessValueForKey:@"annotations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"annotations"];

	[self didAccessValueForKey:@"annotations"];
	return result;
}

@dynamic authors;

- (NSMutableSet*)authorsSet {
	[self willAccessValueForKey:@"authors"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"authors"];

	[self didAccessValueForKey:@"authors"];
	return result;
}

@dynamic coverPhoto;

@dynamic pdf;

@dynamic tags;

- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];

	[self didAccessValueForKey:@"tags"];
	return result;
}

@end

