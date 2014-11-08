#import "ViewController.h"
#import "TTTAttributedLabel.h"
@interface ViewController ()

@end

@implementation ViewController
{
    UITextField *loc;
    TTTAttributedLabel *data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    UIImage *background = [UIImage imageNamed: @"myback.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
//    
//    [self.view addSubview: imageView];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 80, 25) ];
    [lbl setText:@"Text:"];
    [lbl setFont:[UIFont fontWithName:@"Verdana" size:16]];
    [lbl setTextColor:[UIColor grayColor]];
    loc=[[UITextField alloc] initWithFrame:CGRectMake(4, 20, 300, 30)];
    //loc.backgroundColor = [UIColor grayColor];
    loc.borderStyle=UITextBorderStyleRoundedRect;
    loc.clearButtonMode=UITextFieldViewModeWhileEditing;
    //[loc setText:@"Enter Location"];
    loc.clearsOnInsertion = YES;
    loc.leftView=lbl;
    loc.leftViewMode=UITextFieldViewModeAlways;
    [loc setDelegate:self];
    [self.view addSubview:loc];
    [loc setRightViewMode:UITextFieldViewModeAlways];
    CGRect frameimg = CGRectMake(110, 70, 70,30);
    UIButton *srchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    srchButton.frame=frameimg;
    [srchButton setTitle:@"Go" forState:UIControlStateNormal];
    [srchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    srchButton.backgroundColor=[UIColor clearColor];
    [srchButton addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:srchButton];
    data = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(5, 120,self.view.frame.size.width,200) ];
    [data setFont:[UIFont fontWithName:@"Verdana" size:16]];
    [data setTextColor:[UIColor blackColor]];
    data.numberOfLines=0;
     data.delegate = self;
    data.enabledTextCheckingTypes=NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber;
    [self.view addSubview:data];
}
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    NSString *val=[[NSString alloc]initWithFormat:@"%@",url];
    if ([[url scheme] hasPrefix:@"mailto"]) {
              NSLog(@" mail URL Selected : %@",url);
        MFMailComposeViewController *comp=[[MFMailComposeViewController alloc]init];
        [comp setMailComposeDelegate:self];
        if([MFMailComposeViewController canSendMail])
        {
            NSString *recp=[[val substringToIndex:[val length]] substringFromIndex:7];
            NSLog(@"Recept : %@",recp);
            [comp setToRecipients:[NSArray arrayWithObjects:recp, nil]];
            [comp setSubject:@"From my app"];
            [comp setMessageBody:@"Hello bro" isHTML:NO];
            [comp setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:comp animated:YES completion:nil];
        }

    }
    else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:val]];
    }
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if(error)
    {
        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Erorr" message:@"Some error occureed" delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
        [alrt show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    NSLog(@"Phone Number Selected : %@",phoneNumber);
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
    }
}
-(void)go:(id)sender
{
    [data setText:loc.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Reached");
    [loc resignFirstResponder];
}

@end
