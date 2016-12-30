#FCL.jl - an implementation of the "fully connected layer"

module FCL

import ..@import_interface
@import_interface

import ..TF.sigmoid

type FullyConnectedLayer{F, inputlength, outputlength, transferfunction} <: Layer{F}
  bias::Vector{F}
  transition::Matrix{F}
end

function (::Type{FullyConnectedLayer{F,i,o,tf}}){F,i,o,tf}(randomizationfunction::Function = zeros)
  biasvector = randomizationfunction(F, o)
  transitionmatrix = randomizationfunction(F, o, i)
  FullyConnectedLayer{F,i,o,tf,l}(biasvector, transitionmatrix)
end

#implementation of the interfaces
inputs{F, i, o, tf}(::Type{FullyConnectedLayer{F, i, o, tf}}) = i
outputs{F, i, o, tf}(::Type{FullyConnectedLayer{F, i, o, tf}}) = o
parameters{F, i, o, tf}(::Type{FullyConnectedLayer{F, i, o, tf}})  = (i + 1) * o

include("./serialization.jl")
include("./evaluation.jl")
include("./backpropagation.jl")

end #module
