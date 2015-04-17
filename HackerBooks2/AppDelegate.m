//
//  AppDelegate.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 15/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "Settings.h"
#import "AppDelegate.h"
#import "AGTCoreDataStack.h"
#import "MAVBook.h"
#import "MAVTag.h"
#import "MAVLibraryTableViewController.h"
#import "MAVBookViewController.h"
#import "UIViewController+Navigation.h"

@interface AppDelegate ()

@property (strong, nonatomic) AGTCoreDataStack *stack;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Creamos una instancia del stack
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    BOOL isFirstBoot=NO;
    // Comprobamos si es el primer arranque
    if (![def boolForKey:FIRST_BOOT]) {
        [def setBool:YES
              forKey:FIRST_BOOT];
        [def synchronize];
        isFirstBoot = YES;
    }
    
    // Obtenemos el JSON en formato NSData, ya sea descargándolo o leyéndolo del directorio Documents.
    NSData *jsonData = [self getJSONDependingOnBoot: isFirstBoot];
    
    NSError *err;
    NSArray * JSONObjects = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:kNilOptions
                                                              error:&err];
    [self.stack zapAllData];
    
    if (JSONObjects != nil) {
        // No ha habido error
        
        for(NSDictionary *dict in JSONObjects){
            [MAVBook bookWithDictionary:dict
                                context:self.stack.context];
        }
    } else {
        NSLog(@"Error al parsear JSON: %@", err.localizedDescription);
    }
    
    // Comprobamos si existe el tag Favorites, si no existe, lo creamos,
    // sino, lo ponemos en primer lugar....
    
    
    
    
    
    
    
    //// Fetch con MAVTag
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVTag entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: MAVTagAttributes.name
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    req.fetchBatchSize = 20;
    
    // FetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.stack.context
                                      sectionNameKeyPath:MAVTagAttributes.name
                                      cacheName:nil];
    
    // Creamos el controlador
    MAVLibraryTableViewController *libTableVC = [[MAVLibraryTableViewController alloc] initWithFetchedResultsController:fc
                                                                                                                  style:UITableViewStylePlain];
    
    self.window.rootViewController = [libTableVC wrappedInNavigation];
    
    // Guardar cambios
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar! %@", error);
    }];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/*
- (void) configureForPadWithModel: (NSFetchedResultsController *) fc {
    
    // Creamos los controladores
    MAVLibraryTableViewController *libTableVC = [[MAVLibraryTableViewController alloc] initWithFetchedResultsController:fc
                                                                                                             style:UITableViewStylePlain];
    MAVBookViewController *bookVC = [[MAVBookViewController alloc] initWithModel:[self lastSelectedBookInModel: library]];
    
    
    // Combinadores
    UINavigationController *bookNav = [[UINavigationController alloc] initWithRootViewController:bookVC];
    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[[libVC wrappedInNavigation], [bookNav wrappedInNavigation]];
    
    
    // Asignamos delegados
    libTableVC.delegate = bookVC;
    splitVC.delegate = bookVC;
    
    // Lo hacemos root
    self.window.rootViewController = splitVC;
}



- (void) configureForPhoneWithModel: (AGTLibrary *) library {
    
    // Controlador
    MAVLibraryTableViewController *libTableVC = [[MAVLibraryTableViewController alloc] initWithModel:library
                                                                                               style:UITableViewStylePlain];
    // Combinador
    UINavigationController *libNav = [[UINavigationController alloc] initWithRootViewController:libTableVC];
    
    // Asignamos delegado, que será él mismo!
    libTableVC.delegate = libTableVC;
    
    // Lo hacemos root
    self.window.rootViewController = libNav;
    
}
*/

#pragma marks - Utils

-(NSData *) getJSONDependingOnBoot: (BOOL) firstBoot {
    NSData *json;
    // Averiguar la url a la carpeta de caches
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSCachesDirectory
                               inDomains:NSUserDomainMask];
    NSURL *cachesUrl = [urls lastObject];
    NSError *err;
    
    // Si es el primer arranque ...
    if (firstBoot) {
        NSLog(@"Primer arranque");
        // ... descargamos el JSON y lo guardamos en Caches de mi Sandbox
        json = [NSData dataWithContentsOfURL: [NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"]];
        
        if (json == nil) {
            NSLog(@"Error al descargar datos del JSON del servidor: %@", err.localizedDescription);
        } else {
            // Si se ha descargado correctamente, lo guardamos en la caché
            BOOL result = [json writeToURL:[cachesUrl URLByAppendingPathComponent:@"books_readable.json"]
                                   options:NSDataWritingAtomic
                                     error:&err];
            if (result == NO) {
                NSLog(@"Error al guardar el JSON a disco: %@", err.localizedDescription);
            }
        }
        // ... y si no es el primer arranque....
    } else {
        NSLog(@"NO ES Primer arranque");
        // Obtenemos el json de la caché.
        json = [fm contentsAtPath:[[cachesUrl URLByAppendingPathComponent:@"books_readable.json"] path]];
        if (json == nil) {
            NSLog(@"Error al leer: %@", err.localizedDescription);
        }
    }
    
    return json;
}





















@end
