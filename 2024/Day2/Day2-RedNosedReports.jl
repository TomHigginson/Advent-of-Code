using CSV
using DataFrames

# Is it sorted? Is it sortde AND within an appropriate adjacent range?
# Also now part to with the problem damper is included in this function



function GoodReport(row::Vector{Int})
    Descending = issorted(row, rev=false)
    Ascending = issorted(row, rev=true)
    Adjacent = []
    for i in 1:(length(row)-1)
        diff = abs(row[i] - row[i+1])
        push!(Adjacent, diff)
    end 

    if (Descending || Ascending) && all(x -> x in 1:3, Adjacent)
        println("Successful Row: ", row)
        return all(abs(row[i] - row[i+1]) in 1:3 for i in 1:(length(row)-1))


    # This is for part 2: we can ignore the 'good' rows and only focus on the 'bad' rows.

    else
        # Is one element out of place?

        for i in 1:(length(row))
            temp_row = vcat(row[1:i-1], row[i+1:end])
            Descending = issorted(temp_row, rev=false)
            Ascending = issorted(temp_row, rev=true)
            Adjacent = []
            for i in 1:(length(temp_row)-1)
                diff = abs(temp_row[i] - temp_row[i+1])
                push!(Adjacent, diff)
            end 

            if (Descending || Ascending) && all(x -> x in 1:3, Adjacent)
                return all(abs(temp_row[i] - temp_row[i+1]) in 1:3 for i in 1:(length(temp_row)-1))
            end
        end
                
    end

    return false

end

reports = CSV.read("Real.csv", DataFrame, header = false, delim = ",")

FinalReports = [row for row in eachrow(reports) if GoodReport([x for x in collect(row) if !ismissing(x)])]

result = DataFrame(FinalReports)

Total = nrow(result)

