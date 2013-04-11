//
//  ABAppDelegate.h
//  CoreDataInLove
//
//  Created by Abraham Barrera on 11-04-13.
//  Copyright (c) 2013 Abraham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData/CoreData.h"

@class ABViewController;

@interface ABAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ABViewController *viewController;

// our stack
@property (strong, nonatomic, readwrite)
    NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic)
    NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic)
    NSPersistentStoreCoordinator *persistentStoreCoordinator;




@end
