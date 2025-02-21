
"""
    space(::SiteType"Electron"; 
          conserve_qns = false,
          conserve_sz = conserve_qns,
          conserve_nf = conserve_qns,
          conserve_nfparity = conserve_qns,
          qnname_sz = "Sz",
          qnname_nf = "Nf",
          qnname_nfparity = "NfParity")

Create the Hilbert space for a site of type "Electron".

Optionally specify the conserved symmetries and their quantum number labels.
"""
function space(::SiteType"Electron"; 
               conserve_qns = false,
               conserve_sz = conserve_qns,
               conserve_nf = conserve_qns,
               conserve_nfparity = conserve_qns,
               qnname_sz = "Sz",
               qnname_nf = "Nf",
               qnname_nfparity = "NfParity",
               # Deprecated
               conserve_parity = nothing)
  if !isnothing(conserve_parity)
    conserve_nfparity = conserve_parity
  end
  if conserve_sz && conserve_nf
    return [
       QN((qnname_nf,0,-1),(qnname_sz, 0)) => 1
       QN((qnname_nf,1,-1),(qnname_sz,+1)) => 1
       QN((qnname_nf,1,-1),(qnname_sz,-1)) => 1
       QN((qnname_nf,2,-1),(qnname_sz, 0)) => 1
      ]
  elseif conserve_nf
    return [
       QN(qnname_nf,0,-1) => 1
       QN(qnname_nf,1,-1) => 2
       QN(qnname_nf,2,-1) => 1
      ]
  elseif conserve_sz
    return [
       QN((qnname_sz, 0),(qnname_nfparity,0,-2)) => 1
       QN((qnname_sz,+1),(qnname_nfparity,1,-2)) => 1
       QN((qnname_sz,-1),(qnname_nfparity,1,-2)) => 1
       QN((qnname_sz, 0),(qnname_nfparity,0,-2)) => 1
      ]
  elseif conserve_nfparity
    return [
       QN(qnname_nfparity,0,-2) => 1
       QN(qnname_nfparity,1,-2) => 2
       QN(qnname_nfparity,0,-2) => 1
      ]
  end
  return 4
end

state(::SiteType"Electron",::StateName"Emp")  = 1
state(::SiteType"Electron",::StateName"Up")   = 2
state(::SiteType"Electron",::StateName"Dn")   = 3
state(::SiteType"Electron",::StateName"UpDn") = 4
state(st::SiteType"Electron",::StateName"0")    = state(st,StateName("Emp"))
state(st::SiteType"Electron",::StateName"↑")    = state(st,StateName("Up"))
state(st::SiteType"Electron",::StateName"↓")    = state(st,StateName("Dn"))
state(st::SiteType"Electron",::StateName"↑↓")   = state(st,StateName("UpDn"))

function op!(Op::ITensor,
             ::OpName"Nup",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>2,s=>2] = 1.0
  Op[s'=>4,s=>4] = 1.0
end

function op!(Op::ITensor,
             ::OpName"Ndn",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>3,s=>3] = 1.0
  Op[s'=>4,s=>4] = 1.0
end

function op!(Op::ITensor,
             ::OpName"Nupdn",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>4,s=>4] = 1.0
end

function op!(Op::ITensor,
             ::OpName"Ntot",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>2,s=>2] = 1.0
  Op[s'=>3,s=>3] = 1.0
  Op[s'=>4,s=>4] = 2.0
end

function op!(Op::ITensor,
             ::OpName"Cup",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>1,s=>2] = 1.0
  Op[s'=>3,s=>4] = 1.0
end

function op!(Op::ITensor,
             ::OpName"Cdagup",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>2,s=>1] = 1.0
  Op[s'=>4,s=>3] = 1.0
end

function op!(Op::ITensor,
             ::OpName"Cdn",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>1,s=>3] = 1.0
  Op[s'=>2,s=>4] = -1.0
end

function op!(Op::ITensor,
             ::OpName"Cdagdn",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>3,s=>1] = 1.0
  Op[s'=>4,s=>2] = -1.0
end

function op!(Op::ITensor,
             ::OpName"Aup",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>1,s=>2] = 1.0
  Op[s'=>3,s=>4] = 1.0
end

function op!(Op::ITensor,
             ::OpName"Adagup",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>2,s=>1] = 1.0
  Op[s'=>4,s=>3] = 1.0
end

function op!(Op::ITensor,
             ::OpName"Adn",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>1,s=>3] = 1.0
  Op[s'=>2,s=>4] = 1.0
end

function op!(Op::ITensor,
             ::OpName"Adagdn",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>3,s=>1] = 1.0
  Op[s'=>2,s=>4] = 1.0
end

function op!(Op::ITensor,
             ::OpName"F",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>1,s=>1] = +1.0
  Op[s'=>2,s=>2] = -1.0
  Op[s'=>3,s=>3] = -1.0
  Op[s'=>4,s=>4] = +1.0
end

function op!(Op::ITensor,
             ::OpName"Fup",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>1,s=>1] = +1.0
  Op[s'=>2,s=>2] = -1.0
  Op[s'=>3,s=>3] = +1.0
  Op[s'=>4,s=>4] = -1.0
end

function op!(Op::ITensor,
             ::OpName"Fdn",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>1,s=>1] = +1.0
  Op[s'=>2,s=>2] = +1.0
  Op[s'=>3,s=>3] = -1.0
  Op[s'=>4,s=>4] = -1.0
end

function op!(Op::ITensor,
             ::OpName"Sz",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>2,s=>2] = +0.5
  Op[s'=>3,s=>3] = -0.5
end

op!(Op::ITensor,
    ::OpName"Sᶻ",
    st::SiteType"Electron",
    s::Index) = op!(Op,OpName("Sz"),st,s)

function op!(Op::ITensor,
             ::OpName"Sx",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>2,s=>3] = 0.5
  Op[s'=>3,s=>2] = 0.5
end

op!(Op::ITensor,
    ::OpName"Sˣ",
    st::SiteType"Electron",
    s::Index) = op!(Op,OpName("Sx"),st,s)

function op!(Op::ITensor,
             ::OpName"S+",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>2,s=>3] = 1.0
end

op!(Op::ITensor,
    ::OpName"S⁺",
    st::SiteType"Electron",
    s::Index) = op!(Op,OpName("S+"),st,s)
op!(Op::ITensor,
    ::OpName"Sp",
    st::SiteType"Electron",
    s::Index) = op!(Op,OpName("S+"),st,s)
op!(Op::ITensor,
    ::OpName"Splus",
    st::SiteType"Electron",
    s::Index) = op!(Op,OpName("S+"),st,s)

function op!(Op::ITensor,
             ::OpName"S-",
             ::SiteType"Electron",
             s::Index)
  Op[s'=>3,s=>2] = 1.0
end

op!(Op::ITensor,
    ::OpName"S⁻",
    st::SiteType"Electron",
    s::Index) = op!(Op,OpName("S-"),st,s)
op!(Op::ITensor,
    ::OpName"Sm",
    st::SiteType"Electron",
    s::Index) = op!(Op,OpName("S-"),st,s)
op!(Op::ITensor,
    ::OpName"Sminus",
    st::SiteType"Electron",
    s::Index) = op!(Op,OpName("S-"),st,s)


has_fermion_string(::OpName"Cup", ::SiteType"Electron") = true
has_fermion_string(::OpName"Cdagup", ::SiteType"Electron") = true
has_fermion_string(::OpName"Cdn", ::SiteType"Electron") = true
has_fermion_string(::OpName"Cdagdn", ::SiteType"Electron") = true
