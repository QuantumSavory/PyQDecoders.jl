@testitem "Aqua analysis" tags=[:aqua] begin

using Aqua, PyQDecoders

Aqua.test_all(PyQDecoders)

end
