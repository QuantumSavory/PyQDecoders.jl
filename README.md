A Julia meta-package for accessing the python libraries `pymatching` (for MWPM-like decoders) and `ldpc` (for BP-like decoders).

# How to use

## `pymatching`

The python pymatching module is immediately available:

```
julia> using PyQDecoders

julia> PyQDecoders.pm
Python: <module 'pymatching' from ...>
```

Running the example from `pymatching`'s original Readme:

```
julia> using PyQDecoders: sps, np, pm

julia> H = sps.csc_matrix(
           [1 1 0 0 0;
            0 1 1 0 0;
            0 0 1 1 0;
            0 0 0 1 1])
Python:
<4x5 sparse matrix of type '<class 'numpy.int64'>'
        with 8 stored elements in Compressed Sparse Column format>

julia> weights = [4, 3, 2, 3, 4]
5-element Vector{Int64}:
 4
 3
 2
 3
 4

julia> matching = pm.Matching(H, weights=weights)
Python: <pymatching.Matching object with 4 detectors, 1 boundary node, and 5 edges>

julia> prediction = matching.decode([0, 1, 0, 1])
Python: array([0, 0, 1, 1, 0], dtype=uint8)

julia> prediction, solution_weight = matching.decode([0, 1, 0, 1], return_weight=true);

julia> prediction
Python: array([0, 0, 1, 1, 0], dtype=uint8)

julia> solution_weight
Python: 5.0
```

## ldpc

The python ldpc module is immediately available:

```
julia> using PyQDecoders

julia> PyQDecoders.ldpc
Python: <module 'ldpc' from ...>
```

Running the example from `ldpc`'s original Readme:


```
julia> using PyQDecoders: sps, np, ldpc

julia> H = ldpc.codes.rep_code(3) # parity check matrix for the length-3 repetition code
Python:
array([[1, 1, 0],
       [0, 1, 1]])

julia> n = H.shape[1] # the codeword length, same as `size(H, 2)`
Python: 3

julia> bpd = ldpc.bp_decoder(
           H, # the parity check matrix
           error_rate=0.1, # the error rate on each bit
           max_iter=n, # the maximum iteration depth for BP
           bp_method="product_sum", # BP method. The other option is `minimum_sum'
           channel_probs=[nothing] # channel probability probabilities. Will override error rate.
       )
Python: <ldpc.bp_decoder.bp_decoder object at 0x...>

julia> error = [0,1,0]
3-element Vector{Int64}:
 0
 1
 0

julia> using PythonCall: PyArray

julia> syndrome = PyArray(H)*error .% 2
2-element Vector{Int64}:
 1
 1

julia> decoding = bpd.decode(np.array(syndrome))
Python: array([0, 1, 0])
```

## `mqt.qecc`

The python mqt.qecc module is immediately available:

```
julia> using PyQDecoders

julia> PyQDecoders.mqt_qecc
Python: <module 'mqt_qecc' from ...>
```

Running the example from `mqt_qecc`'s original Readme:

```
julia> using PyQDecoders: np, mqt_qecc;

julia> H = [[1, 0, 0, 1, 0, 1, 1], [0, 1, 0, 1, 1, 0, 1], [0, 0, 1, 0, 1, 1, 1]];

julia> code = mqt_qecc.Code(H, H);

julia> UFHeuristic = mqt_qecc.UFHeuristic;

julia> decoder = mqt_qecc.UFHeuristic();

julia> decoder.set_code(code);

julia> sample_iid_pauli_err = mqt_qecc.sample_iid_pauli_err;

julia> x_err = sample_iid_pauli_err(code.n, 0.05);

julia> decoder.decode(code.get_x_syndrome(x_err));

julia> result = decoder.result;

julia> residual_err = np.array(x_err) .⊻ np.array(result.estimate);

julia> is_stabilizer = code.is_x_stabilizer(residual_err);

julia> println("Is residual error a stabilizer? ", is_stabilizer);
```

LightsOut decoder for color codes

```
julia> using PyQDecoders: np, mqt_qecc, cc_decoder;

julia> side_length = 3;

julia> lattice = mqt_qecc.codes.HexagonalColorCode(side_length);

julia> problem = cc_decoder.LightsOut(lattice.faces_to_qubits, lattice.qubits_to_faces);

julia> problem.preconstruct_z3_instance();

julia> lights = [true, false, false];

julia> switches, constr_time, solve_time = problem.solve(lights)
Python: ([0, 1, 0, 0, 0, 0, 0], 0.06688149999990856, 0.001489878000029421)
```