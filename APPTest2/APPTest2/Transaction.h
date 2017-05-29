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
    const char *getType(void);
    const char *getDate(void);
    const void Transaction(double price,char *type,char *date);



#ifdef __cplusplus
}
#endif
