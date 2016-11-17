//
//  MyFunctions.m
//  MobileSchool
//
//  Created by sergio freire on 10/12/12.
//
//

#import "MyFunctions.h"

@implementation MyFunctions

//Formated
+(NSString*)formattedEmptyString:(NSString *)string{

    if (!string || [MyFunctions isStringEmpty:string]) {
        return @"-";
    }
    
    return string;
}

//String
+(NSString*)savedStringInfo:(NSString *)key{
    
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+(void)setStringInfo:(NSString *)info key:(NSString *)key{

    [[NSUserDefaults standardUserDefaults] setObject:info forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)savedIntInfo:(NSString *)key{
    
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:key];
}
+(void)setIntInfo:(int)info key:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setInteger:info forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)savedBoolInfo:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}
+(void)setBoolInfo:(BOOL)info key:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setBool:info forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//Append Post

+ (NSData *)retornarArgumentoPostComBoundary:(NSString *)boundary ComNome:(NSString *)nome valor:(NSData *)valor{
    
    NSMutableData *argumento = [NSMutableData data];
    
    // pk_aluno - Paramentro 1
    [argumento appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [argumento appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",nome] dataUsingEncoding:NSUTF8StringEncoding]];
    [argumento appendData:valor];
    [argumento appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    return argumento;
}

+ (NSString *)documentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    return basePath;
}

//Append Post
+ (id)assertObjectNullForDictionary:(id)objeto{
    
    if (objeto) {
        
        return objeto;
    }
    
    return [NSNull null];
}

+ (id)assertObjectNullForValue:(id)objeto defaultValue:(id)defaultValue{
    
    if(([objeto isKindOfClass:[NSNull class]] == NO) && (objeto != nil))
    {
        return objeto;
    }
    
    return defaultValue;
    
}

//Color

+ (UIColor *)colorFromRGB:(NSString *)rgbValue{
    
    unsigned colorInt = 0;
    [[NSScanner scannerWithString:rgbValue] scanHexInt:&colorInt];
    
    return [UIColor colorWithRed:((float)((colorInt & 0xFF0000) >> 16))/255.0
                           green:((float)((colorInt & 0xFF00) >> 8))/255.0
                            blue:((float)(colorInt & 0xFF))/255.0 alpha:1.0];
    
}
+ (UIColor *)colorFromRGB:(NSString *)rgbValue withAlpha:(float)alpha{
    
    unsigned colorInt = 0;
    [[NSScanner scannerWithString:rgbValue] scanHexInt:&colorInt];
    
    return [UIColor colorWithRed:((float)((colorInt & 0xFF0000) >> 16))/255.0
                           green:((float)((colorInt & 0xFF00) >> 8))/255.0
                            blue:((float)(colorInt & 0xFF))/255.0 alpha:alpha];
    
}

//Layer
+ (CALayer *)retornarGradientLayerParaView:(UIView *)view comCores:(NSArray *)cores{
    
    //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
    UIColor * highColor = [MyFunctions colorFromRGB:@"4bc5e4"];
    UIColor * lowColor = [MyFunctions colorFromRGB:@"00a3cc"];
    
    //The gradient, simply enough.  It is a rectangle
    CAGradientLayer * gradient = [CAGradientLayer layer];
    [gradient setFrame:[view bounds]];
    [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[lowColor CGColor], nil]];
    
    //the rounded rect, with a corner radius of 6 points.
    //this *does* maskToBounds so that any sublayers are masked
    //this allows the gradient to appear to have rounded corners
    CALayer * roundRect = [CALayer layer];
    [roundRect setFrame:[view bounds]];
    [roundRect setCornerRadius:4.0f];
    [roundRect setMasksToBounds:YES];
    [roundRect addSublayer:gradient];
    
    return roundRect;
}

+ (CALayer *)retornarSombraLayerParaView:(UIView *)view comCor:(NSString *)cor{
    
    CALayer *shadowLayer = [CALayer layer];
    
    [shadowLayer setShadowColor:[[MyFunctions colorFromRGB:cor] CGColor]];
    [shadowLayer setShadowOffset:CGSizeMake(0, 4)];
    [shadowLayer setShadowOpacity:0.3];
    [shadowLayer setShadowRadius:2.0];
    
    return shadowLayer;
}

+ (BOOL)isJailBreak{

    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey: @"SignerIdentity"] != nil)
    {
        /* do something */
        return YES;
    }

    return NO;
}

+ (BOOL)isStringEmpty:(NSString *)string{

    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:charSet];
    if ([trimmedString isEqualToString:@""]) {
        // it's empty or contains only white spaces
        return YES;
    }
    
    return NO;
}

+ (int)upperCaseCount:(NSString *)string{
    
    int count=0;
    for (int i = 0; i < [string length]; i++) {
        BOOL isUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[string characterAtIndex:i]];
        if (isUppercase == YES)
            count++;
    }
    
    return count;
}

+ (int)numberCount:(NSString *)string{
    
    int count=0;
    for (int i = 0; i < [string length]; i++) {
        BOOL isNumber= [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:i]];
        if (isNumber == YES)
            count++;
    }
    
    return count;
}

+(BOOL)hasOnlyNumber:(NSString *)string{

    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    
    if ([_NumericOnly isSupersetOfSet: myStringSet])
    {
        return true;
    }
    
    return false;
}

+(BOOL)passouTempo:(double)horas deData:(NSDate *)data{
    
    ///if ([Settings savedHorarioRespostaTaxista]) {
    
    if (data) {
        
        double seconds = [[NSDate date] timeIntervalSinceDate:data];
        
        double horasPassadas = (seconds/60)/60;
        
        if (horasPassadas > horas) {
            
            //NSlog(@"PASSARAM AS HORAS");
            
            return YES;
        }
        else {
            
            //NSlog(@"NAO PASSARAM AS HORAS %f", horasPassadas);
            
            return NO;
        }
        
    }
    
    return NO;
    
}

+(BOOL)apagarFilesDirectory{

    // Path to the Documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Print out the path to verify we are in the right place
        NSString *directory = [paths objectAtIndex:0];
        //NSlog(@"Directory: %@", directory);
        
        // For each file in the directory, create full path and delete the file
        for (NSString *file in [fileManager contentsOfDirectoryAtPath:directory error:&error])
        {
            NSString *filePath = [directory stringByAppendingPathComponent:file];
            //NSlog(@"File : %@", filePath);
            
            NSArray *parts = [filePath componentsSeparatedByString:@"."];
            NSString *extensionName = [parts objectAtIndex:[parts count]-1];
            
            if (![extensionName isEqualToString:@"sqlite"]) {
                
                BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
                
                if (fileDeleted != YES || error != nil)
                {
                    // Deal with the error...
                    return NO;
                }
            }
        }
    }
    
    return YES;
}

+(NSString *)montarStringEspecialComData:(NSDate *)data{
    
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MM"];
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"dd"];
    
    NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
    [hourFormatter setDateFormat:@"HH"];
    
    NSDateFormatter *minuteFormatter = [[NSDateFormatter alloc] init];
    [minuteFormatter setDateFormat:@"mm"];
    
    NSDateFormatter *secondFormatter = [[NSDateFormatter alloc] init];
    [secondFormatter setDateFormat:@"ss"];
    
    return [NSString stringWithFormat:@"%d/%d/%d às %dh:%d",[[dayFormatter stringFromDate:data] intValue], [[monthFormatter stringFromDate:data] intValue], [[yearFormatter stringFromDate:data] intValue], [[hourFormatter stringFromDate:data] intValue], [[minuteFormatter stringFromDate:data] intValue]];
    
}

+ (UIImage *) getScaledImage:(UIImage *)img insideButton:(UIButton *)btn {
    
    // Check which dimension (width or height) to pay respect to and
    // calculate the scale factor
    CGFloat imgRatio = img.size.width / img.size.height,
    btnRatio = btn.frame.size.width / btn.frame.size.height,
    scaleFactor = (imgRatio > btnRatio
                   ? img.size.width / btn.frame.size.width
                   : img.size.height / btn.frame.size.height);
                   
                   // Create image using scale factor
                   UIImage *scaledImg = [UIImage imageWithCGImage:[img CGImage]
                                                            scale:scaleFactor
                                                      orientation:UIImageOrientationUp];
                   return scaledImg;
}

+ (NSRange) getRangeOfFullString:(NSString *)fullString partString:(NSString *)partString{

    NSMutableAttributedString *mutableString = nil;
    mutableString = [[NSMutableAttributedString alloc] initWithString:fullString];
    
    //  enumerate matches
    NSRange range = NSMakeRange(0,[fullString length]);
    
    NSRange rangeReturn = [fullString rangeOfString:partString options:0 range:range];
    
    return rangeReturn;
}

+ (NSMutableAttributedString *)getUnderlineAttributedText:(NSString*)text color:(UIColor *)color{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attrString setAttributes:@{NSForegroundColorAttributeName:kOrangeColor,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,[attrString length])];
    
    return attrString;
}

+ (NSMutableAttributedString *)getAttributedTextWithTexts:(NSArray *)texts fonts:(NSArray *)fonts colors:(NSArray *)colors{

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    int i = 0;
    
    for (NSString *text in texts) {
        
        UIFont *partFont = fonts[i];
        NSDictionary *partDict = [NSDictionary dictionaryWithObject:partFont forKey:NSFontAttributeName];
        NSMutableAttributedString *parAttrString = [[NSMutableAttributedString alloc] initWithString:text attributes:partDict];
        NSRange partRange = NSMakeRange(0, text.length);
        [parAttrString addAttribute:NSForegroundColorAttributeName value:colors[i] range:partRange];
        [attrString appendAttributedString:parAttrString];
        i++;
    }
    
    return attrString;
}

@end
