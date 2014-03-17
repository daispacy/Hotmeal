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
@interface indexViewController ()<AreaViewDelegate>{
    
}

@end

@implementation indexViewController
@synthesize btnNext;
@synthesize selectArea;
@synthesize nameArea;
@synthesize idA;
@synthesize _areaViewController;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self._areaViewController = [[AreaViewController alloc] initWithNibName:@"AreaViewController" bundle:nil];
    self._areaViewController.delegate=self;
    [self presentPopupViewController:self._areaViewController animationType:ANIMATE];
}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    //return 100;
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%@",self.nameArea);
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
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [btnNext release];
    [selectArea release];
    [super dealloc];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"idArea"]) {
        ListingViewController *listingViewController= segue.destinationViewController;
        listingViewController.idArea = self.idA;
        listingViewController._nameArea=self.nameArea;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self presentPopupViewController:self._areaViewController animationType:ANIMATE];
}
- (IBAction)btnNext:(id)sender {
    NSLog(@"%d",self.nameArea.length);
    if(self.nameArea.length!=0){
        [self performSegueWithIdentifier:@"idArea" sender:self];
    }else{
        [self presentPopupViewController:self._areaViewController animationType:ANIMATE];
    }
}
-(void)alert:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thông báo" message: message delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show]; [alert release];
}

@end
