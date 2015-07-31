//
//  MasterViewController.m
//  CyrusTest
//
//  Created by ohida sultana on 7/29/15.
//  Copyright (c) 2015 WorldPress. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "TableViewCell.h"

@interface MasterViewController ()<UIActionSheetDelegate> {
    NSMutableArray *newArrays;
    NSString *firstname;
    NSString *lastname;
    NSString *color;
    NSString *date;
    NSString *gender;
    NSDictionary *jsonDic;
}
@property  NSArray* dataList;

@end

@implementation MasterViewController
@synthesize tableView=_tableView;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    newArrays=[NSMutableArray array];
    self.tableView.dataSource = self;
    self.tableView.delegate= self;
    [self readDataFromFile];
    
    [self.tableView reloadData];
    
}
- (void)viewWillAppear
{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)readDataFromFile
{
    // load the data from local file
    NSString *filename= [[NSBundle mainBundle]pathForResource:@"list" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    // perse the json into an array
    NSError * error;
    
    
    jsonDic= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"Files:%@",jsonDic);
    if (!error) {
        //handle error
        
    }
    
    
    newArrays = [NSMutableArray array];
    for (NSDictionary * dictionary in [jsonDic objectForKey:@"results"]) {
        
        firstname =[dictionary objectForKey:@"firstname"];
        lastname=[dictionary objectForKey: @"lastname"];
        color=[dictionary objectForKey:@"color"];
        date =[dictionary objectForKey:@"DOB"];
        gender=[dictionary objectForKey:@"gender"];
        
        
        NSDictionary  *newDictionary =[[NSDictionary alloc] initWithObjectsAndKeys:firstname,@"firstname",lastname,@"lastname",color,@"color",gender,@"gender",date,@"DOB", nil];
        [newArrays addObject:newDictionary];
    }
    
    NSLog(@"File:%@", newArrays);
    

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [newArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    //Fetch Item
    
    NSDictionary *object= [newArrays objectAtIndex:indexPath.row];
    
    cell.firstnameLable.text= [object objectForKey:@"firstname"];
    cell.lastnameLable.text=[object objectForKey:@"lastname"];
    cell.colorLable.text=[object objectForKey:@"color"];
    cell.genderLable.text=[object objectForKey:@"gender"];
    cell.dateLable.text=[object objectForKey:@"DOB"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [newArrays removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}



- (IBAction)filterBy:(id)sender {
    
    UIActionSheet *message = [[UIActionSheet alloc]
                              initWithTitle:@"TOP RECOMMENDATIONS \n" @"Select the type of object you'd like to see"
                              delegate:nil
                              cancelButtonTitle:@"CANCEL"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"FirstName",@"LastName",
                              @"gender", nil];
    
    message.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    
    [message showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSSortDescriptor *sorter;
    
    
    switch (buttonIndex) {
        case 0:{
        sorter = [[NSSortDescriptor alloc] initWithKey:@"firstname" ascending:YES selector:@selector(localizedStandardCompare:)];
        NSArray *sortedArray = [newArrays sortedArrayUsingDescriptors: @[sorter]];

        NSLog(@"newArray%@",sortedArray);
        
            break;
        }
        case 1:{
            sorter = [[NSSortDescriptor alloc] initWithKey:@"lastname" ascending:YES selector:@selector
                      (localizedStandardCompare:)];
            NSArray *sortedArray = [newArrays sortedArrayUsingDescriptors:@[sorter]];
            NSLog(@"newArray%@",sortedArray);
            
            break;
        }
       case 2:
        {
            sorter = [[NSSortDescriptor alloc] initWithKey:@"gender" ascending:YES selector:@selector(localizedStandardCompare:)];
            
            NSArray *sortedArray = [newArrays sortedArrayUsingDescriptors: @[sorter]];
            NSLog(@"newArray%@",sortedArray);
        }
                default:
        break;
    }
    
    [self.tableView reloadData];
    }


 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
     
 }



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *object = newArrays[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
