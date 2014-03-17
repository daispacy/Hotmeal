//
//  DetailViewController.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "DetailViewController.h"
#import "estoreDetail.h"
#import "estoreDetailManager.h"
#import "estoreDetailConnect.h"
#import "orderaddress.h"
#import "orderaddressManager.h"
#import "orderaddressConnect.h"
//#import "productCategory.h"
//#import "productCategoryManager.h"
//#import "productCategoryConnect.h"
#import "product.h"
#import "productManager.h"
#import "productConnect.h"
#import "ProductCell.h"
#import "cart.h"
#import <QuartzCore/QuartzCore.h>
#import "functions.h"
#import "staticConfig.h"

@interface DetailViewController()<estoreDetailManagerDelegate,productManagerDelegate,orderaddressManagerDelegate> {
    NSArray*_estore;
    NSArray*_proCate,*_product,*_orderaddress;
    estoreDetailManager*_esManager;
   // productCategoryManager*_proCateManager;
    productManager*_proManager;
    orderaddressManager*_odManager;
}

@end

@implementation DetailViewController
@synthesize idEstore;
@synthesize imgView;
@synthesize txtDescription;
@synthesize txtName;
@synthesize productView;
@synthesize productInCart;
@synthesize totalCart;
@synthesize idArea;
@synthesize nameArea;
@synthesize status;
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
    //---init-----
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    idEstore = [defaults objectForKey:@"idEstore"];
    idArea = [defaults objectForKey:@"idArea"];
    nameArea=[defaults objectForKey:@"nameArea"];
    status=[[defaults objectForKey:@"status"]doubleValue];
    self.productInCart=[[NSMutableArray alloc]init];
    totalCart=0;
    
    _esManager=[[estoreDetailManager alloc]init];
    _esManager.esConnect=[[estoreDetailConnect alloc]init];
    _esManager.esConnect.delegate=_esManager;
    _esManager.delegate=self;
    [_esManager receiveData:idEstore];
    /*
    _proCateManager=[[productCategoryManager alloc]init];
    _proCateManager.proCateConnect=[[productCategoryConnect alloc]init];
    _proCateManager.proCateConnect.delegate=_proCateManager;
    _proCateManager.delegate=self;
    [_proCateManager receiveData:idEstore];
    */
    _proManager=[[productManager alloc]init];
    _proManager.proConnect=[[productConnect alloc]init];
    _proManager.proConnect.delegate=_proManager;
    _proManager.delegate=(id)self;
    [_proManager receiveData:idEstore];
    
    
    _odManager=[[orderaddressManager alloc]init];
    _odManager.odConnect=[[orderaddressConnect alloc]init];
    _odManager.odConnect.delegate=_odManager;
    _odManager.delegate=self;
    [_odManager receiveData:self.idEstore idarea:self.idArea];
    
    ShoppingCartViewController *svc = [self.tabBarController.viewControllers objectAtIndex:1];
    svc.delegate = self;

   }
-(NSMutableArray*)getProduct:(ShoppingCartViewController *)controller{
    NSLog(@"product in CArt truoc khi gui %@",self.productInCart);
    return self.productInCart;
}
-(NSInteger)getTotalCart:(ShoppingCartViewController *)controller{
    return self.totalCart;
}
-(NSArray*)getOrderAddress:(ShoppingCartViewController *)controller{
    return _orderaddress;
}
-(NSString*)getNameArea:(ShoppingCartViewController *)controller{
    return self.nameArea;
}
-(NSString*)getIdStore:(ShoppingCartViewController *)controller{
    return self.idEstore;
}
-(NSString*)getIdEstore1:(ShoppingCartViewController *)controller{
    return self.idEstore;
}
-(void)displayData{
    estoreDetail *object=_estore[0];
    //set up image
    NSString*url=[NSString stringWithFormat:@"http://hotmeal.vn/gallery/0/resources/l_%@",object.image];
    NSURL * imageURL = [NSURL URLWithString:url];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    [self.imgView setImage:image];
    [self.txtName setText:object.vn_name];
    [self.txtDescription setText:object.vn_description];
   
}
-(void)getDataOrderAddress:(NSArray *)data{
    _orderaddress=data;
}
-(void)getDataOrderAddressFailed:(NSError *)error{
    NSLog(@"Loi orderaddress: %@",[error description]);
}
-(void)getDataProductCate:(NSArray *)data{
    _proCate=data;
    
}
-(void)getDataProduct:(NSArray *)data{
    _product=data;
    [self.productView reloadData];
}
-(void)getData:(NSArray*)data{
    _estore=data;
    [self displayData];
}
-(void)getDataProductCateFailed:(NSError *)error{
    NSLog(@"%@",error);
}
-(void)getDataProductFailed:(NSError *)error{
    NSLog(@"%@",error);
}
-(void)getDataFailed:(NSError *)error{
    NSLog(@"%@",error);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_product count];
}

/*
-(NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    productCategory *prCate=[_proCate objectAtIndex:section];
    return prCate.name;
}
 */
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	    ProductCell *cell=[self.productView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

       [cell.btn viewWithTag:1];
    [cell.btn addTarget:self action:@selector(CartTapped:) forControlEvents:UIControlEventTouchUpInside];
    product *object=_product[indexPath.row];
    //[idEstore addObject:object.id];
    [cell.nameProduct setText:object.name];
    if(status==0){
        [cell.btn setHidden:TRUE];
    }
    [cell.price setText:[NSString stringWithFormat:@"%@ VND",[functions convertFromNumberToString:[object.price doubleValue]]]];
    
    //set up image
    cell.imageProduct.image = nil;
    NSString*url=[NSString stringWithFormat:@"http://hotmeal.vn/uploads/%@/products/a_%@",object.store_id,object.image];
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //EstoreCell *updateCell=[self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                    cell.imageProduct.image = image;
                });
            }
        }
    });

	[cell.btn setTitle:[NSString stringWithFormat:@"%i",indexPath.row] forState:UIControlStateDisabled];
    return cell;
}
- (void)CartTapped:(UIButton*)sender{
    
	// access the row number using the used trick
	NSUInteger index = [[sender titleForState:UIControlStateDisabled] integerValue];
    NSLog(@"%d",index);
    BOOL flag=TRUE;
	// create indexpath
	NSIndexPath *ip = [NSIndexPath indexPathForRow:index inSection:0];
	product *object=_product[ip.row];
    if(self.productInCart.count>0){
    for (NSInteger i=0; i<self.productInCart.count; i++) {
            cart *cr1=[[cart alloc]init];
            cr1=self.productInCart[i];
        if (cr1.id==object.id) {
            //Neu co roi thi cong them so luong va gia tien.
            cr1.quantity +=1;
            NSInteger _price=[cr1.price doubleValue];
            NSInteger _total = _price*cr1.quantity;
            cr1.total=_total;
            self.totalCart +=[object.price doubleValue];
            NSLog(@"%d",cr1.quantity);
            flag=false;
            [self addToCartTapped:ip];
        }
        
    }
        //neu chua co trong cart thi add moi
        if(flag){
            
                cart *cr=[[cart alloc]init];
                [cr setId:object.id];
                [cr setQuantity:1];
                [cr setPrice:object.price];
                [cr setName:object.name];
                [cr setTotal:[object.price doubleValue]];
                self.totalCart +=[object.price doubleValue];
                [cr setStore_id:object.store_id];
                [self.productInCart addObject:cr];
                [self addToCartTapped:ip];
                [self reloadBadgeNumber];
            
        }
    }else{
    //add to array Cart
    cart *cr=[[cart alloc]init];
    [cr setId:object.id];
    [cr setQuantity:1];
    [cr setPrice:object.price];
    [cr setName:object.name];
    [cr setTotal:[object.price doubleValue]];
    [cr setStore_id:object.store_id];
    self.totalCart=[object.price doubleValue];
    [self.productInCart addObject:cr];
    [self addToCartTapped:ip];
    [self reloadBadgeNumber];
    }
    //send data to scv controller
    
}

- (void)addToCartTapped:(NSIndexPath*)indexPath {
    //ProductCell *cell=[self.productView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	// grab the cell using indexpath
	UITableViewCell *cell = [self.productView cellForRowAtIndexPath:indexPath];
	// grab the imageview using cell
	//UIImageView *imgV = cell.imageProduct;
    UIImageView *imgV = (UIImageView*)[cell viewWithTag:10];
	// get the exact location of image
	CGRect rect = [imgV.superview convertRect:imgV.frame fromView:nil];
	rect = CGRectMake(50, (rect.origin.y*-1)+50, imgV.frame.size.width, imgV.frame.size.height);
	//NSLog(@"rect is %f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
	
	// create new duplicate image
	UIImageView *starView = [[UIImageView alloc] initWithImage:imgV.image];
    [starView setFrame:rect];
	starView.layer.cornerRadius=5;
	//starView.layer.borderColor=[[UIColor blackColor]CGColor];
	//starView.layer.borderWidth=0;
    [self.view addSubview:starView];
	
	// begin ---- apply position animation
	CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration=0.65;
	pathAnimation.delegate=self;
	
	// tab-bar right side item frame-point = end point
	CGPoint endPoint = CGPointMake(210+rect.size.width/2, 390+rect.size.height/2);
	
	CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, starView.frame.origin.x, starView.frame.origin.y);
    CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, starView.frame.origin.y, endPoint.x, starView.frame.origin.y, endPoint.x, endPoint.y);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
	// end ---- apply position animation
	
	// apply transform animation
	CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform"];
	[basic setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.25, 0.25, 0.25)]];
	[basic setAutoreverses:NO];
	[basic setDuration:0.65];
	
	[starView.layer addAnimation:pathAnimation forKey:@"curveAnimation"];
	[starView.layer addAnimation:basic forKey:@"transform"];
	
	[starView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.65];
	[self performSelector:@selector(reloadBadgeNumber) withObject:nil afterDelay:0.65];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// update the Badge number
- (void)reloadBadgeNumber {
    	if([self.productInCart count]) {
        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%i",self.productInCart.count]];
	} else {
		        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:nil];
	}
}
- (void)dealloc {
    [productView release];
    [super dealloc];
}

@end
