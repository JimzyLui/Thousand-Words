//
//  TWCoreDataHelper.m
//  Thousand Words
//
//  Created by Jimzy Lui on 11/24/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "TWCoreDataHelper.h"

@implementation TWCoreDataHelper


+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    
    return context;
}


@end
