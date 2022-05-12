# Intermediate Code Generation

## Compilation to Intermediate Code

### Expressions
- Exp -> num | id | Exp **binop** Exp
- **Compilation Function** : (Exp, Table, Temp) -> [Instr]. *Temp* is the register where is the result.

> Visit the Slides to see the compilation function for each case in detail.

### Commands
- Stm -> id = Exp | if (Cond) Stm | if (Cond) Stm else Stm | While (Cond) Stm | {StmList}
  
  Cond -> Exp relop Exp
  
  StmList -> Stm StmList | empty

> relop means Relational Operation

- **Compilation Function** : (Stm, Table) -> [Instr]

- Relational Expressions
  - Extra arguments labels: *labelT* and *labelF* to jump when the condition is true/false
  - Cases: *If/Else* and *while*
  - **Compilation Function** : (Cond, Table, Label, Label) -> [Instr]


## Code Generation

### Basic Blocks
- Maximal sequence of consecutive 3 address instructions such that:
  - The flow of control can only enter the basic block through the 1st instruction in the block. That is, **there are no jumps into the middle of the block**.
  - Control leaves the block **without halting or branching except at the last instruction in the block**.

### Leader of a Block
- Corresponds to the 1st instruction in a basic block.
- Any instruction that is a target of a jump (conditional of unconditional) is a leader
- Any instruction that immediatly follows a jump is a leader

For each leader, its **basic block** consists of itself and all instructions up to the next leader or the end of the intermediate program.


