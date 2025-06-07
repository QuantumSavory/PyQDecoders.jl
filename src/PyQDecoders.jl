module PyQDecoders
import PythonCall

const sp = PythonCall.pynew()
const sps = PythonCall.pynew()
const np = PythonCall.pynew()
const pm = PythonCall.pynew()
const ldpc = PythonCall.pynew()
const ldpccodes = PythonCall.pynew()
const mqt_qecc = PythonCall.pynew()
const cc_decoder = PythonCall.pynew()

function __init__()
    PythonCall.pycopy!(sp, PythonCall.pyimport("scipy"))
    PythonCall.pycopy!(sps, PythonCall.pyimport("scipy.sparse"))
    PythonCall.pycopy!(np, PythonCall.pyimport("numpy"))
    PythonCall.pycopy!(pm, PythonCall.pyimport("pymatching"))
    PythonCall.pycopy!(ldpc, PythonCall.pyimport("ldpc"))
    PythonCall.pycopy!(ldpccodes, PythonCall.pyimport("ldpc.codes"))
    PythonCall.pycopy!(mqt_qecc, PythonCall.pyimport("mqt.qecc"))
    PythonCall.pycopy!(cc_decoder, PythonCall.pyimport("mqt.qecc.cc_decoder.decoder"))
end

end # module
