// Algorithm.qs: Sample code for Deutsch Jozsa algorithm (Chapter 8).
//
// Copyright (c) Sarah Kaiser and Cassandra Granade.
// Code sample from the book "Learn Quantum Computing with Python and Q#" by
// Sarah Kaiser and Cassandra Granade, published by Manning Publications Co.
// Book ISBN 9781617296130.
// Code licensed under the MIT License.

namespace DeutschJozsa {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;

    operation PrepareTargetQubit(target : Qubit)
    : Unit is Adj {
        X(target);
        H(target);
    }

    operation CheckIfOracleIsBalanced(oracle : ((Qubit, Qubit) => Unit))
    : Bool {
        use control = Qubit();
        use target = Qubit();

        H(control);

        if (false) {
            // Method from Listing 8.6.
            PrepareTargetQubit(target);
            oracle(control, target);
            Adjoint PrepareTargetQubit(target);
        }

        if (false) {
            // Method from Listing 8.7.
            ApplyWith(PrepareTargetQubit, oracle(control, _), target);
        }

        if (true) {
            // Method from Listing 8.10.
            within {
                PrepareTargetQubit(target);
            } apply {
                oracle(control, target);
            }
        }

        return MResetX(control) == One;
    }

    operation RunDeutschJozsaAlgorithm() : Unit {
        Fact(not CheckIfOracleIsBalanced(ApplyZeroOracle),
            "Test failed for zero oracle.");
        Fact(not CheckIfOracleIsBalanced(ApplyOneOracle),
            "Test failed for one oracle.");
        Fact(CheckIfOracleIsBalanced(ApplyIdOracle),
            "Test failed for id oracle.");
        Fact(CheckIfOracleIsBalanced(ApplyNotOracle),
            "Test failed for not oracle.");

        Message("All tests passed!");
    }
}
