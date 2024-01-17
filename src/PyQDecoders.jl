module PyQDecoders
import Conda
using PyCall

const sps = PyNULL()
const np = PyNULL()
const pm = PyNULL()
const ldpc = PyNULL()

function __init__()
    copy!(sps, pyimport_conda("scipy.sparse", "scipy"))
    copy!(np, pyimport_conda("numpy", "numpy"))
    if PyCall.conda
        Conda.pip_interop(true)
        Conda.pip("install", "pymatching")
        Conda.pip("install", "ldpc")
    end
    copy!(pm, pyimport_conda("pymatching", "pymatching"))
    copy!(ldpc, pyimport_conda("ldpc", "ldpc"))
    pyimport("ldpc.codes")
end

end # module
