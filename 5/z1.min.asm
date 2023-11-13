global wartosc
wartosc:fld qword [esp+36]
fld qword [esp+4]
fmulp 
fld qword [esp+12]
faddp
fld qword [esp+36]
fmulp
fld qword [esp+20]
faddp
fld qword [esp+36]
fmulp
fld qword [esp+28]
faddp
ret
