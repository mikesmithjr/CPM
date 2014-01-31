//
//  CustomCell.h
//  RC Plane Garage
//
//  Created by Michael Smith on 1/21/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    IBOutlet UILabel *planeName;
    IBOutlet UILabel *planeType;
}

@property (nonatomic, strong)UILabel *planeName;
@property (nonatomic, strong)UILabel *planeType;

@end
