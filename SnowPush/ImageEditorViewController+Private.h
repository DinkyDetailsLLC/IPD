#import "ImageEditorViewController.h"

@interface ImageEditorViewController (Private)

@property (nonatomic,retain) IBOutlet UIView<HFImageEditorFrame> *frameView;

- (void)startTransformHook;
- (void)endTransformHook;

@end


