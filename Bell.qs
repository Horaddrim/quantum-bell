namespace Quantum.Bell
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation Set (desired: Result, q1: Qubit) : ()
    {
        body
        {
            let current = M(q1);
            if (desired != current)
            {
                X(q1);
            }

        }
    }

    operation BellTest (count : Int, initial: Result) : (Int, Int, Int)
    {
        body
        {
            // In Q# there is two types of variables, the `let` variable, which is constant, and you
            // can NEVER change it's value, and the `mutable`, which you can rebind the value through a `set` operation
            mutable numOnes = 0;
            mutable agree = 0;
            // Here, I tell the simulator to allocate 2 qubits for me! :D
            using (qubits = Qubit[2])
            {
                // There is no C-style `for` in Q#, you can only iterate over a set of given numbers!
                // Works really similar too the `range` operator in Python.
                // You can check it out more in `docs.md` in the root of this repository!  
                for (test in 1..count)
                {
                    // In Q#, the Set operation does the trick to set the given value to a qubit that you specify
                    Set (initial, qubits[0]);
                    Set (Zero, qubits[1]);
                    
                    // Now we perform a flip operation over the qubit
                    //  X(qubits[0]);
                    // Or we SUPERPOSE them, making the Qubit half the times
                    // closer to 1 and the other half, closer to 0;
                    H(qubits[0]);

                    // Here we entangle the Qubits, 
                    // creating a quantum entanglement, so
                    // everything that happens with one qubit
                    // will happen to the other one too,
                    // doesn't matter where they are.
                    // The CNOT gate entangle the two Qubits
                    CNOT(qubits[0], qubits[1]);

                    let res = M (qubits[0]);

                    // As I presume, M gate is the "Observation" in the quantum mechanics theory
                    // But basically, in Q#, is how you check the value of a qubit  
                    if(M (qubits[1]) == res) {
                        // Here as I said, you use a different `set` operator to re-bind the value to the `mutable` variable
                        set agree = agree + 1;
                    }

                    // Count the number of ones we saw:
                    if (res == One)
                    {
                        set numOnes = numOnes + 1;
                    }
                }

                Set(Zero, qubits[0]);
                Set(Zero, qubits[1]);
            }
            // Return number of times we saw a |0> and number of times we saw a |1>
            // In Quantum Mechanics, we  use the |> notation to represent the quantum `state` of the qubit
            return (count-numOnes, numOnes, agree);
        }
    }
}
