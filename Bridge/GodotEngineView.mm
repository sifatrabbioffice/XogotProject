#import "GodotEngineView.h"
#import <MetalKit/MetalKit.h>

@implementation GodotEngineView {
    MTKView *_metalView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // একটি ডামি Metal ভিউ তৈরি করা হলো, যেখানে পরবর্তীতে Godot ইঞ্জিন রেন্ডার করবে
        _metalView = [[MTKView alloc] initWithFrame:self.bounds device:MTLCreateSystemDefaultDevice()];
        _metalView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _metalView.backgroundColor = [UIColor colorWithRed:0.2 green:0.18 blue:0.15 alpha:1.0]; // Grid কালার
        [self addSubview:_metalView];
    }
    return self;
}

@end
