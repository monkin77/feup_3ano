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