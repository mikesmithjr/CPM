//
//  AddPlaneViewController.m
//  RC Plane Garage
//
//  Created by Michael Smith on 1/22/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import "AddPlaneViewController.h"
#import "sqlite3.h"
#import <Parse/Parse.h>

@interface AddPlaneViewController ()

@end

@implementation AddPlaneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add Plane", @"Add Plane");
        self.tabBarItem.image = [UIImage imageNamed:@"Home"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
    
    planeFlightTime.text = @"Time";
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    
    [self.view setFrame:CGRectMake(0, -20, 320, 460)];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        
    }
    return NO;
}

-(IBAction)onSaveClick:(id)sender
{
    
        
        
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
                    
                    NSString *planeParseName = planeName.text;
                    NSString *planeParseType = planeType.text;
                    NSString *planeParsePower = planePowerType.text;
                    int planeParseFlight = timeInt;
                    
                    PFObject *planeObject = [PFObject objectWithClassName:@"Plane"];
                    planeObject[@"Name"] = planeParseName;
                    planeObject[@"Type"] = planeParseType;
                    planeObject[@"Power_type"] = planeParsePower;
                    planeObject[@"Flight_Time"] = [NSNumber numberWithInt:planeParseFlight];
                    [planeObject saveInBackground];
                    
                    
                    const char *dbplaneParseName = [planeParseName UTF8String];
                    const char *dbplaneParseType = [planeParseType UTF8String];
                    const char *dbplaneParsePower = [planeParsePower UTF8String];
                    int dbplaneParseFlight = planeParseFlight;
                    
                    
                    const char *insertStatement = "INSERT INTO PLANE_TABLE (NAME, TYPE, POWER_TYPE, FLIGHT_TIME) VALUES (?, ?, ?, ?)";
                    
                    sqlite3_stmt *compiledInsertStatement;
                    
                    if (sqlite3_prepare_v2(dbContext, insertStatement, -1, &compiledInsertStatement, NULL) == SQLITE_OK)
                    {
                        
                        sqlite3_bind_text(compiledInsertStatement, 1, dbplaneParseName, -1, NULL);
                        sqlite3_bind_text(compiledInsertStatement, 2, dbplaneParseType, -1, NULL);
                        sqlite3_bind_text(compiledInsertStatement, 3, dbplaneParsePower, -1, NULL);
                        sqlite3_bind_int(compiledInsertStatement, 4, dbplaneParseFlight);
                        
                        if (sqlite3_step(compiledInsertStatement) == SQLITE_DONE)
                        {
                            sqlite3_finalize(compiledInsertStatement);
                            planeName.text = nil;
                            planeType.text = nil;
                            planePowerType.text = nil;
                            planeFlightTime.text = @"Time";
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
                    
                    
                    NSString *planeParseName = planeName.text;
                    NSString *planeParseType = planeType.text;
                    NSString *planeParsePower = planePowerType.text;
                    int planeParseFlight = timeInt;
                    
                    PFObject *planeObject = [PFObject objectWithClassName:@"Plane"];
                    planeObject[@"Name"] = planeParseName;
                    planeObject[@"Type"] = planeParseType;
                    planeObject[@"Power_type"] = planeParsePower;
                    planeObject[@"Flight_Time"] = [NSNumber numberWithInt:planeParseFlight];
                    [planeObject saveInBackground];
                    
                    
                    const char *dbplaneParseName = [planeParseName UTF8String];
                    const char *dbplaneParseType = [planeParseType UTF8String];
                    const char *dbplaneParsePower = [planeParsePower UTF8String];
                    int dbplaneParseFlight = planeParseFlight;
                    
                    const char *insertStatement = "INSERT INTO PLANE_TABLE (NAME, TYPE, POWER_TYPE, FLIGHT_TIME) VALUES (?, ?, ?, ?)";
                    
                    sqlite3_stmt *compiledInsertStatement;
                    
                    if (sqlite3_prepare_v2(dbContext, insertStatement, -1, &compiledInsertStatement, NULL) == SQLITE_OK)
                    {
                        
                        sqlite3_bind_text(compiledInsertStatement, 1, dbplaneParseName, -1, NULL);
                        sqlite3_bind_text(compiledInsertStatement, 2, dbplaneParseType, -1, NULL);
                        sqlite3_bind_text(compiledInsertStatement, 3, dbplaneParsePower, -1, NULL);
                        sqlite3_bind_int(compiledInsertStatement, 4, dbplaneParseFlight);
                        
                        if (sqlite3_step(compiledInsertStatement) == SQLITE_DONE)
                        {
                            sqlite3_finalize(compiledInsertStatement);
                            planeName.text = nil;
                            planeType.text = nil;
                            planePowerType.text = nil;
                            planeFlightTime.text = @"Time";
                        }
                    }
                    }
                    
                
                
                
                //close db
                sqlite3_close(dbContext);
            }
            
        }
    

    
}
-(IBAction)onCancelClick:(id)sender
{
    planeName.text = nil;
    planeType.text = nil;
    planePowerType.text = nil;
    planeFlightTime.text = @"Time";
    
    
}

- (IBAction)stepperChanged:(UIStepper *)sender
{
    timeInt = (int)sender.value;
    NSString *time = [NSString stringWithFormat:@"%i", timeInt];
    
    planeFlightTime.text = time;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
