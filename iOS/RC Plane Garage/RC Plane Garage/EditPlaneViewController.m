//
//  EditPlaneViewController.m
//  RC Plane Garage
//
//  Created by Michael Smith on 1/22/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import "EditPlaneViewController.h"
#import <sqlite3.h>
#import <Parse/Parse.h>

@interface EditPlaneViewController ()

@end

@implementation EditPlaneViewController

@synthesize parseObjectId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    parseId = self.parseObjectId;
    NSLog(@"%@", parseId);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Plane"];
    [query whereKey:@"objectId" equalTo:parseId];
    NSLog(@"Starting Query");
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"No Error");
            // The find succeeded.
            planes = [[NSMutableArray alloc]init];
            //NSLog(@"Successfully retrieved %d planes.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                planeName.text = object[@"Name"];
                planeType.text = object[@"Type"];
                planePowerType.text = object[@"Power_type"];
                int time = [[object objectForKey:@"Flight_Time"]intValue];
                planeFlightTime.text = [NSString stringWithFormat:@"%i", time];
                NSDate *update = object.updatedAt;
                NSDate *created = object.createdAt;
                NSDateFormatter *outputDateFormat = [[NSDateFormatter alloc] init];
                [outputDateFormat setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
                lastUpdate.text = [NSString stringWithFormat:@"%@", [outputDateFormat stringFromDate:update]];
                createdDate.text = [NSString stringWithFormat:@"%@", [outputDateFormat stringFromDate:created]];
                
                
                
                
            }
            
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    
    
    
    
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


-(IBAction)onSaveEditClick:(id)sender
{
    PFQuery *planeQuery = [PFQuery queryWithClassName:@"Plane"];
    [planeQuery getObjectInBackgroundWithId:parseId block:^(PFObject *planeObject, NSError *error){
    
    planeObject[@"Name"] = planeName.text;
    planeObject[@"Type"] = planeType.text;
    planeObject[@"Power_type"] = planePowerType.text;
    planeObject[@"Flight_Time"] = [NSNumber numberWithInt:timeInt];
    [planeObject saveInBackground];
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}
-(IBAction)onCancelEditClick:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)editStepperChanged:(UIStepper *)sender
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
