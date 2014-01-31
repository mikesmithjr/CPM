//
//  MainViewController.m
//  RC Plane Garage
//
//  Created by Michael Smith on 1/21/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import "MainViewController.h"
#import "CustomCell.h"
#import "Reachability.h"
#import "Plane.h"
#import "EditPlaneViewController.h"
#import "sqlite3.h"
#import "QuartzCore/QuartzCore.h"


@interface MainViewController ()

@end

@implementation MainViewController

@synthesize planePowerArray;

/*
- (BOOL)reachable
{
    //Checking Internet Connectivity Check
    Reachability *r = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if (internetStatus == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
*/



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Plane List", @"Plane List");
        self.tabBarItem.image = [UIImage imageNamed:@"PlaneList"];
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    planePowerArray = [[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.parse.com/1/classes/Plane"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSLog(@"%@", url);
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"aV2YaiwbYmi0dK3YLeOLlRGFVsXR7T5ddFNenXEJ" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request setValue:@"CvlRPPSoEVsiXMsWtoF55blJRNkQCYgeUBktWjWo" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    NSError *error;
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil]  options:0 error:&error];
    resultsArray = [jsonDictionary objectForKey:@"results"];
    NSLog(@"%@", resultsArray);
    for (NSDictionary *dictionaryName in resultsArray) {
        NSString *name = [dictionaryName objectForKey:@"Name"];
        NSLog(@"Request: %@", name);
    }


    /*if ([self reachable])
    {
        //Alert to allow remote data loading
        alertView = [[UIAlertView alloc] initWithTitle:@"Loading Planes" message:@"Please wait while your Plans are loaded." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    }
    else
    {
        alertView = [[UIAlertView alloc] initWithTitle:@"No Network Found" message:@"Loading Local Data" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    }*/
    [self localDB];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [resultsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellView" owner:self options:nil];
    CustomCell *cell = (CustomCell *)[nib objectAtIndex:0];
    
    if (cell !=nil)
    {
        Plane *planeItem = [resultsArray objectAtIndex:indexPath.row];
        if (planeItem != nil) {
            cell.planeName.text = (NSString *)[planeItem valueForKey:@"Name"];
            cell.planeType.text = (NSString *)[planeItem valueForKey:@"Type"];
            
            
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //initializes item detail view controller to show detail view when cell is selected
    EditPlaneViewController *viewPlaneDetail = [[EditPlaneViewController alloc] initWithNibName:@"EditPlaneViewController" bundle:nil];
    if(viewPlaneDetail !=nil)
    {
        Plane *detailPlaneItem = [resultsArray objectAtIndex:indexPath.row];
        NSString *parseId = (NSString *)[detailPlaneItem valueForKey:@"objectId"];
        viewPlaneDetail.parseObjectId = parseId;
        //launches new view
        [self presentViewController:viewPlaneDetail animated:TRUE completion:nil];
    }
}
        
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)localDB
{
    if (resultsArray != nil) {
        
        
        NSArray *dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
        if(dirpaths != nil)
        {
            NSString *documentsDirectory = [dirpaths objectAtIndex:0];
            NSString *dbName = @"planes.db";
            dbPath = [documentsDirectory stringByAppendingPathComponent:dbName];
            NSLog(@"path=%@", dbPath);
            BOOL fileThere = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
            const char *databasePath = [dbPath UTF8String];
            if (fileThere) {
                NSLog(@"File There");
                if (sqlite3_open(databasePath, &dbContext) == SQLITE_OK) {
                    const char *selectStatement = "SELECT * FROM PLANE_TABLE";
                    sqlite3_stmt *compiledSelectStatement;
                    
                    if (sqlite3_prepare_v2(dbContext, selectStatement, -1, &compiledSelectStatement, NULL) == SQLITE_OK)
                    {
                        planeArray = [[NSMutableArray alloc]init];
                        //ratingsArray = [[NSMutableArray alloc]init];
                        while (sqlite3_step(compiledSelectStatement) == SQLITE_ROW)
                        {
                            NSString *planeParseID = [[NSString alloc] initWithUTF8String:(const char *)
                                                      sqlite3_column_text(compiledSelectStatement, 1)];
                            NSString *planeParseName = [[NSString alloc] initWithUTF8String:(const char *)
                                                        sqlite3_column_text(compiledSelectStatement, 2)];
                            NSString *planeParseType = [[NSString alloc] initWithUTF8String:(const char *)
                                                        sqlite3_column_text(compiledSelectStatement, 3)];
                            NSString *planeParsePower = [[NSString alloc] initWithUTF8String:(const char *)
                                                         sqlite3_column_text(compiledSelectStatement, 4)];
                            int planeParseTime = sqlite3_column_int(compiledSelectStatement, 5);
                            NSString *planeParseCreated = [[NSString alloc] initWithUTF8String:(const char *)
                                                           sqlite3_column_text(compiledSelectStatement, 6)];
                            NSString *planeParseUpdated = [[NSString alloc] initWithUTF8String:(const char *)
                                                           sqlite3_column_text(compiledSelectStatement, 7)];
                            Plane *dbPlane = [[Plane alloc] initPlaneInfo:planeParseID planeName:planeParseName planeType:planeParseType planePowerSystem:planeParsePower planeFlightTime:planeParseTime planeCreatedAt:planeParseCreated planeLastUpdate:planeParseUpdated];
                            [planeArray addObject:dbPlane];
                            //[ratingsArray addObject:movieRating];
                            
                        }
                    }
                }
                
            }else{
                NSLog(@"File NOT There");
                const char *databasePath = [dbPath UTF8String];
                if (sqlite3_open(databasePath, &dbContext) == SQLITE_OK)
                {
                    //create table
                    const char *sqlTableStatement = "CREATE TABLE IF NOT EXISTS PLANE_TABLE (PLANEID INTEGER PRIMARY KEY AUTOINCREMENT, PARSEID TEXT, NAME TEXT, TYPE TEXT, POWER_TYPE TEXT, FLIGHT_TIME INTEGER, PARSE_CREATED TEXT, PARSE_UPDATED TEXT)";
                    char *error;
                    if (sqlite3_exec(dbContext, sqlTableStatement, NULL, NULL, &error) != SQLITE_OK)
                    {
                        
                    }
                    
                    NSLog(@"%@", [resultsArray description]);
                    
                    
                    NSLog(@"planes in array %lu", (unsigned long)[resultsArray count]);
                    for (int i=0; i<[resultsArray count]; i++)
                    {
                        NSString *planeParseID = [[resultsArray objectAtIndex:i] objectForKey:@"objectId"];
                        NSString *planeParseName = [[resultsArray objectAtIndex:i] objectForKey:@"Name"];
                        NSString *planeParseType = [[resultsArray objectAtIndex:i] objectForKey:@"Type"];
                        NSString *planeParsePower = [[resultsArray objectAtIndex:i] objectForKey:@"Power_type"];
                        int planeParseFlight = [[[resultsArray objectAtIndex:i] objectForKey:@"Flight_Time"] intValue];
                        NSString *planeParseCreated = [[resultsArray objectAtIndex:i] objectForKey:@"createdAt"];
                        NSString *planeParseUpdated = [[resultsArray objectAtIndex:i] objectForKey:@"updatedAt"];
                        
                        const char *dbplaneParseID = [planeParseID UTF8String];
                        const char *dbplaneParseName = [planeParseName UTF8String];
                        const char *dbplaneParseType = [planeParseType UTF8String];
                        const char *dbplaneParsePower = [planeParsePower UTF8String];
                        int dbplaneParseFlight = planeParseFlight;
                        const char *dbplaneParseCreated = [planeParseCreated UTF8String];
                        const char *dbplaneParseUpdated = [planeParseUpdated UTF8String];
                        
                        const char *insertStatement = "INSERT INTO PLANE_TABLE (PARSEID, NAME, TYPE, POWER_TYPE, FLIGHT_TIME, PARSE_CREATED, PARSE_UPDATED) VALUES (?, ?, ?, ?, ?, ?, ?)";
                        
                        sqlite3_stmt *compiledInsertStatement;
                        
                        if (sqlite3_prepare_v2(dbContext, insertStatement, -1, &compiledInsertStatement, NULL) == SQLITE_OK)
                        {
                            sqlite3_bind_text(compiledInsertStatement, 1, dbplaneParseID, -1, NULL);
                            sqlite3_bind_text(compiledInsertStatement, 2, dbplaneParseName, -1, NULL);
                            sqlite3_bind_text(compiledInsertStatement, 3, dbplaneParseType, -1, NULL);
                            sqlite3_bind_text(compiledInsertStatement, 4, dbplaneParsePower, -1, NULL);
                            sqlite3_bind_int(compiledInsertStatement, 5, dbplaneParseFlight);
                            sqlite3_bind_text(compiledInsertStatement, 6, dbplaneParseCreated, -1, NULL);
                            sqlite3_bind_text(compiledInsertStatement, 7, dbplaneParseUpdated, -1, NULL);
                            if (sqlite3_step(compiledInsertStatement) == SQLITE_DONE)
                            {
                                sqlite3_finalize(compiledInsertStatement);
                            }
                        }
                    }
                    
                }
                
                
                //close db
                sqlite3_close(dbContext);
            }
            
        }
    }

    
}


- (IBAction)sortType:(id)sender
{
    const char *databasePath = [dbPath UTF8String];
    if (sqlite3_open(databasePath, &dbContext) == SQLITE_OK) {
        const char *selectStatement = "SELECT * FROM PLANE_TABLE ORDER BY TYPE";
        sqlite3_stmt *compiledSelectStatement;
        
        if (sqlite3_prepare_v2(dbContext, selectStatement, -1, &compiledSelectStatement, NULL) == SQLITE_OK)
        {
            planeArray = [[NSMutableArray alloc]init];
            
            while (sqlite3_step(compiledSelectStatement) == SQLITE_ROW)
            {
                NSString *planeParseID = [[NSString alloc] initWithUTF8String:(const char *)
                                          sqlite3_column_text(compiledSelectStatement, 1)];
                NSString *planeParseName = [[NSString alloc] initWithUTF8String:(const char *)
                                            sqlite3_column_text(compiledSelectStatement, 2)];
                NSString *planeParseType = [[NSString alloc] initWithUTF8String:(const char *)
                                            sqlite3_column_text(compiledSelectStatement, 3)];
                NSString *planeParsePower = [[NSString alloc] initWithUTF8String:(const char *)
                                             sqlite3_column_text(compiledSelectStatement, 4)];
                int planeParseTime = sqlite3_column_int(compiledSelectStatement, 5);
                NSString *planeParseCreated = [[NSString alloc] initWithUTF8String:(const char *)
                                               sqlite3_column_text(compiledSelectStatement, 6)];
                NSString *planeParseUpdated = [[NSString alloc] initWithUTF8String:(const char *)
                                               sqlite3_column_text(compiledSelectStatement, 7)];
                Plane *dbPlane = [[Plane alloc] initPlaneInfo:planeParseID planeName:planeParseName planeType:planeParseType planePowerSystem:planeParsePower planeFlightTime:planeParseTime planeCreatedAt:planeParseCreated planeLastUpdate:planeParseUpdated];
                [planeArray addObject:dbPlane];
                
                
            }
            NSLog(@"%@", [planeArray description]);
            [planeList reloadData];
        }
    }
    
    
}

- (IBAction)sortAlpha:(id)sender
{
    const char *databasePath = [dbPath UTF8String];
    if (sqlite3_open(databasePath, &dbContext) == SQLITE_OK) {
        const char *selectStatement = "SELECT * FROM PLANE_TABLE ORDER BY NAME";
        sqlite3_stmt *compiledSelectStatement;
        
        if (sqlite3_prepare_v2(dbContext, selectStatement, -1, &compiledSelectStatement, NULL) == SQLITE_OK)
        {
            planeArray = [[NSMutableArray alloc]init];
            
            while (sqlite3_step(compiledSelectStatement) == SQLITE_ROW)
            {
                NSString *planeParseID = [[NSString alloc] initWithUTF8String:(const char *)
                                          sqlite3_column_text(compiledSelectStatement, 1)];
                NSString *planeParseName = [[NSString alloc] initWithUTF8String:(const char *)
                                            sqlite3_column_text(compiledSelectStatement, 2)];
                NSString *planeParseType = [[NSString alloc] initWithUTF8String:(const char *)
                                            sqlite3_column_text(compiledSelectStatement, 3)];
                NSString *planeParsePower = [[NSString alloc] initWithUTF8String:(const char *)
                                             sqlite3_column_text(compiledSelectStatement, 4)];
                int planeParseTime = sqlite3_column_int(compiledSelectStatement, 5);
                NSString *planeParseCreated = [[NSString alloc] initWithUTF8String:(const char *)
                                               sqlite3_column_text(compiledSelectStatement, 6)];
                NSString *planeParseUpdated = [[NSString alloc] initWithUTF8String:(const char *)
                                               sqlite3_column_text(compiledSelectStatement, 7)];
                Plane *dbPlane = [[Plane alloc] initPlaneInfo:planeParseID planeName:planeParseName planeType:planeParseType planePowerSystem:planeParsePower planeFlightTime:planeParseTime planeCreatedAt:planeParseCreated planeLastUpdate:planeParseUpdated];
                [planeArray addObject:dbPlane];
                
                
            }
        }
    }
    [planeList reloadData];
}


@end
