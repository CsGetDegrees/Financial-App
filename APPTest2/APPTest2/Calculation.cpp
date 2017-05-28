//
//  Calculation.cpp
//  Budgetable
//
//  Created by Huiyu Jia on 5/28/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
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

double average(double a[]){
    double sum =0;
    for(int i=0;i<sizeof(a)/sizeof(a[0]) ;++i){
        sum+=a[i];
    }
    return sum/(sizeof(a)/sizeof(a[0]));
}
