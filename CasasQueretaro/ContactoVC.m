//
//  ContactoVC.m
//  CasasQueretaro
//
//  Created by Ana Laura Becerra Cantero on 11/18/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "ContactoVC.h"

@interface ContactoVC ()

@end

@implementation ContactoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    [self cargarControladorMail];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)botonEnviarCorreo:(UIButton *)sender {
    [self cargarControladorMail];
}

- (void) cargarControladorMail
{
    // Email Subject
    NSString *emailTitle = @"Contacto CasasQueretaro App";
    // Email Content
    NSString *messageBody = @"Buenos días; <br>Me gustaría pedir informes...";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"ventas@casasqueretaro.com.mx"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}



@end
