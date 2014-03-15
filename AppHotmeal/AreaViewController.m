//
//  AreaViewController.m
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "AreaViewController.h"
#import "area.h"
#import "areaManager.h"
#import "areaConnect.h"
@interface AreaViewController ()<areaManagerDelegate>{
    NSArray*_area;
    areaManager*_areaManager;
}

@end

@implementation AreaViewController
@synthesize delegate;
@synthesize listArea;
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
    _areaManager=[[areaManager alloc]init];
    _areaManager.esConnect=[[areaConnect alloc]init];
    _areaManager.esConnect.delegate=_areaManager;
    _areaManager.delegate=self;
    [_areaManager receiveDataArea];
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
    return _area.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    area*object = _area[indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell = [[[NSBundle mainBundle] loadNibNamed:@"popupAreaCell" owner:self options:nil] lastObject];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",object.name]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    area*object =_area[indexPath.row];
    [self.delegate setIdAndNameArea:self idarea:object.id namearea:object.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [listArea release];
    [super dealloc];
}
@end
