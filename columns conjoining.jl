using CSV
using NativeFileDialog
using Tables

function table(name,n)
    f2 = pick_folder()
    r = readdir(f2, join=true)
    v = []
    h=[]
    for file in r
        l = CSV.File(file; select=[n])
        column = getproperty(l, l.names[1])
        push!(v, column)
        push!(h,split(basename(file),".")[1])
    end

    cat = reduce(hcat, v)
    tbl = Tables.table(cat)
    CSV.write("$name.CSV", tbl, header=h)
    print(h)
end
  
table("filename",2)