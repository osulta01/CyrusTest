//
//  MasterViewController.h
//  CyrusTest
//
//  Created by ohida sultana on 7/29/15.
//  Copyright (c) 2015 WorldPress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)IBOutlet UITableView *tableView;

@end
