//
//  Plane.h
//  RC Plane Garage
//
//  Created by Michael Smith on 1/21/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plane : NSObject
{
    NSString *planeCloudID;
    NSString *planeName;
    NSString *planeType;
    NSString *planePowerSystem;
    int planeFlightTime;
    NSString *planeCreatedAt;
    NSString *planeLastUpdate;
}
-(id)initPlaneInfo: (NSString *)parseID planeName:(NSString*)name planeType:(NSString*)type planePowerSystem:(NSString*)power planeFlightTime:(int)time planeCreatedAt:(NSString*)created planeLastUpdate:(NSString*)update;
@property(nonatomic, readonly)NSString *planeCloudID;
@property(nonatomic, readonly)NSString *planeName;
@property(nonatomic, readonly)NSString *planeType;
@property(nonatomic, readonly)NSString *planePowerSystem;
@property(nonatomic, readonly)int planeFlightTime;
@property(nonatomic, readonly)NSString *planeCreatedAt;
@property(nonatomic, readonly)NSString *planeLastUpdate;

@end
