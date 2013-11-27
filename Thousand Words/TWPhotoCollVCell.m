//
//  TWPhotoCollVCell.m
//  Thousand Words
//
//  Created by Jimzy Lui on 11/25/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "TWPhotoCollVCell.h"
#define IMAGEVIEW_BORDER_LENGTH 5

@implementation TWPhotoCollVCell

- (id)initWithFrame:(CGRect)frame  //called by code
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder  //called by storyboard
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, IMAGEVIEW_BORDER_LENGTH, IMAGEVIEW_BORDER_LENGTH)];  //gives a nice white border around our photos
    [self.contentView addSubview:self.imageView];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
