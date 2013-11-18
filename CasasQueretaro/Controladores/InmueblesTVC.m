//
//  InmueblesTVC.m
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/17/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "InmueblesTVC.h"
#import "Inmuebles.h"
#import "Inmueble.h"

@interface InmueblesTVC () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) Inmuebles *inmuebles;
@end

@implementation InmueblesTVC

-(Inmuebles *)inmuebles{
    if(!_inmuebles){
        _inmuebles = [[Inmuebles alloc] init];
    }
    return _inmuebles;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.inmuebles getInmueblesPorTipo:@"Casas"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *allInmuebles = [self.inmuebles getInmueblesPorTipo:@"Casas"];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
