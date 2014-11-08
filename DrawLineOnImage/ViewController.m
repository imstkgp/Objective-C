
#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *imageView;
    float redVal, greenVal, blueVal;
    CGPoint startPoint;
    UIScrollView *customEffectScrollView;
    UIPageControl *pageControl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    redVal=255.0;
    greenVal=0.0;
    blueVal=0.0;

    imageView=[[UIImageView alloc]init];
    imageView.image=[UIImage imageNamed:@"technews.jpg"];
    imageView.frame=CGRectMake(0, 50, 320, 320);
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.backgroundColor=[UIColor greenColor];
    //imageView.clipsToBounds=YES;
    [self.view addSubview:imageView];
    
    [self addCustomScrollView:4];
}

#pragma mark Draw Line Button Action

- (void)addCustomScrollView:(int)itemCount {
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
            customEffectScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height+20, 322,75)];
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
            UIImageView *colorImageView=[[UIImageView alloc]init];
            colorImageView.tag=i;
            [colorImageView setUserInteractionEnabled:YES];
            [customEffectScrollView addSubview:colorImageView];
            UITapGestureRecognizer *scrollImageTap=[[UITapGestureRecognizer alloc]init];
            [colorImageView addGestureRecognizer:scrollImageTap];
            [scrollImageTap addTarget:self action:@selector(scrollImageTapped:)];
            customEffectScrollView.backgroundColor=[UIColor whiteColor];
            colorImageView.frame=CGRectMake(10+(i*(customEffectScrollView.frame.size.width/4-5)), 0, customEffectScrollView.frame.size.width/4-5, customEffectScrollView.frame.size.height);
            switch (i) {
                case 0:
                    colorImageView.backgroundColor=[UIColor redColor];
                    break;
                    
                case 1:
                    colorImageView.backgroundColor=[UIColor blackColor];
                    break;
                    
                case 2:
                    colorImageView.backgroundColor=[UIColor greenColor];
                    break;
                    
                case 3:
                    colorImageView.backgroundColor=[UIColor blueColor];
                    break;
                default:
                    break;
            }
        }
        [self.view addSubview:customEffectScrollView];
        [self.view addSubview:pageControl];
    }
}

- (void)scrollImageTapped:(UITapGestureRecognizer *)gestureRecognizer {
    UIImageView *tapImage = (UIImageView*)gestureRecognizer.view;
    //NSLog(@"%ld",tapImage.tag);
    switch (tapImage.tag) {
        case 0:
        {
            redVal=255.0;
            greenVal=0.0;
            blueVal=0.0;
            break;
        }
        case 1:
        {
            redVal=0.0;
            greenVal=0.0;
            blueVal=0.0;
            break;
        }
        case 2:
        {
            redVal=0.0;
            greenVal=255.0;
            blueVal=0.0;
            break;
        }
        case 3:
        {
            redVal=0.0;
            greenVal=0.0;
            blueVal=255.0;
            break;
        }
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:imageView];
    startPoint = p;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesMoved");
     UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:imageView];
    [self drawLineFrom:startPoint endPoint:p];
    startPoint = p;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

-(void)drawLineFrom:(CGPoint)from endPoint:(CGPoint)to {
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        
    [[UIColor colorWithRed:redVal/255.0 green:greenVal/255.0 blue:blueVal/255.0 alpha:1.0] set];
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0f);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), from.x, from.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), to.x , to.y);
        
    CGContextStrokePath(UIGraphicsGetCurrentContext());
        
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
