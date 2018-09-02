# Just a few infos

I'll just sumarize here some important topics!

## About the Q# loop, let, mutable

As you can see, Q# uses C#-like semicolons and braces to indicate program structure.

Q# has an `if` statement that is very much like C#.

Q# deals with variables in a unique way. By default, variables in Q# are immutable; their value may not be changed after they are bound. The `let` keyword is used to indicate the binding of an immutable variable. Operation arguments are always immutable.

If you need a variable whose value can change, such as numOnes in the example, you can declare the variable with the `mutable` keyword. A mutable variable's value may be changed using a set statement.

In both cases, the type of a variable is inferred by the compiler. **Q# doesn't require any type annotations for variables.**

The `using` statement is also special to Q#. It is used to allocate an array of qubits for use in a block of code. In Q#, all qubits are dynamically allocated and released, rather than being fixed resources that are there for the entire lifetime of a complex algorithm. A `using` statement allocates a set of qubits at the start and releases those qubits at the end of the block. There is an analogous `borrowing` statement that is used to allocate potentially dirty ancilla qubits.

A `for` loop in Q# always iterates through a range. There is no Q# equivalent to a traditional C-style computer `for` statement. A range may be specified by the first and last integers in the range, as in the example: `1..10` is the range 1, 2, 3, 4, 5, 6, 7, 8, 9, and 10. If a step other than +1 is needed, then three integers with `..` between them is used: `1..2..10` is the range 1, 3, 5, 7, and 9. Note that ranges are inclusive at both ends.

The BellTest operation returns two values as a `tuple`. The operation's return type is `(Int, Int)`, and the return statement has an explicit tuple containing two integer variables. Q# uses tuples as a way to pass multiple values, rather than using structures or records.