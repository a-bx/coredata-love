//
//  Person.h
//  CoreDataInLove
//
//  Created by Abraham Barrera on 11-04-13.
//  Copyright (c) 2013 Abraham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Profile;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Profile *profile;

@end
