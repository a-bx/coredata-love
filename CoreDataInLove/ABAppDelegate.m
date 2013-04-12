//
//  ABAppDelegate.m
//  CoreDataInLove
//
//  Created by Abraham Barrera on 11-04-13.
//  Copyright (c) 2013 Abraham. All rights reserved.
//

#import "ABAppDelegate.h"
#import "ABViewController.h"

@implementation ABAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ABViewController alloc] initWithNibName:@"ABViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ABViewController alloc] initWithNibName:@"ABViewController_iPad" bundle:nil];
    }
    
    [self chooseDatabase];
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

//new school
- (void)chooseDatabase {
    
    [[CoreDataManager instance] setModelName:@"CoreDataInLove"];
    if ([[[NSProcessInfo processInfo] environment] objectForKey:@"TEST"]) {
        [[CoreDataManager instance] setDatabaseName:@"CoreDataInLove-test"];
    } else {
        [[CoreDataManager instance] setDatabaseName:@"CoreDataInLove"];
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // new school
    [[CoreDataManager instance] saveContext];

    // old school
    //NSError *error = nil;
    //[self.managedObjectContext save:&error];
}



//old school
- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CoreDataInLove" ofType:@"mom"];
        
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:@"CoreDataInLove" ofType:@"momd"];
        }
        
        NSURL *url = [NSURL fileURLWithPath:path];
        
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    }
    
    return _managedObjectModel;
}



- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                          lastObject];
        path = [path stringByAppendingPathComponent:@"CoreDataInLove"];
        
        NSURL *url = [NSURL fileURLWithPath:path];
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                       initWithManagedObjectModel:self.managedObjectModel];
        
        NSError *error = nil;
        //NSBinaryStoreType, NSInMemoryStoreType
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType  
                                                  configuration:nil
                                                            URL:url
                                                        options:nil
                                                          error:&error];
        
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc]
                                 initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    
    return _managedObjectContext;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
 

@end
