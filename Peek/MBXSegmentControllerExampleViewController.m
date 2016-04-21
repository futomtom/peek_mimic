

#import "MBXSegmentControllerExampleViewController.h"
@import MBXPageViewController;
#import "Peek-Swift.h"

@interface MBXSegmentControllerExampleViewController () <MBXPageControllerDataSource, MBXPageControllerDataDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) MBXPageViewController* MBXPageController;

@end

@implementation MBXSegmentControllerExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initiate MBXPageController
    self.MBXPageController = [MBXPageViewController new];
    self.MBXPageController.MBXDataSource = self;
    self.MBXPageController.MBXDataDelegate = self;
    self.MBXPageController.pageMode = MBX_SegmentController;
    [self.MBXPageController reloadPages];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]} ;
    

}

- (IBAction)goToThirdView:(id)sender {
    
    [self.MBXPageController moveToViewNumber:2 animated:true];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"San Francisco";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    navigationController?.navigationBar.shadowImage = UIImage()
//    navigationController?.navigationBar.translucent = true
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.title = @"";
    
}


#pragma mark - MBXPageViewController Data Source

- (NSArray *)MBXPageButtons
{
    return @[self.segmentController];
}

- (UIView *)MBXPageContainer
{
    return self.containerView;
}

- (NSArray *)MBXPageControllers
{
    // You can Load a VC directly from Storyboard
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    KittensCollectionViewController *demo  = [mainStoryboard instantiateViewControllerWithIdentifier:@"KittenVC"];
    KittensCollectionViewController *demo2  = [mainStoryboard instantiateViewControllerWithIdentifier:@"KittenVC"];
    demo2.normalMmode = 1;
    
    // The order matters.
    return @[demo,demo2];
}



#pragma mark - MBXPageViewController Delegate

- (void)MBXPageChangedToIndex:(NSInteger)index
{
    NSLog(@"%@ %ld", [self class], (long)index);
}

@end
