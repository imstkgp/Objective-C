
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(0, 50, 320, 250);
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.image=[UIImage imageNamed:@"technews.jpg"];
    imageView.clipsToBounds=YES;
    imageView.layer.borderWidth=1;
    [self.view addSubview:imageView];
    
    UIButton *shareFacebook=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [shareFacebook setTitle:@"Share on Facebook" forState:UIControlStateNormal];
    [shareFacebook setBackgroundColor:[UIColor blueColor]];
    [shareFacebook setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareFacebook.titleLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
    [shareFacebook setFrame:CGRectMake(self.view.center.x-100, 350, 200, 40)];
    [shareFacebook addTarget:self action:@selector(shareOnFacebook) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:shareFacebook];
    
}

- (void)shareOnFacebook {
    if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        alert=nil;
        alert = [[UIAlertView alloc] initWithTitle:@"Unable to Post!" message:@"Please login to Facebook in your device settings." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    SLComposeViewController* mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [mySLComposerSheet setInitialText:@"My Facebook share Image"];
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
        alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
