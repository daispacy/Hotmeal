//
//  ListingViewController.m
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "ListingViewController.h"
#import "SWRevealViewController.h"

#import "estore.h"
#import "estoreManager.h"
#import "estoreConnect.h"
#import "EstoreCell.h"
#import "staticConfig.h"
#import "functions.h"
#import "HUD.h"

@interface ListingViewController()<estoreManagerDelegate>{
    NSMutableArray*_estore;
    NSMutableArray*_estoreKW;
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
@synthesize tblListing;
@synthesize cId;
@synthesize _kw;
@synthesize txtSearch;

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
    self._nameArea=[defaults objectForKey:@"nameArea"];
    if(self.cId==NULL)self.cId=@"";
    if(self.idArea==NULL)self.idArea=@"";
    self._kw=@"";
    
    // Change button color
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    idEstore=[[NSMutableArray alloc]init];
	_esManager=[[estoreManager alloc]init];
    self.page=1;
    _estore=[[NSMutableArray alloc]init];
    
    
    _esManager.esConnect=[[estoreConnect alloc]init];
    _esManager.esConnect.delegate=_esManager;
    _esManager.delegate=self;
    
    [self setupTableViewFooter];
    [_esManager receiveData:self.idArea cid:self.cId page:self.page kw:self._kw];
     
}

-(void)getData:(NSArray*)data{
    
    if(![self._kw isEqualToString:@""]){
        NSLog(@"estore : %@",_estore);
        [_estoreKW addObjectsFromArray:data];
        NSLog(@"estoreKW : %@",_estoreKW);
        estore *object=_estoreKW[0];
        self.pages=object.pages;
        self.totalSize=object.total;
        if(self.page==1){
            [self.tblListing reloadData];
        }else{
            [self fetchTable:_estoreKW.count+data.count totalDisplay:_estoreKW.count results:data];
        }
        //self.page++;
    }else{
        
        [_estore addObjectsFromArray:data];
        
        estore *object=_estore[0];
        self.pages=object.pages;
        self.totalSize=object.total;
        if(self.page==1){
            [self.tblListing reloadData];
        }else{
                
            [self fetchTable:_estore.count+data.count totalDisplay:_estore.count results:data];
        }
        
    }
    
    
}
-(void)getDataFailed:(NSError *)error{
    [functions alert:@"Lỗi dữ liệu từ server" title:@"Error" buttonTitle:@"OK" controller:self];
}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (![self._kw isEqualToString:@""]) {
            return _estoreKW.count;
    } else {
            return _estore.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Assign our own background image for the cell
    NSArray*Temp = [[NSArray alloc]init];
    if (![self._kw isEqualToString:@""]) {
        Temp = _estoreKW;
    } else {
        Temp = _estore;
    }
    estore *object=Temp[indexPath.row];
    
    if([object.message isEqualToString:@""]){
        
        [idEstore addObject:object.id];
        EstoreCell *cell=[self.tblListing dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
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
        NSString*url=[NSString stringWithFormat:@"%@%@",URLPATHIMGESTORE,object.image];
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
        UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
        
        UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
        cellBackgroundView.image = background;
        cell.backgroundView = cellBackgroundView;
        return cell;
        
    }else{
        NSLog(@"chay vao dya la  khong co ket qua");
        UITableViewCell *cell = [self.tblListing dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        //[cell.textLabel setTextAlignment:UITextAlignmentCenter];
       [cell.textLabel setText:@"No result"];
       return cell;
    }
    
    
}
- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tblListing] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idEstore"]) {
       
        NSIndexPath *indexPath = [self.tblListing indexPathForSelectedRow];
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
    self.page++;
    if(self.page<=self.pages){
        if(![self._kw isEqualToString:@""]){
            [_esManager receiveData:idArea cid:self.cId page:self.page kw:@""];
        }else{
            [_esManager receiveData:idArea cid:self.cId page:self.page kw:self._kw];
        }
        [self.activityIndicator startAnimating];
    }
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
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.center = CGPointMake(40, 22);
    activityIndicatorView.hidesWhenStopped = YES;
    
    self.activityIndicator = activityIndicatorView;
    [footerView addSubview:activityIndicatorView];
    
    self.tblListing.tableFooterView = footerView;
}

- (void)updateTableViewFooter
{
    if (page != 1)
    {
        self.footerLabel.text = [NSString stringWithFormat:@"%d/%d Nhà hàng",[self._kw isEqualToString:@""]?[_estore count]:[_estoreKW count], self.totalSize];
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
    
    [self.tblListing beginUpdates];
    [self.tblListing insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tblListing endUpdates];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    _estoreKW=[[NSMutableArray alloc]init];
    self.page=1;
    self._kw=self.txtSearch.text;
    [_esManager receiveData:idArea cid:self.cId page:self.page kw:self.txtSearch.text];
    [self updateTableViewFooter];
}

@end
