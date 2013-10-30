/*
 File: EAGLView.m
 Abstract: This class wraps the CAEAGLLayer from CoreAnimation into a convenient
 UIView subclass. The view content is basically an EAGL surface you render your
 OpenGL scene into.  Note that setting the view non-opaque will only work if the
 EAGL surface has an alpha channel.
 
 Version: 1.9
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "SGEAGLView.h"

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

const NSString* panoSufixxes[] = { @"_b", @"_d", @"_f", @"_l", @"_r", @"_u", nil };

@interface SGEAGLView (SGEAGLViewPrivate)

- (BOOL)createFramebuffer;
- (void)destroyFramebuffer;

@end

@interface SGEAGLView (SGEAGLViewSprite)

- (void)setupView;

@end

@implementation SGEAGLView

@synthesize animating;
@dynamic animationFrameInterval;

// You must implement this
+ (Class) layerClass
{
	return [CAEAGLLayer class];
}


//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder
{
	if((self = [super initWithCoder:coder])) {
		// Get the layer
		CAEAGLLayer *eaglLayer = (CAEAGLLayer*) self.layer;
		
		eaglLayer.opaque = YES;
		eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
										[NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		
		if(!context || ![EAGLContext setCurrentContext:context] || ![self createFramebuffer]) {
			[self release];
			return nil;
		}
		
		animating = FALSE;
		displayLinkSupported = FALSE;
		animationFrameInterval = 1;
		displayLink = nil;
		animationTimer = nil;
		
		// A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
		// class is used as fallback when it isn't available.
		NSString *reqSysVer = @"3.1";
		NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
		if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
			displayLinkSupported = TRUE;
		
		verticalStop = 800.0;
		momentumOn = YES;
		momentumX = -37.0;
		
		[self setupView];
		[self drawView];
	}
	
	return self;
}

- (void)layoutSubviews
{
	[EAGLContext setCurrentContext:context];
	[self destroyFramebuffer];
	[self createFramebuffer];
	[self drawView];
}


- (BOOL)createFramebuffer
{
	glGenFramebuffersOES(1, &viewFramebuffer);
	glGenRenderbuffersOES(1, &viewRenderbuffer);
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(id<EAGLDrawable>)self.layer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
	if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
		NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
		return NO;
	}
	
	return YES;
}


- (void)destroyFramebuffer
{
	glDeleteFramebuffersOES(1, &viewFramebuffer);
	viewFramebuffer = 0;
	glDeleteRenderbuffersOES(1, &viewRenderbuffer);
	viewRenderbuffer = 0;
	
	if(depthRenderbuffer) {
		glDeleteRenderbuffersOES(1, &depthRenderbuffer);
		depthRenderbuffer = 0;
	}
}


- (NSInteger) animationFrameInterval
{
	return animationFrameInterval;
}

- (void) setAnimationFrameInterval:(NSInteger)frameInterval
{
	if (frameInterval >= 1)
	{
		animationFrameInterval = frameInterval;
		
		if (animating)
		{
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void) startPanoWithPath:(NSString *)panoPath
{
	[self createFadeIn];
	[self createSkyboxWithPath:panoPath];
	[self startAnimation];
}

- (void) createFadeIn
{
	CGRect frame = CGRectMake(0, 0, 768, 1024);
	UIView* fadeIn = [[UIView alloc] initWithFrame:frame];
	[fadeIn setBackgroundColor:[UIColor blackColor]];
	[self addSubview:fadeIn];
	
	fadeIn.alpha = 1;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationCurve: UIViewAnimationCurveLinear];
	fadeIn.alpha = 0;
	[UIView commitAnimations];
	
	[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(killFade:) userInfo:fadeIn repeats:NO];
}

- (void) killFade: (NSTimer*) timer
{
	UIView* fadeIn = (UIView*)[timer userInfo];
	[fadeIn removeFromSuperview];
}

- (void) stopPano
{
	[self stopAnimation];
	[self destroyTextures];
}

- (void) startAnimation
{
	if (!animating)
	{
		if (displayLinkSupported)
		{
			displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(drawView)];
			[displayLink setFrameInterval:animationFrameInterval];
			[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		}
		else
			animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(drawView) userInfo:nil repeats:TRUE];
		
		animating = TRUE;
	}
}

- (void)stopAnimation
{
	if (animating)
	{
		if (displayLinkSupported)
		{
			[displayLink invalidate];
			displayLink = nil;
		}
		else
		{
			[animationTimer invalidate];
			animationTimer = nil;
		}
		
		animating = FALSE;
	}
}


// Sets up an array of values to use as the sprite vertices.
const GLfloat spriteVertices[] = {
	-0.5f, -0.5f,
	0.5f, -0.5f,
	-0.5f,  0.5f,
	0.5f,  0.5f,
};

// Sets up an array of values for the texture coordinates.
const GLshort spriteTexcoords[] = {
	1, 0,
	0, 0,
	1, 1,
	0, 1,
};

- (void)setupView
{	
	// Sets up matrices and transforms for OpenGL ES
	glViewport(0, 0, backingWidth, backingHeight);
	//[self setFOV:80.0];
	[self setFOV:90.0 - zoomAmount*100];
	glMatrixMode(GL_MODELVIEW);
	
	// Clears the view with black
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	
	// Sets up pointers and enables states needed for using vertex arrays and textures
	glVertexPointer(2, GL_FLOAT, 0, spriteVertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glTexCoordPointer(2, GL_SHORT, 0, spriteTexcoords);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glEnable(GL_CULL_FACE);
	glCullFace(GL_BACK);
	
	glEnable(GL_TEXTURE_2D);
	
	// Set a blending function to use
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	// Enable blending
	glDisable(GL_BLEND);
	glDisable(GL_DEPTH_TEST);
	glDisable(GL_LIGHTING);
	glColor4f(1,1,1,1);
	[self setBackgroundColor:[UIColor blackColor]];
}

-(void)setFOV: (float)FOV
{
	GLfloat					size;
	const GLfloat			zNear = 0.1, zFar = 1000.0;
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	size = zNear * tanf(DEGREES_TO_RADIANS(FOV) / 2.0);
	CGRect rect = self.bounds;
	glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / (rect.size.width / rect.size.height), zNear, zFar);
	glViewport(0, 0, rect.size.width, rect.size.height);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}

// Updates the OpenGL view when the timer fires
- (void)drawView
{
	// Make sure that you are drawing to the current context
	[EAGLContext setCurrentContext:context];
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	switch( scene )
	{
		case 0:
			if( momentumOn )
			{
				if( abs(momentumX) > 1.5 )
				{
					if( momentumX > 0 )
						momentumX -= 0.75;
					else
						momentumX += 0.75;
				}
				else
					momentumX = 0;
				
				if( abs(momentumY) > 1.5 )
				{
					if( momentumY > 0 )
						momentumY -= 0.75;
					else
						momentumY += 0.75;
				}
				else
					momentumY = 0;
				
				if( momentumX == 0 && momentumY == 0 )
					momentumOn = NO;
				
				rotY += momentumY;
				rotX += momentumX;
			}
			
			if( rotY > verticalStop ) rotY = verticalStop;
			if( rotY < -verticalStop ) rotY = -verticalStop;
			
			glPushMatrix();
			glRotatef(rotY/10.0, 1, 0, 0);
			glRotatef(rotX/10.0, 0, 1, 0);
			
			glPushMatrix();
			glTranslatef(0.0, 0.0, -0.5);
			glRotatef(180.0, 0.0, 0.0, 1.0);
			glBindTexture(GL_TEXTURE_2D, spriteRight);
			glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			glPopMatrix();
			
			glPushMatrix();
			glRotatef(90.0, 0.0, 1.0, 0.0);
			glTranslatef(0.0, 0.0, -0.5);
			glRotatef(180.0, 0.0, 0.0, 1.0);
			glBindTexture(GL_TEXTURE_2D, spriteFront);
			glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			glPopMatrix();
			
			glPushMatrix();
			glRotatef(180.0, 0.0, 1.0, 0.0);
			glTranslatef(0.0, 0.0, -0.5);
			glRotatef(180.0, 0.0, 0.0, 1.0);
			glBindTexture(GL_TEXTURE_2D, spriteLeft);
			glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			glPopMatrix();
			
			glPushMatrix();
			glRotatef(270.0, 0.0, 1.0, 0.0);
			glTranslatef(0.0, 0.0, -0.5);
			glRotatef(180.0, 0.0, 0.0, 1.0);
			glBindTexture(GL_TEXTURE_2D, spriteBack);
			glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			glPopMatrix();
			
			glPushMatrix();
			glRotatef(90.0, 1.0, 0.0, 0.0);
			glTranslatef(0.0, 0.0, -0.5);
			glRotatef(90.0, 0.0, 0.0, 1.0);
			glBindTexture(GL_TEXTURE_2D, spriteTop);
			glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			glPopMatrix();
			
			glPushMatrix();
			glRotatef(270.0, 1.0, 0.0, 0.0);
			glTranslatef(0.0, 0.0, -0.5);
			glRotatef(270.0, 0.0, 0.0, 1.0);
			glBindTexture(GL_TEXTURE_2D, spriteBottom);
			glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			glPopMatrix();
			glPopMatrix();
			break;
	}
	
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (void) destroyTextures
{
	glDeleteTextures(1, &spriteLeft);
	glDeleteTextures(1, &spriteRight);
	glDeleteTextures(1, &spriteTop);
	glDeleteTextures(1, &spriteFront);
	glDeleteTextures(1, &spriteBack);
	glDeleteTextures(1, &spriteBottom);
}

- (void) createSkyboxWithPath:(NSString *)path
{
	CGImageRef spriteImage;
	CGContextRef spriteContext;
	GLubyte *spriteData;
	size_t	width, height;
	
    [self setFOV:90.0];
    
	for( int i = 0; i < 6; i++ )
	{
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		// Creates a Core Graphics image from an image file
        NSString* imageName = [NSString stringWithFormat:@"pano%@", panoSufixxes[i]];
        NSString* imgPath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg" inDirectory:path];
        
		//spriteImage = [UIImage imageNamed:[NSString stringWithFormat: @"%@_b.jpg", panoNames[currentPano]]].CGImage;
        spriteImage = [UIImage imageWithContentsOfFile:imgPath].CGImage;
		// Get the width and height of the image
		width = CGImageGetWidth(spriteImage);
		height = CGImageGetHeight(spriteImage);
		// Texture dimensions must be a power of 2. If you write an application that allows users to supply an image,
		// you'll want to add code that checks the dimensions and takes appropriate action if they are not a power of 2.
		
		if(spriteImage) {
			spriteData = (GLubyte *) calloc(width * height * 4, sizeof(GLubyte));
			spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width * 4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
			CGContextDrawImage(spriteContext, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), spriteImage);
			CGContextRelease(spriteContext);
			
			// Use OpenGL ES to generate a name for the texture.
			// Bind the texture name.
			switch( i )
			{
				case 0:
					glGenTextures(1, &spriteBack);
					glBindTexture(GL_TEXTURE_2D, spriteBack);
					break;
				case 1:
					glGenTextures(1, &spriteBottom);
					glBindTexture(GL_TEXTURE_2D, spriteBottom);
					break;
				case 2:
					glGenTextures(1, &spriteFront);
					glBindTexture(GL_TEXTURE_2D, spriteFront);
					break;
				case 3:
					glGenTextures(1, &spriteLeft);
					glBindTexture(GL_TEXTURE_2D, spriteLeft);
					break;
				case 4:
					glGenTextures(1, &spriteRight);
					glBindTexture(GL_TEXTURE_2D, spriteRight);
					break;
				case 5:
					glGenTextures(1, &spriteTop);
					glBindTexture(GL_TEXTURE_2D, spriteTop);
					break;
			}
			
			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
			glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
			// Release the image data
			free(spriteData);
			[pool release];
		}
	}
}

- (void)touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{	
	[self startAnimation];
	
	NSSet *allTouches = [event allTouches];
	switch ([allTouches count]) {
		case 1: { //Single touch
			
			//Get the first touch.
			UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			
			CGPoint location = [touch locationInView:self];
			lastX = location.x;
			lastY = location.y;
			momentumOn = NO;
			zooming = NO;
		} break;
		case 2: { //Double Touch
			//Track the initial distance between two fingers.
			UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
			UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			initialDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:self] 
													 toPoint:[touch2 locationInView:self]];
			
			zooming = YES;
			
		} break;
		default:
			break;
	}
}

- (void)touchesMoved: (NSSet *)touches withEvent: (UIEvent *)event{
	
	NSSet *allTouches = [event allTouches];
	
	switch ([allTouches count])
	{
		case 1:
		{
			UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			CGPoint location = [touch locationInView:self];
			rotX += (lastX - location.x);
			rotY += (lastY - location.y);
			lastX = location.x;
			lastY = location.y;
			zooming = NO;
			
		} break;
		case 2: {
			UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
			UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			
			//Calculate the distance between the two fingers.
			finalDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:self]
												   toPoint:[touch2 locationInView:self]];
			
			if( initialDistance < finalDistance ){
				zoomAmount += 0.01;
				if( zoomAmount > 0.3 )
					zoomAmount = 0.3;
			}
			else {
				zoomAmount -= 0.01;
				if( zoomAmount < 0.0 )
					zoomAmount = 0.0;
			}
			initialDistance = finalDistance;
			
			[self setFOV:90.0 - zoomAmount*100];
			zooming = YES;
			
		} break;
	}
}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event{
	NSSet *allTouches = [event allTouches];
	
	switch ([allTouches count])
	{
		case 1:
		{
			if( zooming )
				break;
			
			UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			CGPoint location = [touch locationInView:self];
			momentumX = (lastX - location.x);
			momentumY = (lastY - location.y);
			momentumOn = YES;
		} break;
		case 2: {
			zooming = NO;
		} break;
	}
	
}

- (float)distanceBetweenTwoPoints: (CGPoint)fromPoint toPoint: (CGPoint)toPoint{
	
	float x = toPoint.x - fromPoint.x;
	float y = toPoint.y - fromPoint.y;
	return sqrt(x * x + y * y);
	
}

// Release resources when they are no longer needed.
- (void)dealloc
{
	if([EAGLContext currentContext] == context) {
		[EAGLContext setCurrentContext:nil];
	}
	
	[context release];
	context = nil;
	
	[super dealloc];
}

@end
