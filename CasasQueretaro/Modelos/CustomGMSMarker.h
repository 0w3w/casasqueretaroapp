//
//  CustomGMSMarker.h
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 12/1/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "Inmueble.h"

@interface CustomGMSMarker : GMSMarker
@property (strong, nonatomic) Inmueble* inmueble;
@end
