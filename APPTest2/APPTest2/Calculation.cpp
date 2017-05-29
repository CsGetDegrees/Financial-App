//
//  Calculation.cpp
//  Budgetable
//
//  Created by Huiyu Jia on 5/28/17.
//  Copyright © 2017 TopCatAppDevelopment. All rights reserved.
//

#include <stdio.h>
double add(double a, double b){
    return a+b;
}
double minu(double a, double b){
    return a-b;
}
double mult(double a, double b){
    return a*b;
}
double divi(double a, double b){
    return a/b;
}

/**
 * A double array will be passed into this method and the average of
 * every element in that array will be returned.
 */
double average(double a[]){
    double sum =0;
    for(int i=0;i<sizeof(a)/sizeof(a[0]) ;++i){
        sum+=a[i];
    }
    return sum/(sizeof(a)/sizeof(a[0]));
}
double total(double a[]){
    double sum=0;
    for(int i=0;i<sizeof(a)/sizeof(a[0]) ;++i){
        sum+=a[i];
    }
    return sum;
}
