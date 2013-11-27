//
//  Photo.h
//  Thousand Words
//
//  Created by Jimzy Lui on 11/26/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Photo : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Album *albumBook;

@end
