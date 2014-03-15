//
//  areaListViewController.m
//  AppHotmeal
//
//  Created by admin on 3/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "areaListViewController.h"
#import "indexViewController.h"
#import "area.h"
#import "areaManager.h"
#import "areaConnect.h"
#import "AreaCell.h"
#import "ShoppingCartViewController.h"
@interface areaListViewController()<areaManagerDelegate>{
    NSArray*_area;
    areaManager*_areaManager;
}

@end

@implementation areaListViewController
@synthesize listArea;
@synthesize idSeque;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _areaManager=[[areaManager alloc]init];
    _areaManager.esConnect=[[areaConnect alloc]init];
    _areaManager.esConnect.delegate=_areaManager;
    _areaManager.delegate=self;
    [_areaManager receiveDataArea];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(void)getDataArea:(NSArray*)data{
    
    _area=data;
    [self.listArea reloadData];
}
-(void)getDataAreaFailed:(NSError *)error{
    NSLog(@"%@",error);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return _area.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AreaCell *cell = [self.listArea dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    area *object=_area[indexPath.row];
    
    [cell.name setText:object.name];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1 = [self.listArea cellForRowAtIndexPath:indexPath];
    [cell1 setAccessoryType:UITableViewCellAccessoryCheckmark];
    if([self.idSeque isEqualToString:@"index"]){
        [self performSegueWithIdentifier:@"idArea2" sender:self];
    }else if([self.idSeque isEqualToString:@"idShopping"]){
        [self performSegueWithIdentifier:@"idShopping" sender:self];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.listArea indexPathForSelectedRow];
    area *object=_area[indexPath.row];

    if ([segue.identifier isEqualToString:@"idArea2"]) {
        indexViewController *indexViewController= segue.destinationViewController;
        indexViewController.idA = object.id;
        indexViewController.nameArea = object.name;
    }else if ([segue.identifier isEqualToString:@"idShopping"]){
        //ShoppingCartViewController *shoppingViewController= segue.destinationViewController;
        //shoppingViewController.idArea = object.id;
        //shoppingViewController.nameArea = object.name;
    }
}

- (void)dealloc {
    [listArea release];
    [super dealloc];
}
@end
