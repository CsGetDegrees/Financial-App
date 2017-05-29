//
//  Transaction.h
//  Budgetable
//
//  Created by Huiyu Jia on 5/28/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

#ifdef __cplusplus
extern "C"{
#endif

    double getPrice(void);
    int getType(void);
    int getYear(void);
    int getMonth(void);
    int getDay(void);
    const void Transaction(double price,int type,int date);



#ifdef __cplusplus
}
#endif
