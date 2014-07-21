//
// Created by Marek Moscichowski on 14/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "KIFUITestActor+ScreenComparer.h"


@implementation KIFUITestActor (ScreenComparer)

- (void)compareCurrentScreenWithReferenceImageNamed:(NSString *)imageName withMaskNamed:(NSString *)maskName {
    UIImage *screenshot = [self getScreenshot];
    UIImage *goldenImage = [self getImageNamed:imageName];
    UIImage *maskImage = [self getImageNamed:maskName];
    UIImage *maskedScreenshot = [self renderImage:[self maskImage:screenshot withMask:maskImage]];
    UIImage *maskedGolden = [self renderImage:[self maskImage:goldenImage withMask:maskImage]];

  [self saveImage:screenshot toDiskName:@"screenshot.png"];
  [self saveImage:maskedScreenshot toDiskName:@"maskedScreenshot.png"];
  [self saveImage:maskedGolden toDiskName:@"maskedGolden.png"];

  if(![self compareImage:screenshot withImage:goldenImage withMask:maskImage]){
        NSError *error = [[NSError alloc] initWithDomain:@"Given images are different"
                                                    code:1
                                                userInfo:@{@"Image1":maskedScreenshot, @"Image2":maskedGolden}];
        [self failWithError:error stopTest:NO];
    }
}

- (void)saveImage:(UIImage *)image toDiskName:(NSString *)filename
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *appFile = [documentsDirectory stringByAppendingPathComponent:filename];

  NSData * data = UIImagePNGRepresentation(image);
  [data writeToFile:appFile atomically:YES];

}

- (UIImage *)getImageNamed:(NSString *)fileName {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [bundle pathForResource:fileName ofType:@"png"];
    UIImage *fromFile = [UIImage imageWithContentsOfFile:imagePath];
    return fromFile;
}

- (UIImage *)getScreenshot {
    UIWindow *window = [[UIApplication sharedApplication] windows] [0];
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, [UIScreen mainScreen].scale);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {

    CGImageRef maskRef = maskImage.CGImage;

    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
            CGImageGetHeight(maskRef),
            CGImageGetBitsPerComponent(maskRef),
            CGImageGetBitsPerPixel(maskRef),
            CGImageGetBytesPerRow(maskRef),
            CGImageGetDataProvider(maskRef), NULL, false);

    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
}

- (UIImage *)renderImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
typedef unsigned char byte;

- (BOOL)compareImage:(UIImage *)firstImage withImage:(UIImage *)secondImage withMask:(UIImage *)mask {

  // Thanks: http://brandontreb.com/image-manipulation-retrieving-and-updating-pixel-values-for-a-uiimage/
  NSUInteger width = (NSUInteger) firstImage.size.width;
  NSUInteger height = (NSUInteger) firstImage.size.height;
  byte *rawData = [self getRawDataFromImage:firstImage];
  byte *secondRawData = [self getRawDataFromImage:secondImage];
  byte *maskRawData = [self getRawDataFromImage:mask];
  int byteIndex = 0;
  BOOL areImagesEqual = YES;
  for (int ii = 0 ; ii < width * height ; ++ii)
  {
    int diff = abs(rawData[byteIndex] - secondRawData[byteIndex]) + abs(rawData[byteIndex+1] - secondRawData[byteIndex+1]) + abs(rawData[byteIndex+2] - secondRawData[byteIndex+2]);
    if(maskRawData[byteIndex] == 0 && diff > 10){
      areImagesEqual = NO;
      break;
    }
    byteIndex += 4;
  }

  return areImagesEqual;
}

- (byte *)getRawDataFromImage:(UIImage *)image{
  CGImageRef imageRef = [image CGImage];
  NSUInteger width = CGImageGetWidth(imageRef);
  NSUInteger height = CGImageGetHeight(imageRef);
  byte *rawData = malloc(height * width * 4);
  NSUInteger bytesPerPixel = 4;
  NSUInteger bytesPerRow = bytesPerPixel * width;
  NSUInteger bitsPerComponent = 8;
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = CGBitmapContextCreate(rawData, width, height,
          bitsPerComponent, bytesPerRow, colorSpace,
          kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Big);

  CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
  CGContextRelease(context);

  return rawData;
}

@end