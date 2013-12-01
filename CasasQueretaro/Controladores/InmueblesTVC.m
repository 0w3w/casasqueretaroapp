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
@property (strong, nonatomic) NSCache *imageCache;
@end

@implementation InmueblesTVC

-(InmueblesProxy *)inmuebles{
    if(!_inmuebles){
        _inmuebles = [[InmueblesProxy alloc] init];
    }
    return _inmuebles;
}

- (NSCache *)imageCache{
    if(!_imageCache){
        _imageCache = [[NSCache alloc] init];
        _imageCache.name = @"Custom Image Cache";
        _imageCache.countLimit = 50;
    }
    return _imageCache;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void) viewDidLoad {
    [super viewDidLoad]; 
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(updateTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void) updateTable {
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

// Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.inmuebles getInmueblesPorTipo:self.tipoInmueble]) {
        NSArray *allInmuebles = [self.inmuebles getInmueblesPorTipo:self.tipoInmueble];
         NSLog(@"Cuantos?: %d",[allInmuebles count]);
        return [[self.inmuebles getInmueblesPorTipo:self.tipoInmueble] count];
    } else {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Sin conexión a internet"
                                                          message:@"Revisa que tu wi-fi esté encendido."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *allInmuebles = [self.inmuebles getInmueblesPorTipo:self.tipoInmueble];
    Inmueble *inmuTmp = allInmuebles[indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = inmuTmp.colonia;
    if([self.tipoInmueble isEqualToString:@"otros"]){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ - %@", [inmuTmp getFormatedPrecio], inmuTmp.moneda, inmuTmp.tipo];
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ - %@", [inmuTmp getFormatedPrecio], inmuTmp.moneda, inmuTmp.ciudad];
    }
    
    UIImage *image = [self.imageCache objectForKey:inmuTmp.imgPrincipal];
    if (image){
        // if we have an cachedImage sitting in memory already, then use it
        cell.imageView.image = image;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"noImage300x225.png"];
        // the get the image in the background
        dispatch_queue_t imageFetcherQ = dispatch_queue_create("image fetcher", NULL);
        dispatch_async(imageFetcherQ, ^{
            //[NSThread sleepForTimeInterval:2.0];
            // get the UIImage
            NSString * imgFullPath = [[NSString alloc] initWithFormat:@"%@%@",inmuTmp.imgPath,inmuTmp.imgPrincipal];
            NSURL *imageURl = [[NSURL alloc] initWithString:imgFullPath];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            NSData *imageData = [[NSData alloc] initWithContentsOfURL: imageURl];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIImage *imagen = [[UIImage alloc] initWithData:imageData];
            // if we found it, then update UI
            if (imagen){
                dispatch_async(dispatch_get_main_queue(), ^{
                    // if the cell is visible, then set the image
                    UITableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:indexPath];
                    if (cell2){
                        cell2.imageView.image = imagen;
                    }
                });
                [self.imageCache setObject:imagen forKey:inmuTmp.imgPrincipal];
            }
        });
    }
    return cell;
}

// Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([sender isKindOfClass:[UITableViewCell class]]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath){
            if([segue.identifier isEqualToString:@"Ver Inmueble"]){
                if([segue.destinationViewController respondsToSelector:@selector(setIdInmueble:)]){
                    NSArray *allInmuebles = [self.inmuebles getInmueblesPorTipo:self.tipoInmueble];
                    Inmueble *inmuTmp = allInmuebles[indexPath.row];
                    [segue.destinationViewController setIdInmueble:inmuTmp.idInmueble];
                    [segue.destinationViewController setTitle:inmuTmp.colonia];
                    
                }
                
            }
            
        }
        
    }
}
@end
