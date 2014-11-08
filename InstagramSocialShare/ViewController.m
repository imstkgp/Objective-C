

#import "ViewController.h"

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
    
    UIButton *shareInstagram=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [shareInstagram setTitle:@"Share on Instagram" forState:UIControlStateNormal];
    [shareInstagram setBackgroundColor:[UIColor blueColor]];
    [shareInstagram setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareInstagram.titleLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
    [shareInstagram setFrame:CGRectMake(self.view.center.x-100, 350, 200, 40)];
    [shareInstagram addTarget:self action:@selector(shareOnInstagram) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:shareInstagram];
}

- (void)shareOnInstagram{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://"];
    
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        CGRect rect = CGRectMake(0,0,0,0);
        NSString *jpgPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Image_1_instgram.igo"];
        [UIImagePNGRepresentation(imageView.image) writeToFile:jpgPath atomically:YES];
        NSURL *igImageHookFile = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"file://%@",jpgPath]];
        self.docFile.UTI = @"com.instagram.exclusivegram";
        self.docFile = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
        self.docFile.annotation = [NSDictionary dictionaryWithObject:@"My Instagram Share" forKey:@"InstagramCaption"];
        [self.docFile presentOpenInMenuFromRect: rect inView: self.view animated: YES ];
    }
    else
    {
        alert=nil;
        alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Instagram not installed in this device!\nTo share image please install instagram." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
}

- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
