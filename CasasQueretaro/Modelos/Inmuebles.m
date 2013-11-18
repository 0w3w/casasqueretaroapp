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
    NSLog(@"Url to Request: %@", urlstr);
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
            //NSLog(@"Array: %@", jsonArray);
            id jsonresult = [jsonArray objectForKey:@"inmuebles"];
            InmueblesBuilder *ib = [[InmueblesBuilder alloc] init];
            inmueblesRequest = [ib inmueblesFromJSON:jsonresult imagePath:[jsonArray objectForKey:@"imgPath"]];
            
        }
    }else{
        NSLog(@"Error Executing the Request.");
    }
    return inmueblesRequest;
}

- (Inmueble *) getInmueblePorId:(NSInteger)idInmueble{
    return nil;
}
@end
