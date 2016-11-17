//
//  MyFunctions.h
//
//  Created by sergio freire on 10/12/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyFunctions : NSObject

+(NSString*)formattedEmptyString:(NSString *)string;

+(NSString*)savedStringInfo:(NSString *)key;
+(void)setStringInfo:(NSString *)info key:(NSString *)key;
+(int)savedIntInfo:(NSString *)key;
+(void)setIntInfo:(int)info key:(NSString *)key;
+(BOOL)savedBoolInfo:(NSString *)key;
+(void)setBoolInfo:(BOOL)info key:(NSString *)key;

//Append Post
+ (NSData *)retornarArgumentoPostComBoundary:(NSString *)boundary ComNome:(NSString *)nome valor:(NSData *)valor;

+ (NSString *)documentsDirectory;

//Append Post
+ (id)assertObjectNullForValue:(id)objeto defaultValue:(id)defaultValue;
+ (id)assertObjectNullForDictionary:(id)objeto;

//Color
+ (UIColor *)colorFromRGB:(NSString *)rgbValue;
+ (UIColor *)colorFromRGB:(NSString *)rgbValue withAlpha:(float)alpha;

//Layer
+ (CALayer *)retornarGradientLayerParaView:(UIView *)view comCores:(NSArray *)cores;
+ (CALayer *)retornarSombraLayerParaView:(UIView *)view comCor:(NSString *)cor;

+ (BOOL)isJailBreak;
+ (BOOL)isStringEmpty:(NSString *)string;
+ (int)upperCaseCount:(NSString *)string;
+ (int)numberCount:(NSString *)string;
+ (BOOL)hasOnlyNumber:(NSString *)string;
+ (BOOL)passouTempo:(double)horas deData:(NSDate *)data;
+ (BOOL)apagarFilesDirectory;

+(NSString *)montarStringEspecialComData:(NSDate *)data;

+ (UIImage *) getScaledImage:(UIImage *)img insideButton:(UIButton *)btn;
+ (NSRange) getRangeOfFullString:(NSString *)fullString partString:(NSString *)partString;

+ (NSMutableAttributedString *)getUnderlineAttributedText:(NSString*)text color:(UIColor *)color;
+ (NSMutableAttributedString *)getAttributedTextWithTexts:(NSArray *)texts fonts:(NSArray *)fonts colors:(NSArray *)colors;

@end
