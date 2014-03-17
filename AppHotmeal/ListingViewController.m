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
#import "staticConfig.h"

@interface ListingViewController()<estoreManagerDelegate>{
    NSMutableArray*_estore;
    estoreManager*_esManager;
}

@end

@implementation ListingViewController
@synthesize idArea;
@synthesize idEstore;
@synthesize _nameArea;
@synthesize pages;
@synthesize page;
@synthesize footerLabel;
@synthesize activityIndicator;
@synthesize totalSize;

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
    self.page=1;
    _estore=[[NSMutableArray alloc]init];
    _esManager.esConnect=[[estoreConnect alloc]init];
    _esManager.esConnect.delegate=_esManager;
    _esManager.delegate=self;
    [self setupTableViewFooter];
    [_esManager receiveData:idArea page:self.page];
}

-(void)getData:(NSArray*)data{
    //NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"status" ascending:NO];
    //[data sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            [_estore addObjectsFromArray:data];
        estore *object=_estore[0];
        self.pages=object.pages;
    self.totalSize=object.total;
    if(self.page==1){
        [self.tableView reloadData];
    }else{
        [self fetchTable:_estore.count totalDisplay:self.page*15 results:data];
    }
    self.page++;
}
-(void)getDataFailed:(NSError *)error{
    NSLog(@"%@",error);
}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"so luong _estore %d",_estore.count);
        return _estore.count;
    //return 100;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EstoreCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray*Temp = _estore;
    estore *object=Temp[indexPath.row];
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
    cell.imgView.image = nil;
    NSString*url=[NSString stringWithFormat:@"http://hotmeal.vn/gallery/0/resources/a_%@",object.image];
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //EstoreCell *updateCell=[self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                        cell.imgView.image = image;
                });
            }
        }
    });
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idEstore"]) {
       
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        estore *object=_estore[indexPath.row];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:object.id forKey:@"idEstore"];
        [defaults setObject:self.idArea forKey:@"idArea"];
        [defaults setObject:self._nameArea forKey:@"nameArea"];
        [defaults setObject:[NSString stringWithFormat:@"%d",object.status] forKey:@"status"];
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

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // when reaching bottom, load a new page
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height)
    {
        // ask next page only if we haven't reached last page
        if (self.page<=self.pages) {
            [self nextPage];
        }else{
            [self.activityIndicator stopAnimating];
        }
    }
}

-(void)nextPage{
        [_esManager receiveData:idArea page:self.page];
        [self.activityIndicator startAnimating];
}

- (void)setupTableViewFooter
{
    // set up label
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    footerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = UITextAlignmentCenter;
    
    self.footerLabel = label;
    [footerView addSubview:label];
    
    // set up activity indicator
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.center = CGPointMake(40, 22);
    activityIndicatorView.hidesWhenStopped = YES;
    
    self.activityIndicator = activityIndicatorView;
    [footerView addSubview:activityIndicatorView];
    
    self.tableView.tableFooterView = footerView;
}

- (void)updateTableViewFooter
{
    if (page != 0)
    {
        self.footerLabel.text = [NSString stringWithFormat:@"%d/%d Nhà hàng", [_estore count], self.totalSize];
    } else
    {
        self.footerLabel.text = @"";
    }
    
    [self.footerLabel setNeedsDisplay];
}
- (void)fetchTable:(NSInteger)totalResults totalDisplay:(NSInteger)total results:(NSArray*)results
{
    // update tableview footer
    [self updateTableViewFooter];
    [self.activityIndicator stopAnimating];
    
    // update tableview content
    // easy way : call [tableView reloadData];
    // nicer way : use insertRowsAtIndexPaths:withAnimation:
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger i = totalResults - total;
    for(NSDictionary *result in results)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        i++;
    }
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}
@end
