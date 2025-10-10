module PyQDecoders
import PythonCall

const sp = PythonCall.pynew()
const sps = PythonCall.pynew()
const np = PythonCall.pynew()
const pm = PythonCall.pynew()
const ldpc = PythonCall.pynew()
const ldpccodes = PythonCall.pynew()
const fb = PythonCall.pynew()
const pecos = PythonCall.pynew()
const pecosdecoders = PythonCall.pynew()

function __init__()
    PythonCall.pycopy!(sp, PythonCall.pyimport("scipy"))
    PythonCall.pycopy!(sps, PythonCall.pyimport("scipy.sparse"))
    PythonCall.pycopy!(np, PythonCall.pyimport("numpy"))
    PythonCall.pycopy!(pm, PythonCall.pyimport("pymatching"))
    PythonCall.pycopy!(ldpc, PythonCall.pyimport("ldpc"))
    PythonCall.pycopy!(ldpccodes, PythonCall.pyimport("ldpc.codes"))
    PythonCall.pycopy!(fb, PythonCall.pyimport("fusion_blossom"))
    PythonCall.pycopy!(pecos, PythonCall.pyimport("pecos"))
    PythonCall.pycopy!(pecosdecoders, PythonCall.pyimport("pecos.decoders"))
end

end # module
