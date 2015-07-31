//
//  TableViewCell.m
//  CyrusTest
//
//  Created by ohida sultana on 7/29/15.
//  Copyright (c) 2015 WorldPress. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize firstnameLable,lastnameLable,dateLable,colorLable,genderLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

