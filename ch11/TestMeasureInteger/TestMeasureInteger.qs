namespace TestMeasureInteger {
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation RunTest() : Unit {
        let nQubits = 4;
        for item in 0..((1 <<< nQubits) - 1) {
            use qubits = Qubit[nQubits];
            for i in 0..(nQubits - 1) {
                if ((item &&& (1 <<< i)) != 0) {
                    X(qubits[i]);
                }
            }
            let result = MeasureInteger(LittleEndian(qubits));
            if (result != item) {
                Message($"Unexpected result, expecting {item}, got {result}");
                return ();
            }
        }
        Message("Success");
    }
}
