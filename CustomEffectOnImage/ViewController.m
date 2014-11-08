
#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *mainImageView;
    NSArray *filterName;
    UIImage *thumbImage;
    NSMutableArray *customImageArray;
    UIScrollView *customEffectScrollView;
    UIPageControl *pageControl;
    UIImage *mainImage;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    mainImageView=[[UIImageView alloc]init];
    mainImageView.frame=CGRectMake(0, 50, 320, 250);
    mainImage=[UIImage imageNamed:@"technews.jpg"];
    mainImageView.image=mainImage;
    mainImageView.clipsToBounds=YES;
    [self.view addSubview:mainImageView];
    
    //Filter name array with initial filter images
    filterName=[[NSArray alloc]initWithObjects:@"CIPhotoEffectChrome",@"CIPhotoEffectFade",@"CIPhotoEffectInstant",@"CIPhotoEffectMono", @"CIPhotoEffectNoir",@"CIPhotoEffectProcess",@"CIPhotoEffectTonal",@"CIPhotoEffectTransfer", nil];
    
    thumbImage=[self imageWithImage:mainImageView.image scaledToSize:CGSizeMake(80, 80)];
    customImageArray=[[NSMutableArray alloc]init];
    for(int i=0;i<filterName.count;i++) {
        CIImage *inputImage = [CIImage imageWithCGImage:[thumbImage CGImage]];
        CIFilter *filter = [CIFilter filterWithName:[filterName objectAtIndex:i]];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        [customImageArray addObject:[UIImage imageWithCIImage:filter.outputImage]];
    }
    [self addCustomScrollView:customImageArray.count];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)addCustomScrollView:(int) itemCount {
    @autoreleasepool {
        [customEffectScrollView removeFromSuperview];
        [pageControl removeFromSuperview];
        
        customEffectScrollView=nil;
        customEffectScrollView=[[UIScrollView alloc]init];
        int gapBetweenImages = 2;
        int scrollViewContentwidth, imageviewWidthAndHeight;
        pageControl=nil;
        pageControl = [[UIPageControl alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone||UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            imageviewWidthAndHeight = (322/4 - 1*gapBetweenImages);
            scrollViewContentwidth = itemCount * (imageviewWidthAndHeight +gapBetweenImages);
            pageControl.frame=CGRectMake(60, 370, 200, 30);
            customEffectScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mainImageView.frame.origin.y+mainImageView.frame.size.height+20, 322,75)];
            customEffectScrollView.contentSize = CGSizeMake(customEffectScrollView.contentSize.width,customEffectScrollView.frame.size.height);
            [customEffectScrollView setContentSize:CGSizeMake(scrollViewContentwidth, 75)];
        }
        
        customEffectScrollView.showsHorizontalScrollIndicator=NO;
        customEffectScrollView.userInteractionEnabled = YES;
        customEffectScrollView.delegate=self;
        customEffectScrollView.backgroundColor=[UIColor clearColor];
        [customEffectScrollView setPagingEnabled:YES];
        
        pageControl.numberOfPages = customEffectScrollView.contentSize.width/customEffectScrollView.frame.size.width;
        pageControl.numberOfPages =itemCount;
        pageControl.backgroundColor=[UIColor clearColor];
        pageControl.hidden=YES;
        
        for (int i = 0; i != itemCount; i++) {
            UIImageView *imageView=[[UIImageView alloc]init];
            imageView.tag=i;
            [imageView setUserInteractionEnabled:YES];
            imageView.frame=CGRectMake((i*(customEffectScrollView.frame.size.width/4)), 0, customEffectScrollView.frame.size.width/4, customEffectScrollView.frame.size.height);
            [customEffectScrollView addSubview:imageView];
            UITapGestureRecognizer *scrollImageTap=[[UITapGestureRecognizer alloc]init];
            [imageView addGestureRecognizer:scrollImageTap];
            [scrollImageTap addTarget:self action:@selector(customImageTapped:)];
            imageView.image =(UIImage *)[customImageArray objectAtIndex:i];
        }
        
        [self.view addSubview:customEffectScrollView];
        [self.view addSubview:pageControl];
    }
}

- (void)customImageTapped:(UITapGestureRecognizer *)gestureRecognizer {
    UIImageView *tapImage = (UIImageView*)gestureRecognizer.view;
    CIImage *inputImage = [CIImage imageWithCGImage:[mainImage CGImage]];
    CIFilter *filter = [CIFilter filterWithName:[filterName objectAtIndex:tapImage.tag]];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    mainImageView.image =[UIImage imageWithCIImage:filter.outputImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
