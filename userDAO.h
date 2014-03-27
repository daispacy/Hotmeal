//
//  userDAO.h
//  AppHotmeal
//
//  Created by admin on 3/19/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "user.h"
@interface userDAO : NSObject{
    sqlite3*db;
}
@property(assign,nonatomic)sqlite3*db;
-(NSMutableArray*)getUser;
-(BOOL)AddUser:(user*)object;
-(BOOL)ChangeUser:(user*)object;
-(BOOL)DeleteUser:(NSString*)condition;
-(BOOL)isUser;
@end
