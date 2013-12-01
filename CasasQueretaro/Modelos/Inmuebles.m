//
//  Inmuebles.m
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/17/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "Inmuebles.h"
#import "InmueblesBuilder.h"

@implementation Inmuebles
- (NSArray *) getInmueblesPorTipo:(NSString*)tipo{
    NSString *urlstr;
    NSMutableArray *inmueblesRequest;
    if(tipo){
        urlstr = [[NSString alloc] initWithFormat:@"http://casasqueretaro.com.mx/api/inmuebles/f4574e2a6205e143f32e58a186addf96/%@",tipo];
    }else{
        urlstr = [[NSString alloc] initWithFormat:@"http://casasqueretaro.com.mx/api/inmuebles/f4574e2a6205e143f32e58a186addf96/"];
    }
    NSLog(@"Url to Request 1: %@", urlstr);
    
    id jsonArray = [self getJsonData:urlstr];
    if (jsonArray) {
        id jsonresult = [jsonArray objectForKey:@"inmuebles"];
        InmueblesBuilder *ib = [[InmueblesBuilder alloc] init];
        inmueblesRequest = [ib inmueblesFromJSON:jsonresult imagePath:[jsonArray objectForKey:@"imgPath"]];
    }
    return inmueblesRequest;
}

- (Inmueble *) getInmueblePorId:(NSInteger)idInmueble{
    NSString *urlstr = [[NSString alloc] initWithFormat:@"http://casasqueretaro.com.mx/api/inmuebles/f4574e2a6205e143f32e58a186addf96/%d",idInmueble];
    
    NSMutableArray *inmueblesRequest;
    NSLog(@"Url to Request 2: %@", urlstr);
    id jsonArray = [self getJsonData:urlstr];
    NSLog(@"%@", jsonArray);
    if (jsonArray) {
        id jsonresult = [jsonArray objectForKey:@"inmuebles"];
        InmueblesBuilder *ib = [[InmueblesBuilder alloc] init];
        inmueblesRequest = [ib inmueblesFromJSON:jsonresult imagePath:[jsonArray objectForKey:@"imgPath"]];
    }
    return inmueblesRequest[0];
}

- (id) getJsonData:(NSString*)urlstr{
    if ([self connected]) {
        // Send a synchronous request
        NSURL *url = [NSURL URLWithString:urlstr];
        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
        if (error == nil){
            NSError *error = nil;
            id jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (error != nil) {
                NSLog(@"Error parsing JSON.");
            }else{
                return jsonArray;
            }
        }else{
            NSLog(@"Error Executing the Request.");
        }
        return nil;
    } else {
        NSLog(@"No hay conexión a internet");
        return nil;
    }
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

@end
