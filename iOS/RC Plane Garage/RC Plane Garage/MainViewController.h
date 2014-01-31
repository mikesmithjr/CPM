//
//  MainViewController.h
//  RC Plane Garage
//
//  Created by Michael Smith on 1/21/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"



@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *planeList;
    UIAlertView *alertView;
    IBOutlet UIButton *powerSystemButton;
    NSString *dbPath;
    sqlite3 *dbContext;
    NSMutableArray *planePowerArray;
    NSArray *resultsArray;
    NSMutableArray *planeArray;
    NSString *fullPath;
    
}

@property(nonatomic, strong)NSMutableArray *planePowerArray;

- (IBAction)sortType:(id)sender;


- (IBAction)sortAlpha:(id)sender;



@end
