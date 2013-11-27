//
//  TWPhotosCVC.m
//  Thousand Words
//
//  Created by Jimzy Lui on 11/25/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "TWPhotosCollectionVC.h"
#import "TWPhotoCollVCell.h"
#import "Photo.h"
#import "TWPictureDataTransformer.h"
#import "TWCoreDataHelper.h"
#import "TWPhotoDetailVC.h"


@interface TWPhotosCollectionVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic)NSMutableArray *photos;  // of UIImages

@end

@implementation TWPhotosCollectionVC

//Lazy instantiation
-(NSMutableArray *)photos
{
    if (!_photos){
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
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

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSSet *unorderedPhotos = self.album.photos;  //an object can not be repeated by definition of a set
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortedPhotos = [unorderedPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
    self.photos = [sortedPhotos mutableCopy];
    
    [self.collectionView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Detail Segue"]){
        if([segue.destinationViewController isKindOfClass:[TWPhotoDetailVC class]]){
            TWPhotoDetailVC *targetVC = segue.destinationViewController;
            NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];  //to figure out which cell was pressed
            
            Photo *selectedPhoto = self.photos[indexPath.row];
            targetVC.photo = selectedPhoto;
        }
    }
}


/*  When we press the camera button we create a UIImagePickerController and
    present the available option of on the screen.  If the camera is available
    because we are using our phone we show that.  If not then we show the Photos Album. */

- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Helper Methods

-(Photo *)photoFromImage:(UIImage *)image
{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[TWCoreDataHelper managedObjectContext]];
    photo.image = image;
    photo.date = [NSDate date];
    photo.albumBook = self.album;
    
    NSError *error = nil;
    if(![[photo managedObjectContext] save:&error]){
        //Error in saving
        NSLog(@"%@",error);
    }
    return photo;
}


#pragma mark - UICollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo Cell";
    
    TWPhotoCollVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Photo *photo = self.photos[indexPath.row];
    
    
    cell.backgroundColor = [UIColor whiteColor];
    //cell.imageView.image = [UIImage imageNamed:@"Astronaut.jpg"];
    //UIImage *image = self.photos[indexPath.row];
    //cell.imageView.image = image;
    //cell.imageView.image = self.photos[indexPath.row];
    cell.imageView.image = photo.image;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //NSLog(@"Finished Picking");
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(!image) image = info[UIImagePickerControllerOriginalImage];
    
    //[self.photos addObject:image];
    [self.photos addObject:[self photoFromImage:image]];
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
