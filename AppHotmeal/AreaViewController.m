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
#import "staticConfig.h"

@interface AreaViewController ()<areaManagerDelegate>{
    NSArray*_area;
    areaManager*_areaManager;
}

@end

@implementation AreaViewController
@synthesize delegate;
@synthesize listArea;
@synthesize loading;
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
    [loading startAnimating];
    loading.hidesWhenStopped = YES;
    NSStringEncoding *encoding = NULL;
    dispatch_queue_t queue = dispatch_get_global_queue(
                                                       DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@",HOST,API,OPAREA];
        NSLog(@"url: %@",urlString);
        NSURL* url=[[NSURL alloc]initWithString:urlString];
        //Load the json on another thread
        NSString *jsonreturn = [[NSString alloc] initWithContentsOfURL:url usedEncoding:encoding error:NULL];
        [jsonreturn release];
        //When json is loaded stop the indicator
        [loading performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
    });
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
    [loading release];
    [super dealloc];
}
@end
