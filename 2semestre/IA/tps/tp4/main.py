import numpy as np
import matplotlib.pyplot as plt
import copy
import random

slots = 4
disc = 12
std = 12

distr = np.array([[1,2,3,4,5],
                 [6,7,8,9],
                 [10,11,12],
                 [1,2,3,4],
                 [5,6,7,8],
                 [9,10,11,12],
                 [1,2,3,5],
                 [6,7,8],
                 [4,9,10,11,12],
                 [1,2,4,5],
                 [3,6,7,8],
                 [9,10,11,12]],dtype=object)

def enroled (std,disc):
    check_disc = distr[disc]
    if std in check_disc: return True
    else: return False
    
def imcomp(d1,d2):
    count = 0
    for student in range (1,std+1):
        if enroled(student,d1) and enroled(student,d2): count+=1
    return count

def evaluate(solu):
    evals = 0
    for d1 in range(0,disc-1):
        for d2 in range (d1+1,disc):
            #...
            print("hello")
    return evals
    

def print_hi(name):
    print(f'Hi, {name}')


if __name__ == '__main__':
    print_hi('PyCharm')
