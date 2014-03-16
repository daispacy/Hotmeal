//
//  RegisterViewController.m
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "RegisterViewController.h"
#import "AlertViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "user.h"
#import "userManager.h"
#import "userConnect.h"

#define API @"87banhvantran"
#define HOST @"http://hotmeal.vn/iosgate.php?"
#define OPREGISTER @"register"

@interface RegisterViewController ()<userManagerDelegate,AlertViewDelegate>{
    NSArray*_user;
    userManager*_userManager;
}

@end

@implementation RegisterViewController
@synthesize delegate;
@synthesize txtaddress;
@synthesize txtemail;
@synthesize txtpassword;
@synthesize txtrepassword;
@synthesize txtphone;
@synthesize _alertViewController;
@synthesize message;
@synthesize control;
@synthesize txtfullname;

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
    _userManager=[[userManager alloc]init];
    _userManager.userConnect=[[userConnect alloc]init];
    _userManager.userConnect.delegate=_userManager;
    _userManager.delegate=self;
    [self.txtfullname becomeFirstResponder];
}
-(void)getDataUser:(NSArray *)data{
    _user=data;
    user*object=_user[0];
    if([object.error isEqualToString:@"FALSE"]){
        NSLog(@"call delegate to process cart");
        [self.delegate returnUserRegister:self user:object];
    }else{
        [self alert:object.message];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self._alertViewController=[[AlertViewController alloc] initWithNibName:@"AlertViewController" bundle:nil];
    self._alertViewController.delegate=self;
}
-(void)getDataUserFailed:(NSError *)error{
    NSLog(@"Loi get user: %@",[error description]);
}
-(void)alert:(NSString*)ms{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thông báo" message:ms delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show]; [alert release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [txtphone release];
    [txtpassword release];
    [txtrepassword release];
    [txtemail release];
    [txtaddress release];
    [txtfullname release];
    [super dealloc];
}
- (IBAction)process:(id)sender {
    NSString*post=[NSString stringWithFormat:@"apikey=%@&op=%@&fullname=%@&phone=%@&password=%@&email=%@&address=%@",API,OPREGISTER,self.txtfullname.text,self.txtphone.text,self.txtpassword.text,self.txtemail.text,self.txtaddress.text];
    [_userManager registerUser:post];
}

- (IBAction)checkEmail:(id)sender {
    if (![self validateEmail:self.txtemail.text])
    {
        NSLog(@"email not in proper format");
        self.control=2;
        [self alert:@"Email không hợp lệ"];
    }
}

- (IBAction)checkPassword:(id)sender {
    NSLog(@"%@",[NSString stringWithFormat:@"%@-%@",self.txtpassword.text,self.txtrepassword.text]);
    if(![self.txtrepassword.text isEqualToString:self.txtpassword.text]){
        NSLog(@"password not match");
        self.message=@"Mật khẩu không trùng khớp";
        self.control=1;
        [self alert:self.message];
        //[self presentPopupViewController:self._alertViewController animationType:1];
    }
    
}
-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
            NSLog(@"click vao day roi");
        if (control==1) {
            [self.txtrepassword becomeFirstResponder];
        } else if(control==2) {
            [self.txtemail becomeFirstResponder];
        } else if (control==3){
            [self.txtphone becomeFirstResponder];
        }else if (control==4){
            [self.txtaddress becomeFirstResponder];
        }
    
    }

}
-(NSString*)setAlert:(AlertViewController *)controller{
    return self.message;
}

- (BOOL)validateEmail:(NSString *)inputText {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSRange aRange;
    if([emailTest evaluateWithObject:inputText]) {
        aRange = [inputText rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [inputText length])];
        int indexOfDot = aRange.location;
        //NSLog(@"aRange.location:%d - %d",aRange.location, indexOfDot);
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [inputText substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            //NSLog(@"topleveldomains:%@",topLevelDomain);
            NSSet *TLD;
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                //NSLog(@"TLD contains topLevelDomain:%@",topLevelDomain);
                return TRUE;
            }
            /*else {
             NSLog(@"TLD DOEST NOT contains topLevelDomain:%@",topLevelDomain);
             }*/
            
        }
    }
    return FALSE;
}
-(BOOL)TextIsValidValue:(NSString*) newText
{
    NSCharacterSet *numberSet = [NSCharacterSet characterSetWithRange:NSMakeRange('0',10)];
    NSString *trimmed = [newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSRange matchRange = [trimmed rangeOfCharacterFromSet:numberSet];
    BOOL isNumeric = matchRange.location == 0 && matchRange.length == trimmed.length && trimmed.length > 0;
    return isNumeric;
}
- (IBAction)checkPhone:(id)sender {
    if([self TextIsValidValue:self.txtphone.text]){
        [self alert:@"Số điện thoại không hợp lệ"];
        control=3;
        [self.txtphone becomeFirstResponder];
    }
}
- (IBAction)checkAddress:(id)sender {
    if(self.txtaddress.text.length==0){
        [self alert:@"Vui lòng cung cấp địa chỉ"];
        control=4;
    }
}

@end
