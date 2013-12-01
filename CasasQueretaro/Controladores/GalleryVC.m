//
//  GalleryVC.m
//  CasasQueretaro
//
//  Created by Gerardo Reyes on 18/11/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "GalleryVC.h"
#import "InmueblesProxy.h"
#import "Inmueble.h"



static CGFloat const kImageDistance = 5;

static CGSize CGSizeResizeToHeight(CGSize size, CGFloat height) {
    size.width *= height / size.height;
    size.height = height;
    return size;
}








@interface GalleryVC () {

     NSArray *properties;
}


@property BOOL isViewSelected;
@property UIView *selectedView;
@property (strong, nonatomic) NSCache *imageCache;
@property (strong, nonatomic) UIScrollView *contentView;
@property (strong, nonatomic) InmueblesProxy *propertiesProxy;


- (void) setImageViews;
- (void) deviceOrientationChange; // cambiarlo por un bloque
- (CGSize) setImageViewsFramesSize:(CGSize)size;



@end





@implementation GalleryVC



/***************************************************
                    GETTERS
 ****************************************************/


- (InmueblesProxy *)propertiesProxy {
    
    if (!_propertiesProxy) {
        _propertiesProxy = [[InmueblesProxy alloc] init];
    }
    
    return _propertiesProxy;
    
}



- (NSCache *)imageCache {
    
    if(!_imageCache) {
        _imageCache = [[NSCache alloc] init];
        _imageCache.name = @"Gallery Image Cache";
        _imageCache.countLimit = 50;
    }
    
    return _imageCache;
}





/***************************************************
                    SETTERS
 ****************************************************/










/***************************************************
                    FUNCTIONS
 ****************************************************/


- (id) init {
    
    if (!self) {
        self = [super init];
    }
 
    /*
     
    DE NADA SIRVE MI INICIALIZACIÓN, ASQUEROSO STORYBOARD! 
     
    */
    self.isViewSelected = false;
    self.views = [[NSMutableArray alloc] init];
    properties =  [self.propertiesProxy getInmueblesPorTipo:NULL];

    for (Inmueble *property in properties) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNull null] forKey:@"view"];
        [dict setObject:[NSNull null] forKey:@"origin"];
        [self.views addObject:dict];
        
    }
     
    return self;
}



- (void)setImageViews {
    
    NSInteger index;
    
    index = 0;
    //Retiramos todas las sub - vistas
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    /*DUDA DE BLOCK*/
    for (__block Inmueble *property in properties) {
        
        UIImage *image;
        UITapGestureRecognizer *tap;
        __block UIImageView *imageView;
        
        image = [self.imageCache objectForKey: property.imgPrincipal];        
        
        if (image){
            
            imageView = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            
        }else{
            
            dispatch_queue_t imageFetcherQ;

            image = [UIImage imageNamed:@"noImage300x225.png"];
            imageView = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            
            imageFetcherQ = dispatch_queue_create("image_fetcher", NULL);
            dispatch_async(imageFetcherQ, ^{
                
                NSURL    *imageURL;
                NSData   *imageData;
                NSString *imagePath;
                UIImage  *tempImage;
                
                [NSThread sleepForTimeInterval:1.0];
                imagePath = [[NSString alloc] initWithFormat:@"%@%@", property.imgPath, property.imgPrincipal];
                imageURL = [[NSURL alloc] initWithString:imagePath];
                
                NSLog(@"Img inmu.imgPath %@", property.imgPath);
                NSLog(@"Procesando imagen en el thread %@", imagePath);
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                imageData = [[NSData alloc] initWithContentsOfURL: imageURL];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                tempImage = [[UIImage alloc] initWithData:imageData];
                
                if (tempImage) {
                    
                    NSLog(@"Thread obtuvo la imagen %@", property.imgPrincipal);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        imageView.image = tempImage;
                    });
            
                    [self.imageCache setObject:image forKey:property.imgPrincipal];
                }
           
            });
        
        }

        
        
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(touchElement:)];
        [imageView addGestureRecognizer:tap];
        [self.contentView addSubview:imageView];
        [[self.views objectAtIndex:index]  setValue:imageView forKey:@"view"];
        index++;
        
    }
    
    self.contentView.contentSize = [self setImageViewsFramesSize: self.contentView.frame.size];
    //NSLog(@"%f %f", self.contentView.contentSize.width,self.contentView.contentSize.height);
}


- (void)deviceOrientationChange {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(setImageViews)
                                               object:nil];
    [self performSelector:@selector(setImageViews)
               withObject:nil
               afterDelay:1];
}









#pragma mark






- (CGSize)setImageViewsFramesSize:(CGSize)size {

    /**
     Linear Partition
     */
    int N = self.views.count;
    CGRect newFrames[N];
    float ideal_height = MAX(size.height, size.width) / 4;
    float seq[N];
    float total_width = 0;
    for (int i = 0; i < N; i++) {
        //UIImage *image = [[self.views objectAtIndex:i] image];
        UIImage *image = ((UIImageView *)[[self.views objectAtIndex:i] valueForKey:@"view"]).image;
        CGSize newSize = CGSizeResizeToHeight(image.size, ideal_height);
        newFrames[i] = (CGRect) {{0, 0}, newSize};
        seq[i] = newSize.width;
        total_width += seq[i];
    }
    
    int K = (int)roundf(total_width / size.width);
    
    float M[N][K];
    float D[N][K];
    
    for (int i = 0 ; i < N; i++)
        for (int j = 0; j < K; j++)
            D[i][j] = 0;
    
    for (int i = 0; i < K; i++)
        M[0][i] = seq[0];
    
    for (int i = 0; i < N; i++)
        M[i][0] = seq[i] + (i ? M[i-1][0] : 0);
    
    float cost;
    for (int i = 1; i < N; i++) {
        for (int j = 1; j < K; j++) {
            M[i][j] = INT_MAX;
            
            for (int k = 0; k < i; k++) {
                cost = MAX(M[k][j-1], M[i][0]-M[k][0]);
                if (M[i][j] > cost) {
                    M[i][j] = cost;
                    D[i][j] = k;
                }
            }
        }
    }
    
    /**
     Ranges & Resizes
     */
    int k1 = K-1;
    int n1 = N-1;
    int ranges[N][2];
    while (k1 >= 0) {
        ranges[k1][0] = D[n1][k1]+1;
        ranges[k1][1] = n1;
        
        n1 = D[n1][k1];
        k1--;
    }
    ranges[0][0] = 0;
    
    float cellDistance = 5;
    float heightOffset = cellDistance, widthOffset;
    float frameWidth;
    for (int i = 0; i < K; i++) {
        float rowWidth = 0;
        frameWidth = size.width - ((ranges[i][1] - ranges[i][0]) + 2) * cellDistance;
        
        for (int j = ranges[i][0]; j <= ranges[i][1]; j++) {
            rowWidth += newFrames[j].size.width;
        }
        
        float ratio = frameWidth / rowWidth;
        widthOffset = 0;
        
        for (int j = ranges[i][0]; j <= ranges[i][1]; j++) {
            newFrames[j].size.width *= ratio;
            newFrames[j].size.height *= ratio;
            newFrames[j].origin.x = widthOffset + (j - (ranges[i][0]) + 1) * cellDistance;
            newFrames[j].origin.y = heightOffset;
            
            widthOffset += newFrames[j].size.width;
        }
        heightOffset += newFrames[ranges[i][0]].size.height + cellDistance;
    }
    
    
    
    for (int i = 0; i < N; i++) {
        //UIImageView *imgView = imageViews[i];
        UIImageView *imgView = ((UIImageView *)[[self.views objectAtIndex:i] valueForKey:@"view"]);
        [[self.views objectAtIndex:i] setValue:[NSValue valueWithCGRect:newFrames[i]] forKey:@"frame"];
        imgView.frame = newFrames[i];
        [self.contentView addSubview:imgView];
    }
    
    return CGSizeMake(size.width, heightOffset);
}






//
//////////////////////////////////////////////////////////
//// Views functions
//////////////////////////////////////////////////////////
//
//- (void) setViews:(NSArray*) views{
//    self._views = [[NSMutableArray alloc] initWithArray:views];
//    [self initViews];
//}
//
//- (NSArray*) getViews{
//    return self._views;
//}
//
//- (void) addView:(UIView*) view{
//    [self._views addObject:view];
//    [self initListenerFor:view];
//}
//
//- (void) initViews{
//    for (UIView* view in self._views) {
//        [self initListenerFor:view];
//    }
//}
//
//////////////////////////////////////////////////////////
//// Events
//////////////////////////////////////////////////////////
//
//

- (void) touchElement:(UITapGestureRecognizer*)gesture{
    
    
    //[self.contentView setContentSize:CGSizeMake(0.0,0.0)];
        
    if(self.isViewSelected){
        [self closeThisView:gesture.view];
    }else{
        [self openThisView:gesture.view];
    }
}

//////////////////////////////////////////////////////////
//// Animations
//////////////////////////////////////////////////////////

- (void)openThisView:(UIView*) view{
    if(self.isViewSelected){
        [self closeThisView:self.selectedView];
        
    }
    NSLog(@"SI");
  
       
        struct CGPoint origine = view.frame.origin;
        for (NSMutableDictionary *dict in self.views ) {
            
            
            UIView *viewItem = ((UIImageView *)[dict valueForKey:@"view"]);
            if (viewItem != view) {
                
                 //Add Animation to UIView
                [viewItem explositionWithOrigine:origine WithDistance:1024.0f WithDuration:0.4f AndDelay:0.0f];
                
            }else{
                
                CGRect screenRect = [[UIScreen mainScreen] bounds];
                CGFloat screenWidth = screenRect.size.width;
                CGFloat screenHeight = screenRect.size.height;
                
                [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionAllowUserInteraction
                                 animations:^{viewItem.frame = CGRectMake(0,0,screenWidth,screenHeight);} completion:nil];
            }
        }
        self.isViewSelected = true;
        self.selectedView = view;
    
}

- (void)closeThisView:(UIView*) view{
    

    for(int i = 0; i < self.views.count; ++i){
            UIView *viewItem = [[self.views objectAtIndex:i] objectForKey:@"view"];
            [UIView animateWithDuration:0.4
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 viewItem.frame = [[[self.views objectAtIndex:i] objectForKey:@"frame"] CGRectValue];}
                             completion:nil];
      
        }
        self.isViewSelected = false;
    
}











/***************************************************
                DEFAULT FUNCTIONS
****************************************************/


- (void)loadView {
    
    [super loadView];
    
    self.isViewSelected = false;
    self.views = [[NSMutableArray alloc] init];
    properties =  [self.propertiesProxy getInmueblesPorTipo:NULL];

    for (Inmueble *property in properties) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNull null] forKey:@"view"];
        [dict setObject:[NSNull null] forKey:@"frame"];
        [self.views addObject:dict];
        
    }
    
    self.contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.contentView];
    [self setImageViews];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(deviceOrientationChange)
    //                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //self.exploseContainer = [[AnimationExploseContainer alloc] initWithViews:self.allViews];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
