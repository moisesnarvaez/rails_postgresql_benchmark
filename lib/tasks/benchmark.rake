require 'benchmark'

def bm(proc1, proc2, name1='Old', name2='New', times=100)
  puts "Running #{100} times"
  Benchmark.bmbm(100) do |x|
    x.report(name1) { @olr = proc1.call }
    x.report(name2) { @nr = proc2.call }
  end
end


namespace :benchmark do
  task :business_types do
    query1 = "SELECT businesses.* FROM businesses JOIN business_types ON businesses.id=business_types.business_id WHERE business_types.label IN ('Banking', 'Construction')"
    query2 = "SELECT businesses.* FROM businesses WHERE business_types_jsonb ?| array['Banking', 'Construction']"
    bm(
      Proc.new {Business.find_by_sql(query1)},
      Proc.new {Business.find_by_sql(query2)},
      "JOIN Table",
      "JSONB Array",
      10
    )
  end
end

