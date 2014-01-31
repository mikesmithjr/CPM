//
//  EditPlaneViewController.h
//  RC Plane Garage
//
//  Created by Michael Smith on 1/22/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface EditPlaneViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *planeName;
    IBOutlet UITextField *planeType;
    IBOutlet UITextField *planePowerType;
    IBOutlet UILabel *planeFlightTime;
    IBOutlet UIStepper *timeStepper;
    IBOutlet UILabel *createdDate;
    IBOutlet UILabel *lastUpdate;
    
    int timeInt;
    NSString *dbPath;
    sqlite3 *dbContext;
    NSMutableArray *planes;
    NSString *parseId;
}

@property(retain)NSString *parseObjectId;

-(IBAction)onSaveEditClick:(id)sender;
-(IBAction)onCancelEditClick:(id)sender;
-(IBAction)editStepperChanged:(id)sender;

@end
