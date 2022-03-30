## Exercise Sheet 4 : Optimization/Meta-Heuristics

### 4.1 Timetabling Problem Solving using Local Search/Simulated Annealing
a)

solution=[1,1,1,1,...], where each index represents tne Subject i slot

A random solution could be to assign all subjects to the first slot

b) Iterate each student's discipline and increment the number of respective collisions

c) 

d) 

### Hill Climbing Algorithm
We calculate a neighbor state:
- if it's evaluation returns a better result, we start investigating from that new state.
- If it returns a worse result, we try to visit another neighbor
- There's no backtracking.
- Usually, to verify if the obtained solution is a local or global maxima, we run Hill Climbing several times with different initial states

### Simulated Annealing
Similar to the Hill Climbing Algorithm:
- If the neighbor has a better evaluation, we move to that state
- Otherwise, we only move to that state with a certain probability, that decreases over time
- P = e^(-Delta/t), where Delta is eval(current) - eval(neighbor)
- t's variation depends on the implementation. 
- This algorithm is inspired on the freezing phenomena in nature


### Genetic Algorithm
1. Determine what are the best members of the current population (evaluation)
2. Find a way to create a new population derived from the best members of the previous

#### Selection Methods
- Tournament: Ex: Choose 3 elements randomly and from those 3 select the best one
- Roullete: 

#### Child Genetic Generationo
- Basic Method: 2 parents generate 2 childs. 1st child will inherit 1st half of parent1 and 2nd half of parent2. 2nd child will have the rest.

#### Elitism
- The better element of the current population still goes to the next population
