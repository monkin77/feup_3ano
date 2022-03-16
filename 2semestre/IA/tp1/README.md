# TP1
## Formulation of Search Problems and Problem Solving  using Uninformed search

### 1.1 Two Buckets Problem
S = buckets(B1, B2)

Si = buckets0, 0)
Sf = buckets(2, _)

#### Operators
Cost depends on the problem's version:
- If the objective is minimum operations
- If the objective is minimize the water usage ()

| Operators        | Preconditions | Effect             | Cost     |
|------------------|---------------|--------------------|----------|
| Fill B1          | B1<4          | B1=4, B2=B2        | 1 (4-B1) |
| Fill B2          | B2<3          | B1=B1, B2=3        | 1 (3-B2) |
| Empty B1         | B1>0          | B1=0, B2=B2        | 1 (B1)   |
| Empty B2         | B2>0          | B1=B1, B2=0        | 1 (B2)   |
| B1->B2, fill B2  | B1>3-B2, B2<3 | B1=B1-(3-B2), B2=3 | 1 (0)    |
| B1->B2, empty B1 | (3-B2)>B1     | B1=0, B2=B2+B1     | 1 (0)    |
| B2->B1, fill B1  | B2>4-B1, B1<4 | B2=B2-(4-B1), B1=4 | 1 (0)    |
| B2->B1, empty B2 | (4-B1)>B2     | B1=B1+B2, B2=0     | 1 (0)    |

#### Algoritmos
**Iterative Deepening Strategy** -> Faz pesquisa em profunidade iterativa, aumentando a profundidade até encontrar a solução.

### 1.1 Missionaries and Cannibals Problem

S=(Mesq, Cesq, BarcoED)

#### Operators
| Operators   | Preconditions                                      | Effect | Cost |
|-------------|----------------------------------------------------|--------|------|
| 1M+1C(E->D) | Cesq>=1,Mesq>=1,seguro(Esq),seguro(Dir),Barco(Esq) |        |      |
| 1M+1C(D->E) |                                                    |        |      |
| 2M          |                                                    |        |      |
| 2C          |                                                    |        |      |
| 1M          |                                                    |        |      |
| 1C          |                                                    |        |      |

# TP2
## Problem-Solving using Informed Search

Informed search requires an heuristic to evaluate each node and decide which is visited first

If heuristic is:
- h (b (B1, B2)) :- h is abs(B1 - 2)

A* is an informed search algorithm that applies a heuristic h :- F = G + H.

G -> How much it cost to reach the current state
H -> Estimates Distance to Solution

When using only G, we are applying a uniform search
When using only H, we are applying a greedy search

### Exercise 2
#### 2.1
a) C 

b) E

c) D, Chooses the node with the least total cost to reach (G)
 
d) C, Chooses the node with the least distance to the solution, according to h

e) G, chooses the node with the least sum of the 2 above (G + H)

#### 2.2
State Representation (0 is empty) -> 
```
    [1, 5, 3],
    [4, 2, 8], 
    [7, 0, 6]
    
    Empty Position = ( 2 (RE), 1 (CE) ) -> So that we don't need to always iterate to find it
```


Operators:

| Operator         | Preconditions | Effect                                               | Cost |
|------------------|---------------|------------------------------------------------------|------|
| move piece left  | CE < N - 1    | S[RE, CE] = S[RE, CE+1]; S[RE, CE+1] = 0; CE=CE+1;   | 1    |
| move piece right | CE > 0        | S[RE, CE] = S[RE, CE-1]; S[RE, CE-1] = 0; CE=CE-1    | 1    |
| move piece up    | RE < N - 1    | S[RE, CE] = S[RE+1, CE]; S[RE+1, CE] = 0; RE = RE+1; | 1    |
| move piece down  | RE > 0        | S[RE, CE] = S[RE-1, CE]; S[RE-1, CE] = 0; RE = RE-1; | 1    |

c) 

When a heuristic appears to be good and after expanding the tree it turns out to be very costly, it means the heuristic function is probably not that good after all :c

H1 - Number of incorrect placed pieces

H2 - Sum of Manhattan distances from incorrect placed pieces to their correct places

**Admissible Heuristic** - Heuristic that never super-estimates the real cost to reach the solution.

If an heuristic is not admissible, A* will not be able to find the optimal solution

