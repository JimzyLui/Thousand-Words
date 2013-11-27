//
//  TWPhotoDetailVC.m
//  Thousand Words
//
//  Created by Jimzy Lui on 11/26/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "TWPhotoDetailVC.h"
#import "Photo.h"
#import "TWFiltersCollVC.h"

@interface TWPhotoDetailVC ()

@end

@implementation TWPhotoDetailVC

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
    
    self.imageView.image = self.photo.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Filter Segue"]){
        if([segue.destinationViewController isKindOfClass:[TWFiltersCollVC class]]){
            TWFiltersCollVC *targetVC = segue.destinationViewController;
            targetVC.photo = self.photo;
            
        }
    }
}

- (IBAction)AddFilterButtonPressed:(UIButton *)sender
{
    
}

- (IBAction)DeleteButtonPressed:(UIButton *)sender
{
    [[self.photo managedObjectContext] deleteObject:self.photo];
    
    //NSLog(@"%@ %@", self.photo, [self.photo managedObjectContext]);
    
    NSError *error = nil;
    
    [[self.photo managedObjectContext] save:&error];
    
    if(error){
        NSLog(@"error");
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
    
}





@end
