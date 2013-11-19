//
//  MapaVC.m
//  CasasQueretaro
//
//  Created by Ana Laura Becerra Cantero on 11/18/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "MapaVC.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Inmuebles.h"
#import "Inmueble.h"

@interface MapaVC (){
    GMSMapView *mapView_;
}

@end

@implementation MapaVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:20.592134
                                                            longitude:-100.378475
                                                                 zoom:11];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    //Arreglo de marcadores
    Inmuebles *inm = [[Inmuebles alloc] init];
    NSArray *arrInmuebles = [inm getInmueblesPorTipo:nil];
    for (Inmueble * i in arrInmuebles) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([i.latitud doubleValue], [i.longitud doubleValue]);
        marker.icon = [UIImage imageNamed:@"casita.png"];
        marker.map = mapView;
    }
    
    self.view = mapView;
}


@end
