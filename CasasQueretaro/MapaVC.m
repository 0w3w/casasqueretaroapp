//
//  MapaVC.m
//  CasasQueretaro
//
//  Created by Ana Laura Becerra Cantero on 11/18/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "MapaVC.h"
#import "Inmuebles.h"
#import "Inmueble.h"
#import "CustomGMSMarker.h"

@interface MapaVC ()<GMSMapViewDelegate>

@end

@implementation MapaVC

- (GMSMapView*) mapView{
    if(!_mapView){
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:20.592134
                                                                longitude:-100.378475
                                                                     zoom:11];
        _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        _mapView.delegate = self;
    }
    return _mapView;
}

-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(GMSMarker *)marker{
    [self performSegueWithIdentifier:@"Ver inmueble" sender:marker];
    return YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	
    //Arreglo de marcadores
    Inmuebles *inm = [[Inmuebles alloc] init];
    NSArray *arrInmuebles = [inm getInmueblesPorTipo:nil];
    for (Inmueble * i in arrInmuebles) {
        CustomGMSMarker *marker = [[CustomGMSMarker alloc] init];
        marker.inmueble = i;
        marker.position = CLLocationCoordinate2DMake([i.latitud doubleValue], [i.longitud doubleValue]);
        marker.icon = [UIImage imageNamed:@"casita.png"];
        marker.map = self.mapView;
    }
    self.view = self.mapView;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([sender isKindOfClass:[CustomGMSMarker class]]) {
        NSLog(@"Es del tipo CustomGMSMarker ");
        [segue.destinationViewController setIdInmueble:((CustomGMSMarker* ) sender).inmueble.idInmueble];
    }

}

@end
