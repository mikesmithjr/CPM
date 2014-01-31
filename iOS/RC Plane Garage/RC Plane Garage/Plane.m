//
//  Plane.m
//  RC Plane Garage
//
//  Created by Michael Smith on 1/21/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import "Plane.h"

@implementation Plane
@synthesize planeCloudID, planeName, planeType, planePowerSystem, planeFlightTime, planeCreatedAt, planeLastUpdate;

-(id)initPlaneInfo: (NSString*)parseID planeName:(NSString*)name planeType:(NSString*)type planePowerSystem:(NSString*)power planeFlightTime:(int)time planeCreatedAt:(NSString*)created planeLastUpdate:(NSString*)update
{
    if ((self = [super init]))
    {
        planeCloudID = parseID;
        planeName = name;
        planeType = type;
        planePowerSystem = power;
        planeFlightTime = time;
        planeCreatedAt = created;
        planeLastUpdate = update;
    }
    return self;
}
@end
