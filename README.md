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

## panqec

The python panqec module is immediately available:

```
julia> using PyQDecoders

julia> PyQDecoders.panqec
Python: <module 'panqec' from ...>
```

Running the example from `panqec` [original tutorial](https://panqec.readthedocs.io/en/latest/tutorials/Panqec%20basics.html):

```
julia> using PyQDecoders: panqec, panqecdecoders

julia> Toric2DCode = panqec.codes.Toric2DCode;

julia> PauliErrorModel = panqec.error_models.PauliErrorModel;

julia> MatchingDecoder = panqecdecoders.MatchingDecoder;

julia> code = Toric2DCode(4)

julia> error_model = PauliErrorModel(0.2, 0.3, 0.5)

julia> p = 0.1

julia> decoder = MatchingDecoder(code, error_model, p)

julia> errors = error_model.generate(code, p)

julia> syndrome = code.measure_syndrome(errors)

julia> println("Errors: ", errors)
Errors: [0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]

julia> println("Syndrome: ", syndrome)
Syndrome: [0 1 0 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0]
```
