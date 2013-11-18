//
//  InmueblesTVC.m
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/17/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "InmueblesTVC.h"
#import "InmueblesProxy.h"
#import "Inmueble.h"

@interface InmueblesTVC () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) InmueblesProxy *inmuebles;
@end

@implementation InmueblesTVC

-(InmueblesProxy *)inmuebles{
    if(!_inmuebles){
        _inmuebles = [[InmueblesProxy alloc] init];
    }
    return _inmuebles;

}

// Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.inmuebles getInmueblesPorTipo:self.tipoInmueble] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *allInmuebles = [self.inmuebles getInmueblesPorTipo:self.tipoInmueble];
    Inmueble *inmuTmp = allInmuebles[indexPath.row];
    // Configure the cell...
    cell.textLabel.text = inmuTmp.colonia;
    cell.detailTextLabel.text = inmuTmp.ciudad;
    
    NSURL *imageURl = [[NSURL alloc] initWithString:inmuTmp.imgPrincipal];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: imageURl];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    cell.imageView.image = image;

    
    return cell;
}

// Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([sender isKindOfClass:[UITableViewCell class]]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath){
            if([segue.identifier isEqualToString:@"Ver Inmueble"]){
                if([segue.destinationViewController respondsToSelector:@selector(setInmueble:)]){
                    Inmueble* InmuebleTmp = [self.inmuebles getInmueblePorId:indexPath.row];
                    [segue.destinationViewController performSelector:@selector(setInmueble:)
                                                          withObject:InmuebleTmp];
                    [segue.destinationViewController setTitle:InmuebleTmp.colonia];
                }
                
            }
            
        }
        
    }
}

@end
