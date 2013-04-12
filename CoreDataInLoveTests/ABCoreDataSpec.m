//
//  ABCoreDataSpec.m
//  CoreDataInLove
//
//  Created by Abraham Barrera on 11-04-13.
//  Copyright 2013 Abraham. All rights reserved.
//

#import "Kiwi.h"
#import "Person.h"
#import "Profile.h"
#import "ABAppDelegate.h"
#import "CoreData/CoreData.h"

SPEC_BEGIN(ABCoreDataSpec)

describe(@"Classic Core data Samples", ^{

    __block ABAppDelegate *appDelegate = (ABAppDelegate *)[[UIApplication sharedApplication] delegate];
    __block NSManagedObjectContext *moc = appDelegate.managedObjectContext;


    context(@"when I try to save or delete data", ^{

        beforeEach(^{

        });

        afterEach(^{

        });

        it(@"should be save a new record (old school)", ^{

            Profile *profile = [NSEntityDescription insertNewObjectForEntityForName:@"Profile"
                                                             inManagedObjectContext:moc];

            Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                            inManagedObjectContext:moc];
            person.name = @"Juan";
            person.lastName = @"Pablo";
            person.profile = profile;
            person.age = @10;

            NSError *error = nil;
            [moc save:&error];
            [error shouldBeNil];

        });

        it(@"should be save new record (new school)", ^{

             Person *person = [Person create:@{@"name" : @"Juancho", @"lastName" : @"Perez"}];
             [person setAge:@10];
             [person save];

             NSArray *persons = [Person where:@{@"name" : @"Juancho"}];
             [[persons shouldNot] beEmpty];

             [[[(Person*)[persons first] name] should] equal:@"Juancho"];

        });

        it(@"should be save existing record (old school)", ^{

        });

        it(@"should be save existing record (new school)", ^{
            NSManagedObjectID *otherId = [[Person create:@{@"name" : @"Juancho", @"lastName" : @"Perez"}] objectID];
            Person *p = [[Person where:[NSPredicate predicateWithFormat:@"SELF == %@", otherId]] first];
            [p setName:@"waaaa"];
            [p save];
            
            [[p.name should] equal:@"waaaa"];
        });

        it(@"should be delete existing record (old school)", ^{
            Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                           inManagedObjectContext:moc];
            person.name = @"Juanito";
            person.lastName = @"Pablo";
            person.age = @10;

            [moc deleteObject:person];

            NSFetchRequest *fetchRequest = [NSFetchRequest
                                            fetchRequestWithEntityName:@"Person"];
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", @"Juanito"]];
            id result = [[moc executeFetchRequest:fetchRequest error:NULL] lastObject];
            [result shouldBeNil];
        });

        it(@"should be delete existing record (new school)", ^{
            NSManagedObjectID *otherId = [[Person create:@{@"name" : @"Juancho", @"lastName" : @"Perez"}] objectID];
            Person *p = [[Person where:@{@"SELF" : otherId}] first];
            [p delete];
        });

    });

    context(@"when I try to get data", ^{

        beforeEach(^{
            Profile *profile = [NSEntityDescription insertNewObjectForEntityForName:@"Profile"
                                                             inManagedObjectContext:moc];

            Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                           inManagedObjectContext:moc];
            person.name = @"Juan";
            person.lastName = @"Pablo";
            person.profile = profile;
            person.age = @10;

            NSError *error = nil;
            [moc save:&error];
        });

        afterEach(^{

        });

        it(@"should be get all Data", ^{

            NSPredicate *predicateTemplate = [NSPredicate
                                              predicateWithFormat:@"name == $NAME"];

            NSFetchRequest *fetchRequest = [NSFetchRequest
                                            fetchRequestWithEntityName:@"Person"];

            [fetchRequest setPredicate:[predicateTemplate
                                        predicateWithSubstitutionVariables: [NSDictionary dictionaryWithObject:@"Juan"
                                                                                                        forKey:@"NAME"]]];

            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                             ascending:YES];
            [fetchRequest setSortDescriptors:@[sortDescriptor]];
            [fetchRequest setFetchLimit:1];

            Person *person = [[moc executeFetchRequest:fetchRequest error:NULL] lastObject];

            [person shouldNotBeNil];
            [[person.name should] equal:@"Juan"];

        });

        it(@"should be get min age", ^{
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc];
            [request setEntity:entity];


            [request setResultType:NSDictionaryResultType];

            NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"age"];

            NSExpression *minExpression = [NSExpression expressionForFunction:@"min:" arguments:[NSArray arrayWithObject:keyPathExpression]];

            NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
            [expressionDescription setName:@"minAge"];
            [expressionDescription setExpression:minExpression];
            [expressionDescription setExpressionResultType:NSDateAttributeType];

            [request setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];

            NSError *error = nil;
            NSArray *objects = [moc executeFetchRequest:request error:&error];
            if (objects && [objects count] > 0) {
                NSLog(@"Min age: %@", [[objects objectAtIndex:0] valueForKey:@"minAge"]);
            }

            [objects shouldNotBeNil];
        });


        it(@"should be get some records", ^{

        });

        it(@"should be get some records", ^{

        });

    });
});


SPEC_END




