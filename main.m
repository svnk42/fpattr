//
//  main.m
//  fpattr
//
//  Created by Sven Krewitt on 30/08/16.
//  Copyright © 2016 Sven Krewitt. All rights reserved.
//

#import <Foundation/Foundation.h>

void usage(){
    printf("Print NSFileProtectionKey\n");
    printf("usage: fpattr [-a] filename [filename ...]\n");
    printf("  -a : print all file attributes\n");
}

void printFileAttributes(NSFileManager *fm, NSString *filename, BOOL showAll){
    
    NSError *error;
    
    printf("[+] Full path: %s\n", [filename UTF8String]);
    if ( [fm fileExistsAtPath:filename] ){
        NSDictionary *attributes = [fm attributesOfItemAtPath:filename error:&error];
        if(showAll){
            for (id key in attributes){
                printf("  [-] %s : %s\n", [key UTF8String], [[NSString stringWithFormat:@"%@", [attributes objectForKey:key]] UTF8String]);
            }
        }else{
            printf("  [-] NSFileProtectionKey : %s\n", [[attributes objectForKey:NSFileProtectionKey] UTF8String]);
        }
    }else{
        printf("  [!] File does not exist : %s\n", [filename UTF8String]);
    }
}

int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *arguments = [[NSProcessInfo processInfo] arguments];
        NSString *docPath = [fm currentDirectoryPath];
        BOOL showAll = NO;

        if([arguments count] < 2){
            usage();
            return EXIT_SUCCESS;
        }
            
        
        /* parsing commandline arguments; remove options from filename list */
        NSMutableArray *filenames = [NSMutableArray arrayWithArray: arguments];
        for (int i=0; i < [filenames count]; i++){
            if([[filenames objectAtIndex:i] hasPrefix:@"-"]){
                switch([[filenames objectAtIndex:i] characterAtIndex:1]){
                    case 'a' :
                        showAll = YES;
                        break;
                    default:
                        break;
                }
                [filenames removeObjectAtIndex: i];
            }
        }
        
        /* print attributes for each file */
        for (int i=1; i < [filenames count]; i++){
            NSString *checkfile = [docPath stringByAppendingPathComponent:[filenames objectAtIndex:i]];
            printFileAttributes(fm, checkfile, showAll);
        }
    }
    return EXIT_SUCCESS;
}


