//
//  TWPhotosCollectionVC.h
//  Thousand Words
//
//  Created by Jimzy Lui on 11/25/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface TWPhotosCollectionVC : UICollectionViewController

@property(strong,nonatomic)Album *album;

- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
