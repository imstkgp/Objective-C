

#import "ViewController.h"

@interface ViewController ()
{
    UIScrollView *imageScroll;
    UIImageView *imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    imageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    imageScroll.delegate=self;
    imageScroll.userInteractionEnabled=YES;
    imageScroll.minimumZoomScale=1.0f;
    imageScroll.maximumZoomScale=5.0f;
    imageScroll.backgroundColor=[UIColor blackColor];
    imageScroll.scrollEnabled=YES;
    
    imageView=[[UIImageView alloc]init];
    imageView.image=[UIImage imageNamed:@"technews.jpg"];
    imageView.frame=CGRectMake(0, 0, 320, 320);
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.backgroundColor=[UIColor greenColor];
    //imageView.clipsToBounds=YES;
    [imageScroll addSubview:imageView];
    
    [self.view addSubview:imageScroll];
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
