//
//  SavingGoal.cpp
//  Budgetable
//
//  Created by Huiyu Jia on 5/29/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

//
//  Transaction.cpp
//  Budgetable
//
//  Created by Huiyu Jia on 5/28/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//
#include <iostream>
#include "SavingGoal.h"
using namespace std;

// some enmus types needed to be added here
class SavingGoal {
private:
    double price;
    int daysRemaining;
    int frequency;
    string description;
    string id;

public:
    double getPrice(void);
    int getDaysRemaininge(void);
    int getFrequency(void);

    SavingGoal(double price, int type,int daysRemaining,int frequency);
};

SavingGoal::SavingGoal(double price, int type,int daysRemaining,int frequency){
    this->price=price;
    this->daysRemaining=daysRemaining;
    this->frequency=frequency;}

int SavingGoal::getFrequency(){
    return this->frequency;
}

int SavingGoal::getDaysRemaininge(){
    return this->daysRemaining;
}
double SavingGoal::getPrice(){
    return this->price;
}
