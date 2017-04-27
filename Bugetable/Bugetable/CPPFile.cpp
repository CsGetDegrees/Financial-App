//
//  CPPFile.cpp
//  swift test
//
//  Created by Tengzhe Li on 4/20/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

#include "CPPFile.h"
#include <functional>
#include <random>
#include <stdio.h>
#include <memory>


using namespace std;

class NormalGenerator{
private:
    std::mt19937 re;
    std::normal_distribution<float> di;
    
public:
    NormalGenerator(): di(30,1)
    {
        re.seed((unsigned int)time(NULL));
    }
    
    float get(){
        return di(re);
    }
    
};

static std::unique_ptr<NormalGenerator> generator;

float getGaussian(){
    
    if(!generator)
        generator = std::unique_ptr<NormalGenerator>(new NormalGenerator);
    
    return generator->get();
}
