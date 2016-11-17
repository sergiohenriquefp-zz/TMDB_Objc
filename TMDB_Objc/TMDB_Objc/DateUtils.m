//
//  DateUtils.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 16/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+(NSDate *)getFormateDateSimple:(NSString *)localDate
{
    
    if (!localDate) {
        [NSDate new];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateString = [dateFormatter dateFromString:localDate];
    
    if (dateString) {
        
        return dateString;
    }
    
    return [self getFormateDateSecond:localDate];
}

+(NSDate *)getFormateDate:(NSString *)localDate
{
    
    if (!localDate) {
        [NSDate new];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSDate *dateString = [dateFormatter dateFromString:localDate];
    
    if (dateString) {
        
        return dateString;
    }
    
    return [self getFormateDateSecond:localDate];
}

+(NSDate *)getFormateDateSecond:(NSString *)localDate
{
    if (!localDate) {
        [NSDate new];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *dateString = [dateFormatter dateFromString:localDate];
    return dateString;
}

+(NSString *)showNiceDate:(NSDate *)date{
    
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MM"];
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"dd"];
    
    return [NSString stringWithFormat:@"%02d/%02d/%d",[[monthFormatter stringFromDate:date] intValue], [[dayFormatter stringFromDate:date] intValue], [[yearFormatter stringFromDate:date] intValue]];
    
}

+(NSString *)getDateAlphabetic:(NSDate *)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSString *myFormattedDate = [dateFormat stringFromDate:date];
    return myFormattedDate;
}

+ (NSString *) getNomeMes: (int) mes
{
    NSString * nome = @" - ";
    
    switch (mes) {
            case 1:
            nome = @"Janeiro";
            break;
            case 2:
            nome = @"Fevereiro";
            break;
            case 3:
            nome = @"Março";
            break;
            case 4:
            nome = @"Abril";
            break;
            case 5:
            nome = @"Maio";
            break;
            case 6:
            nome = @"Junho";
            break;
            case 7:
            nome = @"Julho";
            break;
            case 8:
            nome = @"Agosto";
            break;
            case 9:
            nome = @"Setembro";
            break;
            case 10:
            nome = @"Outubro";
            break;
            case 11:
            nome = @"Novembro";
            break;
            case 12:
            nome = @"Dezembro";
            break;
    }
    
    return nome;
}

+ (NSString *)getMinNomeMes:(int)mes
{
    NSString * nome = @" - ";
    
    switch (mes) {
            case 1:
            nome = @"Jan";
            break;
            case 2:
            nome = @"Fev";
            break;
            case 3:
            nome = @"Mar";
            break;
            case 4:
            nome = @"Abr";
            break;
            case 5:
            nome = @"Mai";
            break;
            case 6:
            nome = @"Jun";
            break;
            case 7:
            nome = @"Jul";
            break;
            case 8:
            nome = @"Ago";
            break;
            case 9:
            nome = @"Set";
            break;
            case 10:
            nome = @"Out";
            break;
            case 11:
            nome = @"Nov";
            break;
            case 12:
            nome = @"Dez";
            break;
    }
    
    return nome;
}

@end
