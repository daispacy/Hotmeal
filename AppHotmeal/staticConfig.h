//
//  staticConfig.h
//  AppHotmeal
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
//Hieu ung popup
static const int ANIMATE=3;

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

//define connect to server
#define API @"87banhvantran"
#define HOST @"http://hotmeal.vn/iosgate.php?"
#define OPLOGIN @"login"
#define OPPAYMENT @"payment"
#define OPREGISTER @"register"
#define OPFEEDELIVERY @"feedelivery"
#define OPORDER @"order"
#define OPPRODUCTCATEGORIES @"productcategories"
#define OPESTOREDETAIL @"estoredetail"
#define OPESTORECATEGORIES @"estorecategories"
#define OPAREA @"area"
#define OPLISTING @"listing"
#define OPPRODUCTS @"products"
#define OPREGISTER @"register"
#define OPREGISTER @"register"
#define DATABASE @"hotmeal.sqlite"
#define URLPATHIMGESTORE @"http://hotmeal.vn/gallery/0/resources/a_"

@interface staticConfig : NSObject

@end
