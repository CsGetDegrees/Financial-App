//
//  DailyTransaction.h
//  Budgetable
//
//  Created by Huiyu Jia on 5/29/17.
//  Copyright © 2017 TopCat. All rights reserved.
//

#ifdef __cplusplus
extern "C"{
#endif

    double getDailyTotal(void);
    int getYear(void);
    int getMonth(void);
    int getDay(void);
    const void DailyTransaction(double dailyTotal,int year,int month, int day);



#ifdef __cplusplus
}
#endif
