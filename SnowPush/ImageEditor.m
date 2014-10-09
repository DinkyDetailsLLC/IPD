#import "ImageEditorViewController+Private.h"
#import "ImageEditor.h"

@interface ImageEditor ()

@end

@implementation ImageEditor

@synthesize  saveButton = _saveButton;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.cropRect = CGRectMake(0,0,150,140);
        self.minimumScale = 0.2;
        self.maximumScale = 10;
    }
    return self;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.saveButton = nil;
}



- (IBAction)setSquareAction:(id)sender
{
    self.cropRect = CGRectMake((self.frameView.frame.size.width-150)/2.0f, (self.frameView.frame.size.height-140)/2.0f, 150, 140);
    [self reset:YES];
}

- (IBAction)setLandscapeAction:(id)sender
{
    self.cropRect = CGRectMake((self.frameView.frame.size.width-150)/2.0f, (self.frameView.frame.size.height-140)/2.0f, 150, 140);
    [self reset:YES];
}


- (IBAction)setLPortraitAction:(id)sender
{
    self.cropRect = CGRectMake((self.frameView.frame.size.width-140)/2.0f, (self.frameView.frame.size.height-150)/2.0f, 140, 150);
    [self reset:YES];
}

#pragma mark Hooks
- (void)startTransformHook
{
    self.saveButton.tintColor = [UIColor colorWithRed:0 green:49/255.0f blue:98/255.0f alpha:1];
}

- (void)endTransformHook
{
    self.saveButton.tintColor = [UIColor colorWithRed:0 green:128/255.0f blue:1 alpha:1];
}


@end
