//
//  FileHelpers.m
//  Homepwner
//
//  Created by tony on 13-4-26.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "FileHelpers.h"

NSString *pathInDocumentDirectory(NSString*fileName)
{
    NSArray *documentDirectories=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:fileName];
}