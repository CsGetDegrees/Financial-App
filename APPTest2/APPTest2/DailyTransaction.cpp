//
//  DailyTransaction.cpp
//  Budgetable
//
//  Created by Huiyu Jia on 5/29/17.
//  Copyright © 2017 TopCat. All rights reserved.
//
//

#include <iostream>
#include "DailyTransaction.h"
using namespace std;

// some enmus types needed to be added here
class DailyTransaction {
private:
    double dailyTotal;
    int month;
    int year;
    int day;

public:
    double getDailyTotal(void);
    int getType(void);
    int getYear(void);
    int getMonth(void);
    int getDay(void);
    DailyTransaction(double dailyTotal,int year,int month, int day);
};

DailyTransaction::DailyTransaction(double dailyTotal,int year,int month, int day){
    this->dailyTotal=dailyTotal;

    this->year=year;
    this->month = month;
    this->day = day;
}

int DailyTransaction::getYear(){
    return this->year;
}

int DailyTransaction::getMonth(){
    return this->month;
}
int DailyTransaction::getDay(){
    return this->day;
}

double DailyTransaction::getDailyTotal(){
    return this->dailyTotal;
}
