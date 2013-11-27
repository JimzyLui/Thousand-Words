//
//  TWFiltersCollVC.m
//  Thousand Words
//
//  Created by Jimzy Lui on 11/26/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "TWFiltersCollVC.h"
#import "TWPhotoCollVCell.h"
#import "Photo.h"

@interface TWFiltersCollVC ()

@property(strong,nonatomic)NSMutableArray *filters;
@property(strong,nonatomic)CIContext *context;

@end

@implementation TWFiltersCollVC

-(NSMutableArray *)filters
{
    if(!_filters) _filters = [[NSMutableArray alloc] init];
    if(self){
        //custom initialization
        
    }
    return _filters;
}

-(CIContext *)context
{
    if(!_context) _context = [CIContext contextWithOptions:nil];
    
    return _context;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.filters = [[[self class] photoFilters] mutableCopy];
    //    for(CIFilter *filter in [[self class] photoFilters]){
    //        [self.filters addObject:filter];
    //    }
    //NSLog(@"%@",self.filters);
    //NSLog(@"%@",self.photo);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

+(NSArray *)photoFilters
{
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:nil];
    
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputRadiusKey, @1, nil];
    
    CIFilter *colorClamp = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputMaxComponents", [CIVector vectorWithX:0.9 Y:0.9 Z:0.9 W:0.9], @"inputMinComponents", [CIVector vectorWithX:0.2 Y:0.2 Z:0.2 W:0.2], nil];
    
    CIFilter *instant = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues: nil];
    
    CIFilter *noir = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues: nil];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues: nil];
    
    CIFilter *colorControls = [CIFilter filterWithName:@"CIColorControls" keysAndValues: kCIInputSaturationKey, @0.5, nil];
    
    CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues: nil];
    
    CIFilter *unsharpen = [CIFilter filterWithName:@"CIUnsharpMask" keysAndValues: nil];
    
    CIFilter *monochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues: nil];
    
    NSArray *allFilters = @[sepia, blur, colorClamp, instant, noir, vignette, colorControls, transfer, unsharpen, monochrome];
    
    return allFilters;
}

-(UIImage *)filteredImageFromImage:(UIImage *)image andFilter:(CIFilter *)filter
{
    CIImage *unfilteredImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    
    [filter setValue:unfilteredImage forKey:kCIInputImageKey];
    CIImage *filteredImage = [filter outputImage];
    
    CGRect extent = [filteredImage extent];
    
    CGImageRef cgImage = [self.context createCGImage:filteredImage fromRect:extent];
    
    UIImage *finalImage = [UIImage imageWithCGImage:cgImage];
    
    //NSLog(@"%@", UIImagePNGRepresentation(finalImage));
    
    return finalImage;
}



#pragma mark - UICollectionView DataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo Cell";
    
    TWPhotoCollVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    dispatch_queue_t filterQueue = dispatch_queue_create("filter queue", NULL);
    
    dispatch_async(filterQueue, ^{
        UIImage *filterImage = [self filteredImageFromImage:self.photo.image andFilter:self.filters[indexPath.row]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = filterImage;
        });
    });
    
    
    //cell.imageView.image = self.photo.image;
    //cell.imageView.image = [self filteredImageFromImage:self.photo.image andFilter:self.filters[indexPath.row]];  //replaced by blocks above
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.filters count];
}

#pragma mark - UICOllectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TWPhotoCollVCell *selectedCell = (TWPhotoCollVCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.photo.image = selectedCell.imageView.image;
    
    //NSLog(@"%@",selectedCell);
    if(self.photo.image){
        
        NSError *error = nil;
        
        if (![[self.photo managedObjectContext] save:&error]) {
            //Handle Error
            NSLog(@"%@", error);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
















@end
