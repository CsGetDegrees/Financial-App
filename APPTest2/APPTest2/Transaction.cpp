//
//  Transaction.cpp
//  Budgetable
//
//  Created by Huiyu Jia on 5/28/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//
#include <iostream>
#include "Transaction.h"
using namespace std;

// some enmus types needed to be added here
class Transaction {
private:
    double price;
    int type;
    int month;
    int year;
    int day;
    string description;
    string id;

    public:
    double getPrice(void);
    int getType(void);
    int getYear(void);
    int getMonth(void);
    int getDay(void);
    string toString(void);
    Transaction(double price, int type,int year,int month, int day);
};

Transaction::Transaction(double price, int type,int year,int month, int day){
    this->price=price;
    this->type=type;
    this->year=year;
    this->month = month;
    this->day = day;
}

int Transaction::getYear(){
    return this->year;
}

int Transaction::getType(){
    return this->type;
}
int Transaction::getMonth(){
    return this->month;
}
int Transaction::getDay(){
    return this->day;
}

double Transaction::getPrice(){
    return this->price;
}
