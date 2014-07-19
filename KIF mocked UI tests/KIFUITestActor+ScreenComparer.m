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
  CGContextRef ctx;
  CGImageRef firstImageRef = [firstImage CGImage];
  CGImageRef secondImageRef = [secondImage CGImage];
  CGImageRef maskRef = [mask CGImage];
  NSUInteger width = CGImageGetWidth(firstImageRef);
  NSUInteger height = CGImageGetHeight(firstImageRef);
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  byte *rawData = malloc(height * width * 4);
  byte *secondRawData = malloc(height * width * 4);
  byte *maskRawData = malloc(height * width * 4);
  byte *outputRawData = malloc(height * width * 4);
  NSUInteger bytesPerPixel = 4;
  NSUInteger bytesPerRow = bytesPerPixel * width;
  NSUInteger bitsPerComponent = 8;
  CGContextRef context = CGBitmapContextCreate(rawData, width, height,
          bitsPerComponent, bytesPerRow, colorSpace,
          kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Big);

  CGContextDrawImage(context, CGRectMake(0, 0, width, height), firstImageRef);
  CGContextRelease(context);

  CGContextRef secondContext = CGBitmapContextCreate(secondRawData, width, height,
          bitsPerComponent, bytesPerRow, colorSpace,
          kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Big);

  CGContextDrawImage(secondContext, CGRectMake(0, 0, width, height), secondImageRef);
  CGContextRelease(secondContext);

  CGContextRef maskContext = CGBitmapContextCreate(maskRawData, width, height,
          bitsPerComponent, bytesPerRow, colorSpace,
          kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Big);

  CGContextDrawImage(maskContext, CGRectMake(0, 0, width, height), maskRef);
  CGContextRelease(maskContext);

  int byteIndex = 0;
  BOOL areImagesEqual = YES;
  for (int ii = 0 ; ii < width * height ; ++ii)
  {
    int diff = abs(rawData[byteIndex] - secondRawData[byteIndex]) + abs(rawData[byteIndex+1] - secondRawData[byteIndex+1]) + abs(rawData[byteIndex+2] - secondRawData[byteIndex+2]);
    if(maskRawData[byteIndex] == 0 && diff > 10){
      areImagesEqual = NO;
      outputRawData[byteIndex] = 255;
      outputRawData[byteIndex+1] = 255;
      outputRawData[byteIndex+2] = 255;
      outputRawData[byteIndex+3] = 255;
    }
    else
    {
      outputRawData[byteIndex] = 0;
      outputRawData[byteIndex+1] = 0;
      outputRawData[byteIndex+2] = 0;
      outputRawData[byteIndex+3] = 255;
    }
    byteIndex += 4;
  }

  ctx = CGBitmapContextCreate(outputRawData,
          CGImageGetWidth(firstImageRef),
          CGImageGetHeight(firstImageRef),
          8,
          bytesPerRow,
          colorSpace,
          kCGImageAlphaPremultipliedLast );
  CGColorSpaceRelease(colorSpace);

  firstImageRef = CGBitmapContextCreateImage (ctx);
  UIImage* rawImage = [UIImage imageWithCGImage:firstImageRef];
  CGImageRelease(firstImageRef);

  CGContextRelease(ctx);
  free(rawData);
  if(!areImagesEqual)
    [self saveImage:rawImage toDiskName:@"diff.png"];

  return areImagesEqual;
}

@end