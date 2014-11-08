

#import "ViewController.h"
#import <Social/Social.h>
@interface ViewController ()
{
    UIAlertView *alert;
    UIImageView *imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(0, 50, 320, 250);
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.image=[UIImage imageNamed:@"technews.jpg"];
    imageView.clipsToBounds=YES;
    imageView.layer.borderWidth=1;
    [self.view addSubview:imageView];
    
    UIButton *shareTwitter=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [shareTwitter setTitle:@"Share on Twitter" forState:UIControlStateNormal];
    [shareTwitter setBackgroundColor:[UIColor blueColor]];
    [shareTwitter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareTwitter.titleLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
    [shareTwitter setFrame:CGRectMake(self.view.center.x-100, 350, 200, 40)];
    [shareTwitter addTarget:self action:@selector(shareOnTwitter) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:shareTwitter];
}

- (void)shareOnTwitter{
    if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        alert=nil;
        alert = [[UIAlertView alloc] initWithTitle:@"Unable to Tweet!" message:@"Please login to Twitter in your device settings." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    SLComposeViewController* mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [mySLComposerSheet setInitialText:@"My Twitter share Image"];
    [mySLComposerSheet addImage:imageView.image];
    [mySLComposerSheet addURL:[NSURL URLWithString:@"http://click-labs.com/"]];
    [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Post Cancelled.";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull.";
                break;
            default:
                break;
        }
        alert=nil;
        alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
