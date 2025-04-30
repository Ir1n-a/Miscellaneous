using CSV
using NativeFileDialog
using Tables

function table(name,n,lim_lin,lim_col)
    f2 = pick_folder()
    r = readdir(f2, join=true)
    v = []
    h=String[]

    for file in r
        l = CSV.File(file; select=n)
        for s in 1:length(n)
        column = getproperty(l, l.names[s])
        push!(v, column)
        push!(h,split(basename(file),".")[1])
        end
        
    end

    @show length.(v)
    @show r

    cat = reduce(hcat, v)[lim_lin, lim_col]
    tbl = Tables.table(cat)
    @show h
    folder=pick_folder()
    CSV.write(joinpath(folder,"$name.CSV"), tbl, header=h[lim_col])
    print(h)
end
  
table("filename",[1,5],[1,3,5],[1,5,6,9])