A Julia meta-package for accessing the python libraries `pymatching` (for MWPM-like decoders) and `ldpc` (for BP-like decoders).

# How to install

If you plan to use a python environment you are managing yourself, just make sure that julia is started from that environment and run

`] add https://github.com/QuantumSavory/PyQDecoders.jl#master`

You might get error messages telling you that you need to install some python packages in that environment of yours.

If you want julia to automatically take care of creating a hidden python environment that it manages itself, do `ENV["PYTHON"] = ""` before you install `PyQDecoders.jl`

# How to use

## `pymatching`

The python pymatching module is immediately available:

```
julia> using PyQDecoders

julia> PyQDecoders.pm
PyObject <module 'pymatching' from ...>
```

Running the example from `pymatching`'s original Readme:

```
julia> using PyQDecoders: sps, np, pm

julia> H = sps.csc_matrix(
           [1 1 0 0 0;
            0 1 1 0 0;
            0 0 1 1 0;
            0 0 0 1 1])
PyObject <4x5 sparse matrix of type '<class 'numpy.int64'>'
        with 8 stored elements in Compressed Sparse Column format>

julia> weights = [4, 3, 2, 3, 4]
5-element Vector{Int64}:
 4
 3
 2
 3
 4

julia> matching = pm.Matching(H, weights=weights)
PyObject <pymatching.Matching object with 4 detectors, 1 boundary node, and 5 edges>

julia> prediction = matching.decode([0, 1, 0, 1])
5-element Vector{UInt8}:
 0x00
 0x00
 0x01
 0x01
 0x00

julia> prediction, solution_weight = matching.decode([0, 1, 0, 1], return_weight=true);

julia> prediction
5-element Vector{UInt8}:
 0x00
 0x00
 0x01
 0x01
 0x00

julia> solution_weight
5.0
```

## ldpc

The python ldpc module is immediately available:

```
julia> using PyQDecoders

julia> PyQDecoders.ldpc
PyObject <module 'ldpc' from ...>
```

Running the example from `ldpc`'s original Readme:


```
julia> using PyQDecoders: sps, np, ldpc

julia> H = ldpc.codes.rep_code(3) # parity check matrix for the length-3 repetition code
2×3 Matrix{Int64}:
 1  1  0
 0  1  1

julia> n = size(H, 2) # the codeword length
3

julia> bpd = ldpc.bp_decoder(
           H, # the parity check matrix
           error_rate=0.1, # the error rate on each bit
           max_iter=n, # the maximum iteration depth for BP
           bp_method="product_sum", # BP method. The other option is `minimum_sum'
           channel_probs=[nothing] # channel probability probabilities. Will override error rate.
       )
PyObject <ldpc.bp_decoder.bp_decoder object at 0x7fea8283ab80>

julia> error = [0,1,0]
3-element Vector{Int64}:
 0
 1
 0

julia> syndrome = H*error .% 2
2-element Vector{Int64}:
 1
 1

julia> decoding = bpd.decode(syndrome)
3-element Vector{Int64}:
 0
 1
 0
```