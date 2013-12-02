//
//  VerInmuebleVC.h
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/18/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Inmueble.h"

@interface VerInmuebleVC : UIViewController <MFMailComposeViewControllerDelegate>
@property(nonatomic) NSInteger idInmueble;
@end
