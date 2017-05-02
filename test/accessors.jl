# accessors.jl

function test_qdates(from,to)
    y = m = d = 0; l = false
    for y in from:to
        for m = 1:12
            for l = false:true
                for d = 1:QDates.daysinmonth(y,m,l)
                    qdt = QDates.QDate(y,m,l,d)
                    @test y == Dates.year(qdt)== QDates.year(qdt)
                    @test m == Dates.month(qdt)== QDates.month(qdt)
                    @test l == QDates.isleapmonth(qdt)
                    @test d == Dates.day(qdt)== QDates.day(qdt)
                    @test (y, m) == Dates.yearmonth(qdt)== QDates.yearmonth(qdt)
                    @test (m, d) == Dates.monthday(qdt)== QDates.monthday(qdt)
                    @test (y, m, d) == Dates.yearmonthday(qdt)== QDates.yearmonthday(qdt)
                    @test (y, m, l) == QDates.yearmonthleap(qdt)
                    @test (m, l, d) == QDates.monthleapday(qdt)
                    @test (y, m, l, d) == QDates.yearmonthleapday(qdt)
                end
            end
        end
    end
end
test_qdates(445,2100)

# broadcasting
a = QDates.QDate(2014,1,1)
dr = [a,a,a,a,a,a,a,a,a,a]
@test QDates.year.(dr) == repmat([2014],10)
@test QDates.month.(dr) == repmat([1],10)
@test QDates.isleapmonth.(dr) == repmat([false],10)
@test QDates.day.(dr) == repmat([1],10)
