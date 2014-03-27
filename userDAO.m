//
//  userDAO.m
//  AppHotmeal
//
//  Created by admin on 3/19/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "userDAO.h"
#import "user.h"
#import "staticConfig.h"
@implementation userDAO
@synthesize db;
//get user from sqlite
-(NSMutableArray*)getUser{
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    @try {
        NSString*path=[self connectDB];
        if(path==NULL){
            NSLog(@"cannot locate database file");
        }
if(!(sqlite3_open([path UTF8String], &db)==SQLITE_OK)){
    NSLog(@"An error has occured.");
}
const char *sql = "select id,fullname,cell,email,address,id_area,date_create from user";
sqlite3_stmt*sqlStatement;
if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL)!=SQLITE_OK){
    NSLog(@"Problem with prepare statement");
}
while(sqlite3_step(sqlStatement)==SQLITE_ROW){
    user*_user =[[user alloc]init];
    _user.id=sqlite3_column_int(sqlStatement, 0);
    _user.fullname=[NSString stringWithUTF8String:(char*)sqlite3_column_text(sqlStatement, 1)];
    _user.name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(sqlStatement, 2)];
    _user.email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(sqlStatement, 3)];
    _user.address=[NSString stringWithUTF8String:(char*)sqlite3_column_text(sqlStatement, 4)];
    [userArray addObject:_user];
    //NSLog(@"%@",[NSString stringWithUTF8String:(char*)sqlite3_column_text(sqlStatement, 1)]);
    
}
        [self closeDB:sqlStatement db:db];
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        return userArray;
    }
}

//insert user into table user - hotmeal.sqlite
-(BOOL)AddUser:(user *)object{
    BOOL flag=FALSE;
    NSString*path=[self connectDB];
    if(path==NULL){
        NSLog(@"cannot locate database file");
    }
    NSLog(@"%@",path);
    if(!(sqlite3_open([path UTF8String], &db)==SQLITE_OK)){
        NSLog(@"An error has occured.");
    }
    NSString *insertSQL = [NSString stringWithFormat:
                           @"INSERT INTO user (fullname,cell,email,address) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                           object.fullname, object.name, object.email,object.address];
    NSLog(@"%@",insertSQL);
    const char *sql = [insertSQL UTF8String];
    sqlite3_stmt*sqlStatement;
    sqlite3_prepare_v2(db, sql,
                       -1, &sqlStatement, NULL);
    if (sqlite3_step(sqlStatement) == SQLITE_DONE)
    {
        NSLog(@"insert ok roi do");
        flag=TRUE;
    }
    [self closeDB:sqlStatement db:db];
    return flag;
}

-(BOOL)ChangeUser:(user *)object{
    /*
    NSString*path=[self connectDB];
    if(path==NULL){
        NSLog(@"cannot locate database file");
    }
    if(!(sqlite3_open([path UTF8String], &db)==SQLITE_OK)){
        NSLog(@"An error has occured.");
    }
    NSString *deleteSQL = [NSString stringWithFormat:
                           @"delete from user where cell=\"%@\"",
                           object.fullname, object.name, object.email,object.address];
    NSLog(@"%@",insertSQL);
    const char *sql = [insertSQL UTF8String];
    sqlite3_stmt*sqlStatement;
    */
    return TRUE;
}

-(BOOL)DeleteUser:(NSString *)condition{
    BOOL flag =FALSE;
    NSString*path=[self connectDB];
    if(path==NULL){
        NSLog(@"cannot locate database file");
    }
    if(!(sqlite3_open([path UTF8String], &db)==SQLITE_OK)){
        NSLog(@"An error has occured.");
    }
    if (condition==NULL) {
        condition=@"(1>0)";
    }
    NSString *deleteSQL = [NSString stringWithFormat:
                           @"delete from user where %@",
                           condition];
    NSLog(@"%@",deleteSQL);
    const char *sql = [deleteSQL UTF8String];
    sqlite3_stmt*sqlStatement;
    sqlite3_prepare_v2(db, sql,
                       -1, &sqlStatement, NULL);
    if (sqlite3_step(sqlStatement) == SQLITE_DONE)
    {
        NSLog(@"delete ok roi do");
        flag=TRUE;
    }
    [self closeDB:sqlStatement db:db];
    return flag;
}
-(BOOL)isUser{
    NSArray*user=[self getUser];
    if(user.count>0)
        return TRUE;
    return FALSE;
}
-(NSString*)connectDB{
    NSFileManager*fmg=[NSFileManager defaultManager];
    NSString*dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:DATABASE];
    BOOL success=[fmg fileExistsAtPath:dbPath];
    if(success)return dbPath;
    return NULL;
}
-(void)closeDB:(sqlite3_stmt*)statement db:(sqlite3*)_db{
    sqlite3_finalize(statement);
    sqlite3_close(_db);
}
@end
