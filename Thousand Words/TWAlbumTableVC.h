//
//  TWAlbumTableVC.h
//  Thousand Words
//
//  Created by Jimzy Lui on 11/24/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWAlbumTableVC : UITableViewController

@property(strong,nonatomic)NSMutableArray *albums;
- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
