//
//  CustomCell.m
//  RC Plane Garage
//
//  Created by Michael Smith on 1/21/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize planeName, planeType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
