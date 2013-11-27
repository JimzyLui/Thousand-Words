//
//  TWPhotoDetailVC.h
//  Thousand Words
//
//  Created by Jimzy Lui on 11/26/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface TWPhotoDetailVC : UIViewController

@property(strong,nonatomic)Photo *photo;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)AddFilterButtonPressed:(UIButton *)sender;
- (IBAction)DeleteButtonPressed:(UIButton *)sender;

@end
