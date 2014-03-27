//
//  MenuCategoriesViewController.m
//  AppHotmeal
//
//  Created by admin on 3/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "MenuCategoriesViewController.h"
#import "ListingViewController.h"
#import "estorecategories.h"
#import "estorecategoriesManager.h"
#import "estorecategoriesConnect.h"
#import "functions.h"


@interface MenuCategoriesViewController ()<estorecategoriesManagerDelegate>{
    NSArray*_estoreCate;
    estorecategoriesManager*_estoreCateManager;
}

@end

@implementation MenuCategoriesViewController
@synthesize tblEstoreCategories;
@synthesize idArea;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.idArea = [defaults objectForKey:@"idArea"];
    NSLog(@"id area tu menu categories: %@",self.idArea);
    _estoreCateManager=[[estorecategoriesManager alloc]init];
    _estoreCateManager.ecConnect=[[estorecategoriesConnect alloc]init];
    _estoreCateManager.ecConnect.delegate=_estoreCateManager;
    _estoreCateManager.delegate=self;
    
    [_estoreCateManager receiveDataECate:self.idArea];
}

-(void)getDataECate:(NSArray *)data{
    _estoreCate=data;
    [self.tblEstoreCategories reloadData];
    
}

-(void)getDataECateFailed:(NSError *)error{
    [functions alert:@"Lỗi dữ liệu từ server" title:@"Error" buttonTitle:@"OK" controller:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _estoreCate.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    estorecategories*object =_estoreCate[indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell = [[[NSBundle mainBundle] loadNibNamed:@"popupAreaCell" owner:self options:nil] lastObject];
    }
    //cell.textLabel.textAlignment=UITextAlignmentCenter;
    //cell.textLabel.textColor=[UIColor redColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",object.vn_name]];

    return cell;
}
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tblEstoreCategories indexPathForSelectedRow];
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"Listing"]) {
        estorecategories*object =_estoreCate[indexPath.row];
        ListingViewController *listingController = (ListingViewController*)segue.destinationViewController;
        listingController.cId = object.id;
        listingController.idArea=self.idArea;
    }
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"Listing" sender:self];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forwardToIndex:(id)sender {
    [self performSegueWithIdentifier:@"forwardToIndex" sender:self];
}
@end
