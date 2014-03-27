//
//  indexViewController.m
//  AppHotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "indexViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "ListingViewController.h"
#import "AreaViewController.h"
#import "selectCell.h"
#import "staticConfig.h"
#import "SWRevealViewController.h"

#import "area.h"
#import "areaManager.h"
#import "areaConnect.h"
#import "functions.h"

@interface indexViewController ()<AreaViewDelegate,areaManagerDelegate>{
    NSArray*_area;
    areaManager*_areaManager;
    
}

@end

@implementation indexViewController
@synthesize btnNext;
@synthesize selectArea;
@synthesize nameArea;
@synthesize idA;
@synthesize _areaViewController;
@synthesize listArea;
- (void)viewDidLoad
{

    [super viewDidLoad];
    _areaManager=[[areaManager alloc]init];
    _areaManager.esConnect=[[areaConnect alloc]init];
    _areaManager.esConnect.delegate=_areaManager;
    _areaManager.delegate=self;
    //[_areaManager receiveDataArea];
    self._areaViewController = [[AreaViewController alloc] initWithNibName:@"AreaViewController" bundle:nil];
    self._areaViewController.delegate=self;
    //[HUD showUIBlockingIndicatorWithText:@"Loading ..."];

    
    //dispatch_async(kBgQueue, ^{
        
    [_areaManager receiveDataArea];
        
            //dispatch_async(dispatch_get_main_queue(), ^{
                
                //[HUD hideUIBlockingIndicator];
               // });
            
        
   // });
    

}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    //return 100;
}
-(void)viewDidAppear:(BOOL)animated{
    //[HUD showUIBlockingIndicatorWithText:@"Loading ..."];
}
-(void)getDataArea:(NSArray*)data{
    _area=data;
}

-(void)getDataAreaFailed:(NSError *)error{
    [functions alert:@"Lỗi kết nối tới server" title:@"Lỗi" buttonTitle:@"Refresh" controller:self];
}
-(NSArray*)getArrayArea{
    return _area;
}
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    selectCell *cell=[self.selectArea dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if(self.nameArea==nil){
    [cell.nameArea setText:@"Chọn quận"];
    }else{
       [cell.nameArea setText:self.nameArea];
    }
    return cell;
}
-(void)setIdAndNameArea:(AreaViewController *)controller idarea:(NSString *)id namearea:(NSString *)name{
    self.nameArea=name;
    self.idA=id;
    NSIndexPath *indexPath = [self.selectArea indexPathForSelectedRow];
    selectCell *cell=[self.selectArea dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.nameArea setText:self.nameArea];
    [self.selectArea reloadData];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self performSegueWithIdentifier:@"idArea" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"idArea"]) {
        //ListingViewController*listingVC = [[ListingViewController alloc]init];
        //listingVC.idArea = self.idA;
        //[self.view addSubview:listingVC.view];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.idA forKey:@"idArea"];
        [defaults setObject:self.nameArea forKey:@"nameArea"];
        //[listingVC release];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self presentPopupViewController:self._areaViewController animationType:ANIMATE];
}
- (IBAction)btnNext:(id)sender {
    if(self.nameArea.length!=0){
        
        [self performSegueWithIdentifier:@"idArea" sender:self];
    }else{
        [self presentPopupViewController:self._areaViewController animationType:ANIMATE];
    }
}
-(void)alert:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thông báo" message: message delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show]; 
}

@end
