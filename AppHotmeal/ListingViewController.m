//
//  ListingViewController.m
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "ListingViewController.h"
#import "estore.h"
#import "estoreManager.h"
#import "estoreConnect.h"
#import "EstoreCell.h"


@interface ListingViewController()<estoreManagerDelegate>{
    NSArray*_estore;
    estoreManager*_esManager;
}

@end

@implementation ListingViewController
@synthesize idArea;
@synthesize idEstore;
@synthesize _nameArea;
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
    idEstore=[[NSMutableArray alloc]init];
	_esManager=[[estoreManager alloc]init];
    _esManager.esConnect=[[estoreConnect alloc]init];
    _esManager.esConnect.delegate=_esManager;
    _esManager.delegate=self;
    [_esManager receiveData:idArea];
    sleep(3);
}

-(void)getData:(NSArray*)data{
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"status" ascending:NO];
    [data sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    _estore=data;
    [self.tableView reloadData];
}
-(void)getDataFailed:(NSError *)error{
    NSLog(@"%@",error);
}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
        return [_estore count];
    //return 100;
}
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EstoreCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    estore *object=_estore[indexPath.row];
    [idEstore addObject:object.id];
    [cell.name setText:object.name];
    if (object.status==1) {
        [cell.status setTextColor:[UIColor greenColor]];
        [cell.status setText:@"Serving"];
    } else {
        [cell.status setTextColor:[UIColor redColor]];
        [cell.status setText:@"Close"];
    }
    [cell.open_hour setText:object.listime];
    
    [cell.like setText:[NSString stringWithFormat:@"%d",object.like]];
    [cell.min_delivery setText:object.min_delivery];
    //set up image
    NSString*url=[NSString stringWithFormat:@"http://hotmeal.vn/gallery/0/resources/a_%@",object.image];
    NSURL * imageURL = [NSURL URLWithString:url];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    [cell.imgView setImage:image];
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idEstore"]) {
       
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[idEstore objectAtIndex:indexPath.row] forKey:@"idEstore"];
        [defaults setObject:self.idArea forKey:@"idArea"];
        [defaults setObject:self._nameArea forKey:@"nameArea"];
        [defaults synchronize];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
@end
