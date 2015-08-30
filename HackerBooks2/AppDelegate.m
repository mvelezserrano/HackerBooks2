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
#import "MAVAuthor.h"
#import "MAVAnnotation.h"
#import "MAVTag.h"
#import "MAVBookTag.h"
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
    
    if (isFirstBoot) {
        // Creamos la BBDD
        if (JSONObjects != nil) {
            // No ha habido error
            
            for(NSDictionary *dict in JSONObjects){
                [MAVBook bookWithDictionary:dict
                                    context:self.stack.context];
            }
        } else {
            NSLog(@"Error al parsear JSON: %@", err.localizedDescription);
        }
    }
    
    
    // Fetch con MAVTag
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVBookTag entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:MAVBookTagAttributes.name
                                                          ascending:YES
                                                           selector:@selector(compare:)]];
    
    // FetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.stack.context
                                      sectionNameKeyPath:MAVBookTagAttributes.name
                                      cacheName:nil];
    
    // Guardar cambios
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar! %@", error);
    }];
    
    // Valor por defecto para el último libro seleccionado
    if (![def objectForKey:LAST_SELECTED_BOOK]) {
        
        // guardamos un valor por defecto
        [def setObject:[self firstBookURIRepresentation]
                forKey:LAST_SELECTED_BOOK];
        [def synchronize];
    }
    
    // Detectamos el tipo de pantalla
    if (!IS_IPHONE) {
        // Tipo tableta
        [self configureForPadWithModel: fc];
    } else {
        // Tipo teléfono
        [self configureForPhoneWithModel: fc];
    }
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar: %@", error);
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar: %@", error);
    }];
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


- (void) configureForPadWithModel: (NSFetchedResultsController *) fc {
    
    // Controladores
    MAVLibraryTableViewController *libTableVC = [[MAVLibraryTableViewController alloc] initWithFetchedResultsController:fc
                                                                                                                  style:UITableViewStylePlain];
    MAVBookViewController *bookVC = [[MAVBookViewController alloc] initWithModel:[self lastSelectedBookInModel: fc]];
    
    
    // Combinador
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[[libTableVC wrappedInNavigation], [bookVC wrappedInNavigation]];
    
    
    // Asignamos delegados
    libTableVC.delegate = bookVC;
    splitVC.delegate = bookVC;
    
    // Lo hacemos root
    self.window.rootViewController = splitVC;
}



- (void) configureForPhoneWithModel: (NSFetchedResultsController *) fc {
    
    // Controlador
    MAVLibraryTableViewController *libTableVC = [[MAVLibraryTableViewController alloc] initWithFetchedResultsController:fc
                                                                                                                  style:UITableViewStylePlain];
    // Asignamos delegado, que será él mismo!
    libTableVC.delegate = libTableVC;
    
    // Lo hacemos root
    self.window.rootViewController = [libTableVC wrappedInNavigation];
    
}


-(MAVBook *) lastSelectedBookInModel: (NSFetchedResultsController *) fc{
    
    // Obtengo el NSUserDefaults
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    // Saco el NSData del uri del último libro seleccionado
    NSData *uriData = [def objectForKey:LAST_SELECTED_BOOK];
    
    // Obtengo el libro
    MAVBook *book = [self objectWithArchivedURIRepresentation:uriData
                                                      context:self.stack.context];
    // Lo devuelvo
    return book;
    
}


// Tries to recover the object from the archived URI representation (that probably
// comes from some NSUserDefaults). If the object doesn't exist anymore, returns
// nil.
- (MAVBook *) objectWithArchivedURIRepresentation:(NSData*)archivedURI
                                            context:(NSManagedObjectContext *) context{
    
    NSURL *uri = [NSKeyedUnarchiver unarchiveObjectWithData:archivedURI];
    if (uri == nil) {
        return nil;
    }
    
    
    NSManagedObjectID *nid = [context.persistentStoreCoordinator
                              managedObjectIDForURIRepresentation:uri];
    if (nid == nil) {
        return nil;
    }
    
    
    NSManagedObject *ob = [context objectWithID:nid];
    if (ob.isFault) {
        // Got it!
        return (MAVBook *) ob;
    }else{
        // Might not exist anymore. Let's fetch it!
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:ob.entity.name];
        req.predicate = [NSPredicate predicateWithFormat:@"SELF = %@", ob];
        
        NSError *error;
        NSArray *res = [context executeFetchRequest:req
                                              error:&error];
        if (res == nil) {
            return nil;
        }else{
            return [res lastObject];
        }
    }
    
    
}

- (NSData *) firstBookURIRepresentation {
    
    // Un fetchRequest
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVTag entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: MAVTagAttributes.name
                                                          ascending:YES
                                                           selector:@selector(compare:)]];
    req.fetchBatchSize = 20;
    // Obtenemos todos los libros
    NSArray *results = [self.stack executeFetchRequest:req
                                            errorBlock:^(NSError *error) {
                                                NSLog(@"Error al buscar! %@", error);
                                            }];
    
    MAVTag *firstTag = [results objectAtIndex:0];
    MAVBookTag *bookTag = [[firstTag.bookTags allObjects] objectAtIndex:0];
    MAVBook *firstBook = [bookTag book];
    NSURL *uri = firstBook.objectID.URIRepresentation;
    
    NSLog(@"First Book title: %@", firstBook.title);
    
    return [NSKeyedArchiver archivedDataWithRootObject:uri];
}








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
