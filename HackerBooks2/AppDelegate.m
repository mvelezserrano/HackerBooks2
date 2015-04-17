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
    
    // Creamos los datos del modelo.
    [self createLibraryData];
    
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

- (void) createLibraryData {
    
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
    //NSData *jsonData = [self getJSONDependingOnBoot: isFirstBoot];
    NSData *jsonData = [self getJSONDependingOnBoot: YES];
    
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
    
    
    
    
    //// Fetch con MAVBook
    /*// Un fetchRequest
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVBook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: MAVBookAttributes.title
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    
    // FetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.stack.context
                                      // Habrá que utilizarlo para crear las secciones de los libros con los tags.
                                      sectionNameKeyPath:nil
                                      cacheName:nil];
    */
    
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
    
    
    /* /// Debug tags + libros
    // Array de tags... veamos qué libros tiene cada uno!!
    NSArray *results = [self.stack executeFetchRequest:req
                                            errorBlock:^(NSError *error) {
                                                NSLog(@"Error al buscar! %@", error);
                                            }];
    int tagsCount = 0;
    for (MAVTag *tag in results) {
        tagsCount++;
        NSLog(@"Título del tag: %@", tag.name);
        NSArray *booksSet = [[tag books] allObjects];
        for (MAVBook *book in booksSet) {
            NSLog(@"    Libro: %@", book.title);
        }
    }
    
    NSLog(@"Total de tags: %d", tagsCount);
    
    
    
    // Array de libros... veamos qué arrays tiene cada uno!!
    req = [NSFetchRequest fetchRequestWithEntityName:[MAVBook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: MAVBookAttributes.title
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    results = [self.stack executeFetchRequest:req
                                   errorBlock:^(NSError *error) {
                                       NSLog(@"Error al buscar! %@", error);
                                   }];
    
    int booksCount = 0;
    for (MAVBook *book in results) {
        booksCount++;
        NSLog(@"Título del Libro: %@", book.title);
        NSArray *tagsSet = [[book tags] allObjects];
        for (MAVTag *tag in tagsSet) {
            NSLog(@"    Tag: %@", tag.name);
        }
    }
    
    NSLog(@"Total de Libros: %d", booksCount);
    */
    
    
    // Creamos el controlador
    MAVLibraryTableViewController *libVC = [[MAVLibraryTableViewController alloc] initWithFetchedResultsController:fc
                                                                                                     style:UITableViewStylePlain];
    
    //UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:libVC];
    
    self.window.rootViewController = [libVC wrappedInNavigation];
    
    // Guardar cambios
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar! %@", error);
    }];
    
}


#pragma marks - Utils

-(NSData *) getJSONDependingOnBoot: (BOOL) firstBoot {
    NSData *json;
    // Averiguar la url a la carpeta de caches
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSCachesDirectory
                               inDomains:NSUserDomainMask];
    NSURL *cachesUrl = [urls lastObject];
    
    // Añadir el componente del nombre del fichero
    NSError *err = nil;
    
    // Si es el primer arranque ...
    if (firstBoot) {
        // ... descargamos el JSON y lo guardamos en Documents de mi Sandbox
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"]];
        NSURLResponse *response = [[NSURLResponse alloc] init];
        json = [NSURLConnection sendSynchronousRequest:request
                                     returningResponse:&response
                                                 error:&err];
        
        if (json == nil) {
            NSLog(@"Error al descargar datos del servidor: %@", err.localizedDescription);
        }
        
        // ... y si no es el primer arranque....
    } else {
        // Obtenemos el json del disco duro.
        json = [fm contentsAtPath:[[cachesUrl URLByAppendingPathComponent:@"books_readable.json"] path]];
        if (json == nil) {
            NSLog(@"Error al leer: %@", err.localizedDescription);
        }
    }
    
    return json;
}
























@end
