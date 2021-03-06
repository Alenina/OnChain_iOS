/*
 Copyright Kairos Community Directories 2014 all rights reserved. */

#import "SBJsonBase.h"
NSString * SBJSONErrorDomain = @"org.brautaset.JSON.ErrorDomain";


@implementation SBJsonBase

@synthesize errorTrace;
@synthesize maxDepth;

- (id)init {
    self = [super init];
    if (self)
        self.maxDepth = 512;
    return self;
}


- (void)addErrorWithCode:(NSUInteger)code description:(NSString*)str {
    NSDictionary *userInfo;
    if (!errorTrace) {
        errorTrace = [NSMutableArray new];
        userInfo = @{NSLocalizedDescriptionKey: str};
        
    } else {
        userInfo = @{NSLocalizedDescriptionKey: str,
                    NSUnderlyingErrorKey: [errorTrace lastObject]};
    }
    
    NSError *error = [NSError errorWithDomain:SBJSONErrorDomain code:code userInfo:userInfo];

    [self willChangeValueForKey:@"errorTrace"];
    [errorTrace addObject:error];
    [self didChangeValueForKey:@"errorTrace"];
}

- (void)clearErrorTrace {
    [self willChangeValueForKey:@"errorTrace"];
    errorTrace = nil;
    [self didChangeValueForKey:@"errorTrace"];
}

@end
