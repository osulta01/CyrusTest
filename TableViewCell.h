//
//  TableViewCell.h
//  CyrusTest
//
//  Created by ohida sultana on 7/29/15.
//  Copyright (c) 2015 WorldPress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong,nonatomic)IBOutlet UILabel *firstnameLable;
@property (strong,nonatomic)IBOutlet UILabel *lastnameLable;
@property (strong,nonatomic)IBOutlet UILabel *dateLable;
@property (strong,nonatomic)IBOutlet UILabel *colorLable;
@property(strong,nonatomic)IBOutlet UILabel *genderLable;
@end
