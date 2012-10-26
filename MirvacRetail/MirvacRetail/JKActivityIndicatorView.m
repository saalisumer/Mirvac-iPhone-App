#import "JKActivityIndicatorView.h"

#import <QuartzCore/QuartzCore.h>

#define kDimmedOpacity .3f

@interface JKActivityIndicatorView ()

@property(nonatomic, assign, getter=didConfigurationChange) BOOL configurationChanged;
@property(nonatomic, assign, getter=didNumberOfLinesChange) BOOL numberOfLinesChanged;

/* Array of calayers, representing lines */
@property(nonatomic, retain) NSArray *lines;

- (void) setupDefaults;

/*! Configures all layers to display a indicator view. */
- (void) configureIndicator;

/*! Method to indicate the configuration has changed and needs updating. Multiple calls
 * will only perform one configuration. Updating multiple properties will thus only 
 * reconfigure the indicator once
 */
- (void) setNeedsConfiguration;

- (void) applyStylesToLine:(CALayer *)line;

@end


@implementation JKActivityIndicatorView

/* Public properties */
@synthesize numberOfLines, lineLength, lineWidth, radius, trail, speed, isAnimating;

/* Private properties */
@synthesize configurationChanged, numberOfLinesChanged, lines;

// MARK: - View management

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupDefaults];
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupDefaults];
    }
    
    return self;
}

- (void) dealloc {
    self.lines = nil;
    [NSThread cancelPreviousPerformRequestsWithTarget:self];
    
    [super dealloc];
}


// MARK: - Configuration

- (void) setupDefaults {
    self.backgroundColor = [UIColor clearColor];
    
    self.numberOfLines = 8;
    self.lineLength = 15.0f;
    self.lineWidth = 6.0f;
    self.radius = 8.0f;
    self.trail = 1.0;
    self.speed = 1.0;
    
    isAnimating = NO;
}

- (void) configureIndicator {
    NSLog(@"%s", __func__);
    
    if (self.didNumberOfLinesChange) {
        // recreate lines
        
        for (CALayer *l in self.lines) {
            [l removeFromSuperlayer];
        }
        
        NSMutableArray *newLines = [NSMutableArray array];
        for (NSInteger i=0; i<self.numberOfLines; i++) {
            CALayer *line = [CALayer layer];
            [self.layer addSublayer:line];
            [newLines addObject:line];
        }
        self.lines = newLines;
    }
    
    // apply styles to lines
    CGFloat currentAngle = - M_PI/2;
    CGFloat angleDelta = (M_PI * 2) / self.numberOfLines;
    
    for (CALayer *line in self.lines) {
        [self applyStylesToLine:line];
        
        line.anchorPoint = CGPointMake(0.0f, 0.5f);
        
        CATransform3D transform = CATransform3DMakeRotation(currentAngle, 0.0f, 0.0f, 1.0f);
        transform = CATransform3DTranslate(transform, self.radius, 0.0f, 0.0f);
        line.transform = transform;
        
        CGFloat opacity = 1.0f - (1.0f - kDimmedOpacity) * MIN(1.0f, (currentAngle / (M_PI*2*self.trail)));
        line.opacity = opacity;
        
        currentAngle += angleDelta;
    }
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 0.8f;
    
    if (self.isAnimating) {
        [self addAnimations];
    }
    
    self.configurationChanged = NO;
}

- (void) applyStylesToLine:(CALayer *)line {
    line.backgroundColor = [UIColor whiteColor].CGColor;
    
    CGSize lineSize = CGSizeMake(self.lineWidth + self.lineLength, self.lineWidth);
    line.frame = (CGRect) {.size=lineSize};
    line.cornerRadius = self.lineWidth / 2;
}

- (void) setNeedsConfiguration {
    if (self.didConfigurationChange) {
        return;
    }
    
    [self performSelector:@selector(configureIndicator) withObject:nil afterDelay:0.0f];
    
    self.configurationChanged = YES;
}

// MARK: - Custom setters

- (void) setNumberOfLines:(NSInteger)newNumberOfLines {
    numberOfLines = newNumberOfLines;
    
    self.numberOfLinesChanged = YES;
    [self setNeedsConfiguration];
}

- (void) setLineLength:(CGFloat)newLength {
    lineLength = newLength;
    
    [self setNeedsConfiguration];
}

- (void) setLineWidth:(CGFloat)newWidth {
    lineWidth = newWidth;
    
    [self setNeedsConfiguration];
}

- (void) setRadius:(CGFloat)newRadius {
    radius = newRadius;
    
    [self setNeedsConfiguration];
}

- (void) setTrail:(CGFloat)newTrail {
    trail = newTrail;
    
    [self setNeedsConfiguration];
}

- (void) setSpeed:(CGFloat)newSpeed {
    speed = newSpeed;
    
    [self setNeedsConfiguration];
}

// MARK: - Layout

- (void) layoutSubviews {
    NSLog(@"%s", __func__);
    
    /*if (self.hasConfigurationChanged) {
        [self configureIndicator];
        self.configurationChanged = NO;
    }*/
    
    for (CALayer *line in self.lines) {
        line.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
}

// MARK: - Animations

- (void) addAnimations {
    CGFloat duration = self.speed;
    NSInteger i =0;
    for (CALayer *line in lines) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anim.duration = duration;
        anim.repeatCount = HUGE_VALF;
        anim.beginTime = /* duration - */ (duration / self.numberOfLines * i);
        anim.fromValue = [NSNumber numberWithFloat:1.0];
        anim.toValue = [NSNumber numberWithFloat:kDimmedOpacity];
        
        [line addAnimation:anim forKey:@"animateOpacity"];
        i++;
    }
}

// MARK: - Public API

- (void) setStyle:(UIActivityIndicatorViewStyle)indicatorStyle {
    
}

- (void) startAnimating {
    isAnimating = YES;
    [self addAnimations];
}

@end